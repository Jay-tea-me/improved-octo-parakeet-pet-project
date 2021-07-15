//
//  ContentView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI
import Combine
import RealityKit

struct ContentView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    //transformEnvironmentModifier(.\self){ dump($0) }
    var body: some View {
        
        if signInViewModel.isSignedIn {
            LandingView()
                .environmentObject(signInViewModel)
        } else {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(SignInViewModel(authenticationService: GoogleAuth()))
    }
}
