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
    @State private var trackingMode: MapUserTrackingMode = .follow

    var body: some View {
        Map(
            coordinateRegion: $viewModel.mapLocationManager.region,
            showsUserLocation: true,
            userTrackingMode: $trackingMode,
            annotationItems: $viewModel.listMessageAnnotations.wrappedValue) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
                            Image(systemName: "face.smiling")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
            .ignoresSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
