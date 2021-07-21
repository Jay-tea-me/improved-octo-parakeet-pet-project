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

protocol Server {
    func userDetails() -> AnyPublisher<User?, Never>
    func serverChange() -> AnyPublisher<User?, Never>?
}

class MockServer: Server {
    var isSignedIn = false
    var cancellable: AnyCancellable!
//    publisher
    let serverStateSub = PassthroughSubject<User?, Never>()
    
    func userDetails() -> AnyPublisher<User?, Never> {
        return Future<User?,Never> { [self] promise in
            serverStateSub.sink { user in
                if user == nil {
                    self.isSignedIn = false
                    return promise(.success(nil))
                } else {
                    self.isSignedIn = true
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func serverChange() -> AnyPublisher<User?, Never>? {
        return Future<User?,Never> { [self] promise in
            serverStateSub.sink { user in
                if user == nil && isSignedIn {
                    self.isSignedIn = false
                    return promise(.success(nil))
                } else if user != nil && !isSignedIn {
                    self.isSignedIn = true
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
}

final class MockAuthenticationService: AuthenticationServices  {
    let serverMock: MockServer!

    init(serverMock: MockServer = MockServer()){
        self.serverMock = serverMock
    }
    
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
//        serverMock.serverStateSub.send(User())
//        return Future<Any,Error> { [self] promise in
//            serverMock.serverStateSub.sink { user in
//                if let user = user {
//                    return promise(.success(user))
//                } else {
//                    return promise(.failure(Error.self as! Error))
//                }
//            }
////            serverMock.userDetails().sink { user in
////                } else if user != nil && !isSignedIn {
////                    self.isSignedIn = true
////                    return promise(.success(user))
////                }
////            }
//        }.eraseToAnyPublisher()
        signoutSub.eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher <User?, Never> {
//        serverMock.serverChange()!
//            .eraseToAnyPublisher()
        print("observing change")
        return serverStateSub.eraseToAnyPublisher()
    }
}
        
    

