//
//  MessageAreaCalculator.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/08.
//

import Foundation
import CoreLocation

// Google
// Latitude: -85 to +85
// Longitude: -180 to +180

struct MessageAreaCalculator {
    let earthCircumference: Double = 40075.0
    let oneDegreeOfLatitudeInMeters: Double = 111.32 * 1000.0

    let latitudeBounds: Double = 180
    let longitudeBounds: Double = 85

    let distance: Double

    var latitude: Double
    var longitude: Double

    // Methods used for filtering messages from the repository

    var lowerBoundLatitude: Double { clampCoordinates(latitude - latitudeDelta, boundedBy: latitudeBounds) }
    
    var upperBoundLatitude: Double { clampCoordinates(latitude + latitudeDelta, boundedBy: latitudeBounds) }
    
    var lowerBoundLongitude: Double { clampCoordinates(longitude - longitudeDelta, boundedBy: longitudeBounds) }

    var upperBoundLongitude: Double { clampCoordinates(longitude + longitudeDelta, boundedBy: longitudeBounds) }
    
    private func clampCoordinates(_ oldValue: Double, boundedBy bounds: Double) -> Double {
        if oldValue == 0 {
            return oldValue
        }
        let quotient = oldValue > 0 ?
            (oldValue/bounds).rounded(.down) :
            (oldValue/bounds).rounded(.up)
        
        if quotient != 0 {
            let remainder = oldValue.truncatingRemainder(dividingBy: bounds)
            let sign = oldValue / (oldValue.magnitude)
            return (-sign)*bounds * quotient + sign * remainder
        }
        return oldValue
    }

    // Methods used to calculate map area
    var angularDistance: Double {
        distance / 2.0 / earthCircumference
    }
    var longitudeDelta: Double {
        return  abs(atan2(
                        sin(angularDistance) * cos(latitude),
                        cos(angularDistance) - sin(latitude) * sin(latitude)))
    }

    var latitudeDelta: Double {
        return distance / 2.0 / oneDegreeOfLatitudeInMeters
    }
}
