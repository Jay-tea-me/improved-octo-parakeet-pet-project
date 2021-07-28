//
//  MessageAnnotation.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/28.
//

import Foundation
import MapKit
import Combine

struct MessageAnnotation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(geoMessage: GeoMessage) {
        
        self.latitude = geoMessage.latitude
        self.longitude = geoMessage.longitude
//        & = access property of geomessage
    }
}
