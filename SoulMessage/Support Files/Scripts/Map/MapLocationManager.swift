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
    private(set) var initialised = false
    @Published var region = MKCoordinateRegion()

    let lowerBoundsLatitudePublisher = PassthroughSubject<Double, Never>()
    let upperBoundsLatitudePublisher = PassthroughSubject<Double, Never>()
    let lowerBoundsLongitudePublisher = PassthroughSubject<Double, Never>()
    let upperBoundsLongitudePublisher = PassthroughSubject<Double, Never>()

    @Published var lowerBoundsLatitude: Double = 0
    @Published var upperBoundsLatitude: Double = 0
    @Published var lowerBoundsLongitude: Double = 0
    @Published var upperBoundsLongitude: Double = 0

    static var locationMode: DistanceMode = DistanceMode.map
    private var cancellables: Set<AnyCancellable> = []

    init() {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            latitudinalMeters: MapLocationManager.locationMode.rawValue,
            longitudinalMeters: MapLocationManager.locationMode.rawValue)

        CLLocationManager.publishLocation()
            .map { self.getRegion($0, distance: MapLocationManager.locationMode.rawValue) }
            .assign(to: &$region)

        upperBoundsLatitudePublisher
            .sink(receiveValue: { value in
                self.upperBoundsLatitude = value
            })
            .store(in: &cancellables)

        lowerBoundsLatitudePublisher
            .sink(receiveValue: { value in
                self.lowerBoundsLatitude = value
            })
            .store(in: &cancellables)

        upperBoundsLongitudePublisher
            .sink(receiveValue: { value in
                self.upperBoundsLongitude = value
            })
            .store(in: &cancellables)

        lowerBoundsLongitudePublisher
            .sink(receiveValue: { value in
                self.lowerBoundsLongitude = value
            })
            .store(in: &cancellables)
    }

    func getRegion(_ coordinates: CLLocationCoordinate2D, distance: Double) -> MKCoordinateRegion {
        let newRegion = MKCoordinateRegion(
            center: coordinates, latitudinalMeters: distance, longitudinalMeters: distance
        )
        let lowerBoundsLatitude =  newRegion.center.latitude - newRegion.span.latitudeDelta / 2
        self.lowerBoundsLatitudePublisher.send(lowerBoundsLatitude)
        let upperBoundsLatitude = newRegion.center.latitude + newRegion.span.latitudeDelta / 2
        self.upperBoundsLatitudePublisher.send(upperBoundsLatitude)
        let lowerBoundsLongitude =  newRegion.center.longitude - newRegion.span.longitudeDelta / 2
        self.lowerBoundsLongitudePublisher.send(lowerBoundsLongitude)
        let upperBoundsLongitude =  newRegion.center.longitude + newRegion.span.longitudeDelta / 2
        self.upperBoundsLongitudePublisher.send(upperBoundsLongitude)

        initialised = true
        return newRegion
    }

    func getCoordinates() -> CLLocationCoordinate2D {
        
        CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)
    }

    static public func setMode(mode: DistanceMode) {
        locationMode = mode
    }
}
