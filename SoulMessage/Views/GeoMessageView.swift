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
            .fill(Color.gray)
            .frame(height: 200)
            .overlay(ZStack{
                VStack{
                    Text(geoMessageViewModel.geoMessage.body)
                        .fixedSize()
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()

                    Spacer()
                    Text("~\(geoMessageViewModel.geoMessage.sender)")
                        .foregroundColor(.white)
                        .padding(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    Text("(\(geoMessageViewModel.geoMessage.longitude), \(geoMessageViewModel.geoMessage.latitude)) ")
                        .foregroundColor(.white)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            })
    }
}


//struct GeoMessage_Previews: PreviewProvider {
//    static var previews: some View {
//        GeoMessageView()
//            .preferredColorScheme(.dark)
//            .previewLayout(.sizeThatFits)
//    }
//}
