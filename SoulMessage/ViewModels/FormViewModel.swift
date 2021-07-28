//
//  FormViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/23.
//

import Foundation

extension FormViewController {
    class ViewModel: ObservableObject {
        @Published private(set) var geoMessage: GeoMessage

        internal let phrase1Data = ["A", "B", "C", "D"]
        internal let phrase2Data = ["0", "1", "2", "3"]
        internal let phrase1LabelText = "BASE PHRASE"
        internal let phrase2LabelText = "ADDITIONAL PHRASE"

        internal var phrase1: String = ""
        internal var phrase2: String = ""
        internal var latitude = 0
        internal var longitude = 0

        init() {
            phrase1 = phrase1Data[0]
            phrase2 = phrase2Data[0]
            geoMessage = GeoMessage(
                sender: "JAY",
                body: "",
                latitude: Double(0),
                longitude: Double(0)
            )
        }

        public func updateGeoMessage() {
            geoMessage = GeoMessage(
                sender: "JAY",
                body: "\(phrase1) \(phrase2)",
                latitude: Double(latitude),
                longitude: Double(longitude),
                dated: Date().timeIntervalSince1970
            )
        }

        public var outputMessage: String {
            "MESSAGE: \(phrase1) \(phrase2)"
        }

        public var coordinates: String {
            "COORDINATES: (\(latitude), \(longitude))"
        }
    }
}
