//
//  GeoMessageView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import SwiftUI


struct GeoMessageView: View {
    var geoMessageViewModel: GeoMessageViewModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.black)
            .frame(height: 100)
            .border(Color.white)
            .overlay(ZStack{
                VStack{
                    Text(geoMessageViewModel.geoMessage.body).padding().font(.custom("Palatino-Bold", size: 20)).foregroundColor(.white)

                    Text(geoMessageViewModel.geoMessage.sender) .frame(maxWidth: .infinity, alignment: .trailing).font(.custom("ZapfinoiPhoneiPad", size: 15)).foregroundColor(.white)
                    
                    Text("\(geoMessageViewModel.geoMessage.longitude), \(geoMessageViewModel.geoMessage.latitude) ").frame(maxWidth: .infinity, alignment: .trailing)
                }
            })
        
        
    }
}

//
//struct GeoMessage_Previews: PreviewProvider {
//    static var previews: some View {
//        GeoMessageView()
//            .preferredColorScheme(.dark)
//            .previewLayout(.sizeThatFits)
//    }
//}
