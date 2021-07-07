//
//  FormView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//


import SwiftUI

struct FormView: View {
    //todo create dropdown list to choose from
    @State private var basePhrase: String = ""
    @State private var addedPhrase: String = ""
    
    var didAddMessage: (_ geoMesage: GeoMessage) -> Void
    
    var body: some View{
        NavigationView {
            VStack {
                Form {
                    TextField ("base phrase", text: $basePhrase)
                    TextField ("Answer", text: $addedPhrase)
                }
                Button("Create Card") {
                    
                    let geoMessage = GeoMessage(sender: "Jay", body: "\(basePhrase)+\(addedPhrase)", latitude: 1, longitude: 1, dated: Date().timeIntervalSince1970 )
                    didAddMessage(geoMessage)
                }.disabled(basePhrase.isEmpty).padding()
            }.navigationTitle("New Study Card")
        }
    }
}

