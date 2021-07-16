//
//  SoulMessageApp.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI
import Firebase
import GoogleSignIn
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    GoogleAuth.configure()
    return true
  }
}

@main
struct SoulMessageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isSignedIn{
                LandingView()
            } else {
                SignInView()
            }
        }
    }
}

final class AppState: ObservableObject {
    @Published private(set) var isSignedIn = false
    
    private var authenticationService: AuthenticationServices!
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(authenticationService: AuthenticationServices = GoogleAuth()) {
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
