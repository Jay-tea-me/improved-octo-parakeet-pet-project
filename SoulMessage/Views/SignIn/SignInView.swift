//
//  SignInView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI
import GoogleSignIn

struct SignInView: View {
//    @EnvironmentObject var signInViewModel:  SignInViewModel
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIColor(.white)]
    }
    
    var body: some View {
        NavigationView {
        GeometryReader { geometry in
            let width: CGFloat = min(geometry.size.width, geometry.size.height)
            let height = width
            VStack{
                VStack(alignment: .center, spacing: 40, content: {
                    Image("magic_circle").resizable().aspectRatio(contentMode: .fit)
                        
                    Text("SOUL MESSAGE")
                        .font(.largeTitle)
                        .bold()
                }).frame(width: width, height: height, alignment: .center)
                .offset(x: 0, y: width / 3)
                VStack{
                        IntegratedSignInController()
                    

                }.frame(height: 100, alignment: .bottom)
                .offset(x: 0, y: -width / 3)
                
            }
        }
            
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .preferredColorScheme(.dark)
//            .environmentObject(SignInViewModel(authenticationService: GoogleAuth()))
    }
}
