//
//  SoulMessageApp.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI
import Firebase
import GoogleSignIn

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
    @StateObject var signInViewModel = SignInViewModel(authenticationService: GoogleAuth())
    
    var body: some Scene {
        WindowGroup {
            if signInViewModel.isSignedIn{
                LandingView()
                    .environmentObject(signInViewModel)
            } else {
                SignInView()
                    .environmentObject(signInViewModel)
            }
        }
    }
}
