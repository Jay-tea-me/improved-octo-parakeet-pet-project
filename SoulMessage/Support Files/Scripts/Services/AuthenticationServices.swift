//
//  AuthenticationServiceProtocol.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//
import Combine

#if canImport(FirebaseAuth)
import FirebaseAuth
import Firebase
#endif
    
protocol AuthenticationServices {
    func signIn() -> AnyPublisher <User, Error>
    func signOut() -> AnyPublisher <Any, Error>
    func currentUser() -> AnyPublisher <User?, Never>
    func observeAuthChanges() -> AnyPublisher <User?, Never>
}
