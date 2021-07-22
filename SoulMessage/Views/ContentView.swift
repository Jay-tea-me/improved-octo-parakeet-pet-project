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

     var body: some View {
        SignInView()
            .fullScreenCover(isPresented: $signInViewModel.isSignedIn, content: {
                LandingView()
            })
      }
    func containedView() -> AnyView {
        if signInViewModel.isSignedIn {
            return AnyView(LandingView())
        } else {
            return AnyView(SignInView())

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
