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
        @Published var listMessageAnnotations: [MessageAnnotation] = []

        private var cancellables: Set<AnyCancellable> = []

        private let distance: Double = 1000

        init() {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                latitudinalMeters: distance,
                longitudinalMeters: distance)

            CLLocationManager.publishLocation()
                .map { self.getRegion($0, distance: 50) }
                .assign(to: &$region)

            geoMessageRepository.$geoMessages
                      .map { geoMessage in
                        geoMessage.map(MessageAnnotation.init)
                      }
                      .assign(to: \.listMessageAnnotations, on: self)
                      .store(in: &cancellables)
        }

        private func getRegion(_ coordinates: CLLocationCoordinate2D, distance: Double) -> MKCoordinateRegion {
            print("getting region")

            return MKCoordinateRegion(
                center: coordinates, latitudinalMeters: distance, longitudinalMeters: distance
            )
        }

    }
}
