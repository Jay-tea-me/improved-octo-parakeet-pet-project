//
//  AuthenticationViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//
//
//import FirebaseFirestoreSwift
//import FirebaseAuth
//import GoogleSignIn
//import Combine

//class AuthenticationService: NSObject, ObservableObject {
//}
//
//    @Published private(set) var isSignedIn = false
//    private var cancellables: Set<AnyCancellable> = []
////    private var handle: AuthStateDidChangeListenerHandle?
//
//    override init() {
//        super.init()
//        alreadySignedIn()
//        observeAuthChanges()
//            .map{$0 != nil}
//            .assign(to: &$isSignedIn)
//    }
//
//    func setupUpGoogleSignIn(){
////        GIDSignIn.sharedInstance.delegate = self
//    }
//
//    func alreadySignedIn(){
//        if let _ = Auth.auth().currentUser {
//            isSignedIn = true
//        }
//    }
//
//    private func observeAuthChanges() -> AnyPublisher<User?, Never> {
//        Publishers.AuthPublisher().eraseToAnyPublisher()
//    }
//
//    private func registerStateListener() {
//        if let handle = handle {
//            Auth.auth().removeStateDidChangeListener(handle)
//        }
//
//        self.handle = Auth.auth().addStateDidChangeListener{ (auth, user) in
//
//            if let _ = user {
//                print("signed in")
////                self.state = .signedIn
//            }
//            else {
//                print("signed out")
////                self.state = .signedOut
//            }
//        }
//    }
    

//
//extension AuthenticationService: AuthenticationServices {
//    func signIn() {
////        if GIDSignIn.sharedInstance.currentUser != nil { return }
////        GIDSignIn.sharedInstance.presentingViewController = UIApplication.shared.windows.first?.rootViewController
////        print("trying to sign in")
////
////        GIDSignIn.sharedInstance.signIn(with: GIDConfiguration(, presenting: UIApplication.shared.windows.first?.rootViewController)
//    }
//
//    func signOut() {
//        GIDSignIn.sharedInstance.signOut()
//        do {
//            try Auth.auth().signOut()
//            print("signing out maybe")
//        } catch let signOutError as NSError {
//            print (signOutError.localizedDescription)
//        }
//    }
//}
//
//extension AuthenticationService: GIDSignInDelegate {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print (error.localizedDescription)
//            return
//        }
//        authenticate(user)
//    }
//
//    func authenticate(_ user: GIDGoogleUser) {
//
//        print("Trying to Authenticate")
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//            if let error = error{
//                print (error.localizedDescription)
//            } else {
////                print("signed in")
//            }
//        }
//    }
//}

