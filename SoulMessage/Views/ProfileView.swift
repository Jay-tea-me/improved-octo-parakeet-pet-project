//
//  SignOutView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI
import GoogleSignIn

struct ProfileView: View {
    @EnvironmentObject var authService:   AuthenticationService
    private let user = GIDSignIn.sharedInstance().currentUser
    
    var body: some View {
        VStack {
            Button(action: {authService.signOut()}, label: {
                Text("Sign Out")
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
