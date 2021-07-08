//
//  GeoMessageListView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import SwiftUI

struct GeoMessageListView: View {
    @ObservedObject var geoMessageListViewModel: GeoMessageListViewModel = GeoMessageListViewModel()
    @State private var showingForm = false

    var body: some View {

            ZStack{
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                VStack{

                    List {
                        ForEach(geoMessageListViewModel.listGeoMessageViewModel) {message in
                            GeoMessageView(geoMessageViewModel: message)
                        }
                    }.onAppear() {
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITableViewCell.appearance().backgroundColor = UIColor.clear
                    }
                    .listStyle(InsetListStyle())
                    
                    
                    Button(action: {
                        showingForm = true
                    }) {
                        Circle()
                            .fill(Color.green)
                            .frame(height: 60)
                            .overlay(Image(systemName: "plus").foregroundColor(.white))
                    }.sheet(isPresented: $showingForm) {
                        FormView {(geoMessage) in
                            geoMessageListViewModel.add(geoMessage)
                            showingForm = false
                        }
                    }
                }
            }
        
    }
}
