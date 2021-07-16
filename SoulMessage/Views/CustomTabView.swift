//
//  CustomTabView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/15.
//

import SwiftUI

struct CustomTabView: View {
    let tabBarItem: [String]
    let text: [Text]
    var content: [AnyView]
    
    @State var selectedIndex = 0
    
    var body: some View {
        VStack {
            ZStack{
                switch selectedIndex {
                case selectedIndex:
                    NavigationView {
                        content[selectedIndex]
                            .navigationTitle(text[selectedIndex]).foregroundColor(.white)
                    }
                default:
                    Text("Remaining")
                }
            }
            
            Spacer()
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                ForEach(0..<tabBarItem.count) { num in
                    Button(action: {selectedIndex = num}, label: {
                        Spacer()
                        Image(systemName: tabBarItem[num])
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(
                                selectedIndex == num ? .white : .gray )
                        Spacer()
                    })
                }
                
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(
        tabBarItem: [ "message", "globe", "person"],
        text: [Text("1"), Text("2"), Text("3")],
            content:[AnyView(ProfileView()), AnyView(ProfileView()),AnyView(ProfileView())])
            .preferredColorScheme(.dark)
    }
}
