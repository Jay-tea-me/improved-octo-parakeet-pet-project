//
//  MapView.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/16.
//

import SwiftUI
import MapKit

struct MapView: View {
//    var coordinate: CLLocationCoordinate2D
//    @State private var region = MKCoordinateRegion()
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region)
            .ignoresSafeArea(edges: .all)
    }
//
//    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
//        region = MKCoordinateRegion(
//            center: coordinate,
//            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//        )
//    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
