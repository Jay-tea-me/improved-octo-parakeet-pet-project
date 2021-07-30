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
        @Published var geoMessageRepository = GeoMessageRepository()
        @Published var listMessageAnnotations: [MessageAnnotation] = []
        @Published var mapLocationManager = MapLocationManager()

        private var cancellables: Set<AnyCancellable> = []

        private let distance: Double = 1000

        init() {
            MapLocationManager.setMode(mode: .map)

            geoMessageRepository.$geoMessages
                      .map { geoMessage in
                        geoMessage.map(MessageAnnotation.init)
                      }
                      .assign(to: \.listMessageAnnotations, on: self)
                      .store(in: &cancellables)
        }
    }
}
