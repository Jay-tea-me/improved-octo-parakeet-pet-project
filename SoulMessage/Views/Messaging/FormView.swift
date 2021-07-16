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
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    var didAddMessage: (_ geoMesage: GeoMessage) -> Void
    
    var body: some View{
            VStack {
                Text("New Message")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Form {
                    TextField ("Base phrase", text: $basePhrase)
                    TextField ("Added phrase", text: $addedPhrase)
                    TextField ("latitude", text: $latitude)
                    TextField ("longitude", text: $longitude)
                }
                Button("Engrave Into World") {
                    
                    let geoMessage = GeoMessage(sender: "Jay", body: "\(basePhrase) \(addedPhrase)", latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0, dated: Date().timeIntervalSince1970 )
                    didAddMessage(geoMessage)
                }.disabled(basePhrase.isEmpty).padding()
            }.navigationTitle("New Message")
        
    }
}

