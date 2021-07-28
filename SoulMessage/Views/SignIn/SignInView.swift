//
//  SignInView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import SwiftUI

struct SignInView: View {

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width

                VStack {

                    VStack(alignment: .center, spacing: 40, content: {
                        Image("magic_circle").resizable().aspectRatio(contentMode: .fit)

                        Text("SOUL MESSAGE")
                            .font(.largeTitle)
                            .bold()
                    })
                    .frame(width: width * 3 / 4, height: height * 3 / 4, alignment: .center)
                    .offset(x: 0, y: width / 4)

                    Spacer()

                    VStack(alignment: .center, spacing: 0, content: {
                        IntegratedSignInViewController()
                            .contentShape(Rectangle())

                    })
                    .frame(maxWidth: .infinity)
                    .offset(x: geometry.size.width/3, y: width/2 )

                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .preferredColorScheme(.dark)
    }
}
