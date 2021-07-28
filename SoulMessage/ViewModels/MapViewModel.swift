//
//  MapViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/28.
//

import Foundation
import MapKit
import Combine
import CoreLocation

extension MapView {
    class ViewModel: ObservableObject {
        @Published var region = MKCoordinateRegion()

        @Published var geoMessageRepository = GeoMessageRepository()
        @Published var listGeoMessageViewModel: [GeoMessageViewModel] = []

        private var cancellables: Set<AnyCancellable> = []

        private let distance = 1000

        init() {
            print("Is Maps working")
            CLLocationManager.publishLocation()
                .map { self.getRegion($0, distance: 50) }
                .assign(to: &$region)
        }

        private func getRegion(_ coordinates: CLLocationCoordinate2D, distance: Double) -> MKCoordinateRegion {
            print("getting region")
            let areaCalculator = MessageAreaCalculator.init(
                distance: distance, latitude: coordinates.latitude, longitude: coordinates.longitude)

            return MKCoordinateRegion(
                center: coordinates,
                span: MKCoordinateSpan(
                    latitudeDelta: areaCalculator.latitudeDelta,
                    longitudeDelta: areaCalculator.longitudeDelta)
            )
        }

    }
}
