//
//  MockAuthenticationService.swift
//  SoulMessageTests
//
//  Created by Justine Wright on 2021/07/19.
//

import Foundation
import Combine

struct User {
    var id: String?
}

final class MockAuthenticationService: AuthenticationServices  {
    
    let serverStateSub = PassthroughSubject<User?, Never>()
    let signinSub = PassthroughSubject<User, Error>()
    let signoutSub = PassthroughSubject<Any, Error>()
    let currentUserSub = PassthroughSubject<User?, Never>()
    
    func signIn() -> AnyPublisher<User, Error> {
        return signinSub.eraseToAnyPublisher()
    }

    func currentUser() -> AnyPublisher<User?, Never> {
        currentUserSub.eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher <Any, Error> {
        signoutSub.eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher <User?, Never> {
        return serverStateSub.eraseToAnyPublisher()
    }
}
        
    

