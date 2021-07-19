//
//  SignOutView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI
import GoogleSignIn

struct ProfileView: View {
    var body: some View {
        VStack{
            IntegratedSignOutController()

        }.frame(height: 100, alignment: .bottom)
        .offset(x: 0, y: -100)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
