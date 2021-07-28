//
//  FormViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/23.
//

import Foundation
import Combine
import MapKit

extension FormViewController {
    class ViewModel: ObservableObject {
        @Published private(set) var geoMessage: GeoMessage

        internal let phrase1Data = ["A", "B", "C", "D"]
        internal let phrase2Data = ["0", "1", "2", "3"]
        internal let phrase1LabelText = "BASE PHRASE"
        internal let phrase2LabelText = "ADDITIONAL PHRASE"

        internal var phrase1: String = ""
        internal var phrase2: String = ""
        @Published internal var coordinates2D: CLLocationCoordinate2D

        init() {
            coordinates2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            phrase1 = phrase1Data[0]
            phrase2 = phrase2Data[0]
            geoMessage = GeoMessage(
                sender: "JAY",
                body: "",
                latitude: 0,
                longitude: 0
            )
            CLLocationManager.publishLocation()
                .map { $0 }
                .assign(to: &$coordinates2D)

        }

        public func updateGeoMessage() {
            geoMessage = GeoMessage(
                sender: "JAY",
                body: "\(phrase1) \(phrase2)",
                latitude: Double(coordinates2D.latitude),
                longitude: Double(coordinates2D.longitude),
                dated: Date().timeIntervalSince1970
            )
        }

        public var outputMessage: String {
            "MESSAGE: \(phrase1) \(phrase2)"
        }
    }
}
