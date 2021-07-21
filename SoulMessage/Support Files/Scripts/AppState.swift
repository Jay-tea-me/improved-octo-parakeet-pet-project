//
//  AppState.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/19.
//

import Foundation
import Combine

final class AppState: ObservableObject {
    @Published private(set) var isSignedIn = false
    
    private var authenticationService: AuthenticationServices
    
    private var cancellables: Set<AnyCancellable> = []

    init(authenticationService: AuthenticationServices ) {
        self.authenticationService = authenticationService
        self.authenticationService.observeAuthChanges()
            .map{ $0 != nil }
            .assign(to: &$isSignedIn)
        checkSignInStatus()
    }

    func checkSignInStatus(){
        authenticationService.currentUser()
            .map{ $0 != nil }
            .sink { isSignedIn in
                self.isSignedIn = isSignedIn
            }
            .store(in: &cancellables)
    }
}
