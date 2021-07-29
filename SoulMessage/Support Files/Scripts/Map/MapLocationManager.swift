//
//  MapLocationManager.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/29.
//
import Foundation
import MapKit
import Combine
import CoreLocation

class MapLocationManager: ObservableObject {
    public enum DistanceMode: Double {
        case map = 100
        case ar = 10
    }
    @Published var region = MKCoordinateRegion()

    init(locationMode: DistanceMode) {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            latitudinalMeters: locationMode.rawValue,
            longitudinalMeters: locationMode.rawValue)

        CLLocationManager.publishLocation()
            .map { self.getRegion($0, distance: locationMode.rawValue) }
            .assign(to: &$region)
    }

    var lowerBoundLatitude: Double { region.center.latitude - region.span.latitudeDelta / 2 }
    var upperBoundLatitude: Double { region.center.latitude + region.span.latitudeDelta / 2 }
    var lowerBoundLongitude: Double { region.center.longitude - region.span.longitudeDelta / 2 }
    var upperBoundLongitude: Double { region.center.longitude + region.span.longitudeDelta / 2 }

    func getRegion(_ coordinates: CLLocationCoordinate2D, distance: Double) -> MKCoordinateRegion {
        print("getting region")

        return MKCoordinateRegion(
            center: coordinates, latitudinalMeters: distance, longitudinalMeters: distance
        )
    }

    func getCoordinates(_ coordinates: CLLocationCoordinate2D, distance: Double) ->  CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)
    }

}
