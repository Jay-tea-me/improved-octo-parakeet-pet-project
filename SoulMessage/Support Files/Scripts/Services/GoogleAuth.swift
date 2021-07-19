//
//  GoogleAuth.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/15.
//

import Combine
import GoogleSignIn
import FirebaseAuth
import Firebase


final class GoogleAuth: AuthenticationServices  {
    
    static private var signInConfig: GIDConfiguration!
    
    static func configure() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        signInConfig = GIDConfiguration(clientID: clientID)
    }

    func signIn() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            GIDSignIn.sharedInstance.signIn(with: GoogleAuth.signInConfig, presenting: (UIApplication.shared.windows.first?.rootViewController)!) {user, error in
                if let error = error {
                    return promise(.failure(error))
                } else if let GIDuser = user {
                    self.authenticate(GIDuser) { result in
                        switch result {
                        case let .success(user):
                            return promise(.success(user!))
                        case let .failure(error):
                            return promise(.failure(error))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func authenticate(_ user: GIDGoogleUser?, completion: @escaping (Result<User?, Error>) -> Void) {
        guard let authentication = user?.authentication else {return}
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken!,
            accessToken: authentication.accessToken
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion (.failure(error))
                
            } else if let user = authResult?.user{
                completion (.success(user))
            }
        }
    }

    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher <Any, Error> {
        return Future<Any, Error> { promise in
            GIDSignIn.sharedInstance.signOut()
            do {
                try Auth.auth().signOut()
                return promise(.success(()))
            } catch let signOutError as NSError {
                print (signOutError.localizedDescription)
                return promise(.failure(signOutError))
            }
        }.eraseToAnyPublisher()
    }
    
    func observeAuthChanges()-> AnyPublisher <User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
}
        
    
