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
    let latitudeBounds: Double = 180
    let longitudeBounds: Double = 85
    
    var range: Double
    
    var latitude: Double
    
    var longitude: Double
    
    var lowerBoundLatitude: Double { clampCoordinates(latitude - range, boundedBy: latitudeBounds) }
    
    var upperBoundLatitude: Double { clampCoordinates(latitude + range, boundedBy: latitudeBounds) }
    
    var lowerBoundLongitude: Double { clampCoordinates(longitude - range, boundedBy: longitudeBounds) }

    var upperBoundLongitude: Double { clampCoordinates(longitude + range, boundedBy: longitudeBounds) }
    
    private func clampCoordinates(_ oldValue: Double,boundedBy bounds: Double) -> Double {
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
    
    
}
