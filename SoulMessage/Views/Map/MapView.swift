//
//  MapView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/16.
//

import SwiftUI
import MapKit
import Combine

struct PlaceAnnotationView: View {
  var body: some View {
    VStack(spacing: 0) {
      Image(systemName: "message")
        .font(.title)
        .foregroundColor(.red)
    }
  }
}

struct MapView: View {
    @ObservedObject private var viewModel = ViewModel()
    @State private var trackingMode: MapUserTrackingMode = .follow

    var body: some View {
        Map(
            coordinateRegion: $viewModel.mapLocationManager.region,
            showsUserLocation: true,
            userTrackingMode: $trackingMode,
            annotationItems: $viewModel.listMessageAnnotations.wrappedValue) { place in
            MapAnnotation(coordinate: place.coordinate) {
                          PlaceAnnotationView()
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
