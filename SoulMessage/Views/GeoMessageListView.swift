//
//  GeoMessageListView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import SwiftUI

struct GeoMessageListView: View {
    @ObservedObject var geoMessageListViewModel: GeoMessageListViewModel
    @State private var showingForm = false
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(geoMessageListViewModel.geoMessageListViewModel) {message in
                        GeoMessageView(geoMessageViewModel: message)
                    }
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
                    FormView {(studyCard) in
                        geoMessageListViewModel.add(studyCard)
                        showingForm = false
                    }
                }
            }
        }
//        List(cardListViewModel.studyCards) { card in
//            Text(card.question)
//
//        }
//        Button("Add Mock Question"){
//            let card = StudyCard(question: "3 + 4", answer: "7")
//            cardListViewModel.add(card)
//        }
    }
}
