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

        init() {
            print("Is Maps working")
            CLLocationManager.publishLocation()
                .map { self.getRegion($0, distance: 50) }
                .assign(to: &$region)
        }

        private func getRegion(_ coordinates: CLLocationCoordinate2D, distance: Double) -> MKCoordinateRegion {

            let distance = distance / 2.0
            let earthCircumference = 40075.0
            let oneDegreeOfLatitudeInMeters = 111.32 * 1000.0
            let angularDistance = distance / earthCircumference

            let latitudeDelta = distance / oneDegreeOfLatitudeInMeters

            let latitude = coordinates.latitude
            let longitudeDelta = abs(atan2(
                                            sin(angularDistance) * cos(latitude),
                                            cos(angularDistance) - sin(latitude) * sin(latitude)))
            return MKCoordinateRegion(
                center: coordinates,
                span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            )
        }

    }
}
