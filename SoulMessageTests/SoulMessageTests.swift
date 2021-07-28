//
//  SoulMessageTests.swift
//  SoulMessageTests
//
//  Created by Justine Wright on 2021/07/08.
//

import XCTest

class SoulMessageTests: XCTestCase {

    var messageAreaCalculator: MessageAreaCalculator!
    var currentLatitude: Double = 1
    var currentLongitude: Double = 1
    override func setUp() {

        messageAreaCalculator = MessageAreaCalculator(
            distance: 1000, latitude: currentLatitude, longitude: currentLongitude)
    }

    func testLatitudeLowerBoundIsCurrentLatitudeMinusRange() {
        let actualLowerBoundLatitude = messageAreaCalculator.lowerBoundLatitude
        let expectedLowerBoundLatitude = currentLatitude - messageAreaCalculator.latitudeDelta

        XCTAssertEqual(actualLowerBoundLatitude, expectedLowerBoundLatitude)
    }

    func testLatitudeUpperBoundIsCurrentLocationPlusRange() {
        let actualUpperBoundLatitude = messageAreaCalculator.upperBoundLatitude
        let expectedUpperBoundLatitude = currentLatitude + messageAreaCalculator.latitudeDelta

        XCTAssertEqual(actualUpperBoundLatitude, expectedUpperBoundLatitude)
    }

    func testLongitudeLowerBoundIsCurrentLocationMinusRange() {
        let actualLowerBoundLongitude = messageAreaCalculator.lowerBoundLongitude
        let expectedLowerBoundLongitude = currentLongitude - messageAreaCalculator.longitudeDelta

        XCTAssertEqual(actualLowerBoundLongitude, expectedLowerBoundLongitude)
    }

    func testLongitudeUpperBoundIsCurrentLocationPlusRange() {
        let actualUpperBoundLongitude = messageAreaCalculator.upperBoundLongitude
        let expectedUpperBoundLongitude = currentLongitude + messageAreaCalculator.longitudeDelta

        XCTAssertEqual(actualUpperBoundLongitude, expectedUpperBoundLongitude)
    }

    func testLongitudeStaysInBoundsWithCurrentLongitudeOf85() {
        messageAreaCalculator.longitude = messageAreaCalculator.longitudeBounds

        let actualUpperBoundLongitude = messageAreaCalculator.upperBoundLongitude
        let minLongitude: Double = -1 * messageAreaCalculator.longitude
        let maxLongitude: Double = messageAreaCalculator.longitude

        XCTAssertTrue(actualUpperBoundLongitude > minLongitude)
        XCTAssertTrue(actualUpperBoundLongitude < maxLongitude)
    }

    func testLongitudeStaysInBoundsWithCurrentLongitudeOf0() {
        messageAreaCalculator.longitude = 0

        let actualLowerBoundLongitude = messageAreaCalculator.lowerBoundLongitude

        XCTAssertTrue(actualLowerBoundLongitude < messageAreaCalculator.longitude)
    }

    func testLatitudeStaysInBoundsWithCurrentLatitudeOf85() {
        messageAreaCalculator.latitude = messageAreaCalculator.latitudeBounds

        let actualUpperBoundLatitude = messageAreaCalculator.upperBoundLatitude
        let minLatitude: Double = -messageAreaCalculator.latitudeBounds
        let maxLatitude: Double = messageAreaCalculator.latitudeBounds

        XCTAssertTrue(actualUpperBoundLatitude > minLatitude)
        XCTAssertTrue(actualUpperBoundLatitude < maxLatitude)
    }

    func testLatitudeStaysInBoundsWithCurrentLatitudeOf0() {
        messageAreaCalculator.latitude = 0

        let actualLowerBoundLatitude = messageAreaCalculator.lowerBoundLatitude
        
        XCTAssertTrue(actualLowerBoundLatitude < messageAreaCalculator.latitude)
    }

}
