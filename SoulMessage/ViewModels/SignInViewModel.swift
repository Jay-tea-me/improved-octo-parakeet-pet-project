//
//  SignInViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/15.
//

import Foundation
import Combine

final class SignInViewModel: ObservableObject {
    let title = "SOUL MESSAGE"

    @Published var isSignedIn = false
    @Published var error: Error?

    private var authenticationService: AuthenticationServices!
    private var cancellables: Set<AnyCancellable> = []

    init(authenticationService: AuthenticationServices) {
        self.authenticationService = authenticationService
        self.authenticationService.observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isSignedIn)
        alreadySignedIn()
    }

    func signin() {
        _ = authenticationService.signIn()
    }

    func signout() {
        _ = authenticationService.signOut()
    }

    func alreadySignedIn() {
        authenticationService.currentUser()
            .map { $0 != nil }
            .sink { isSignedIn in
                self.isSignedIn = isSignedIn
            }
            .store(in: &cancellables)

    }

}
