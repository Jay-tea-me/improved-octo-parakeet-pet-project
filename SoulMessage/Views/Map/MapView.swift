//
//  MapView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/16.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    @ObservedObject private var viewModel = ViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: $viewModel.listGeoMessageViewModel.wrappedValue) { geomessageVM in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: geomessageVM.geoMessage.latitude, longitude: geomessageVM.geoMessage.latitude)) {
                Image(systemName: "Message")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
