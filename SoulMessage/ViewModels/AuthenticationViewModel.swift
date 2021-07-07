//
//  AuthenticationViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import Firebase
import GoogleSignIn
import Combine

class AuthenticationViewModel: NSObject, ObservableObject {
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    
    override init() {
        super.init()
        
        setupUpGoogleSignIn()
    }
    
    func setupUpGoogleSignIn(){
        GIDSignIn.sharedInstance().delegate = self
    }
    
}

extension AuthenticationViewModel: AuthenticationServices {
    func signIn() {
        if GIDSignIn.sharedInstance().currentUser != nil { return }
        GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
        print("trying to sign in")
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
        do {
            try Auth.auth().signOut()
            print("signing out maybe")
            state = .signedOut
        } catch let signOutError as NSError {
            print (signOutError.localizedDescription)
        }
    }
}

extension AuthenticationViewModel: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print (error.localizedDescription)
            return
        }
        authenticate(user)
        
    }
    
    func authenticate(_ user: GIDGoogleUser) {
        
        print("Trying to Authenticate")
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error{
                print (error.localizedDescription)
            } else {
                print("signed in")
                self.state = .signedIn
            }
        }
    }
}
