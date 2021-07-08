//
//  SignInView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI
import GoogleSignIn

struct SignInView: View {
    @EnvironmentObject var viewModel:  AuthenticationService
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIColor(.white)]
    }
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("magic_circle").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .center)
                Text("Soul Message")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                Spacer()
                Button(action: {viewModel.signIn()}, label: {
                    HStack{
                        Image("ic_google").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text("Sign In with Google")
                            .foregroundColor(.white)
                            .font(Font.system(size: 20))
                    }
                    //                Text("GoogleSignIn")
                    
                })
                .padding()
                .shadow(color: .gray, radius: 4)
                Spacer()
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
