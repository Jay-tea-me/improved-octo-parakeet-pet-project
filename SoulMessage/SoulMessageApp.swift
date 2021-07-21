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
    for family in UIFont.familyNames.sorted() {
        let names = UIFont.fontNames(forFamilyName: family)
        print("Family: \(family) Font names: \(names)")
    }
    
    FirebaseApp.configure()
    GoogleAuth.configure()
    return true
  }
}

@main
struct SoulMessageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState(authenticationService: GoogleAuth())
    
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


