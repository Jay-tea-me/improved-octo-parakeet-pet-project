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

        messageAreaCalculator = MessageAreaCalculator(range: 1, latitude: currentLatitude, longitude: currentLongitude)
    }
    
    func testLatitudeLowerBoundIsCurrentLatitudeMinusRange() {
        let actualLowerBoundLatitude = messageAreaCalculator.lowerBoundLatitude
        let expectedLowerBoundLatitude = currentLatitude - messageAreaCalculator.range
        
        XCTAssertEqual(actualLowerBoundLatitude, expectedLowerBoundLatitude)
    }
    
    func testLatitudeUpperBoundIsCurrentLocationPlusRange() {
        let actualUpperBoundLatitude = messageAreaCalculator.upperBoundLatitude
        let expectedUpperBoundLatitude = currentLatitude + messageAreaCalculator.range
        
        XCTAssertEqual(actualUpperBoundLatitude, expectedUpperBoundLatitude)
    }
    
    func testLongitudeLowerBoundIsCurrentLocationMinusRange() {
        let actualLowerBoundLongitude = messageAreaCalculator.lowerBoundLongitude
        let expectedLowerBoundLongitude = currentLongitude - messageAreaCalculator.range
        
        XCTAssertEqual(actualLowerBoundLongitude, expectedLowerBoundLongitude)
    }
    
    func testLongitudeUpperBoundIsCurrentLocationPlusRange() {
        let actualUpperBoundLongitude = messageAreaCalculator.upperBoundLongitude
        let expectedUpperBoundLongitude = currentLongitude + messageAreaCalculator.range
        
        XCTAssertEqual(actualUpperBoundLongitude, expectedUpperBoundLongitude)
    }
    
    func testLongitudeStaysInBoundsWithCurrentLongitudeOf85() {
        messageAreaCalculator.longitude = 85
        
        let actualUpperBoundLongitude = messageAreaCalculator.upperBoundLongitude
        let expectedUpperBoundLongitude: Double = -84
        
        XCTAssertEqual(actualUpperBoundLongitude, expectedUpperBoundLongitude)
    }
    
    func testLongitudeStaysInBoundsWithCurrentLongitudeOf0() {
        messageAreaCalculator.longitude = 0
        
        let actualLowerBoundLongitude = messageAreaCalculator.lowerBoundLongitude
        let expectedLowerBoundLongitude: Double = -1
        
        XCTAssertEqual(actualLowerBoundLongitude, expectedLowerBoundLongitude)
    }
    
    func testLatitudeStaysInBoundsWithCurrentLatitudeOf85() {
        messageAreaCalculator.latitude = 180
        
        let actualUpperBoundLatitude = messageAreaCalculator.upperBoundLatitude
        let expectedUpperBoundLatitude: Double = -179
        
        XCTAssertEqual(actualUpperBoundLatitude, expectedUpperBoundLatitude)
    }
    
    func testLatitudeStaysInBoundsWithCurrentLatitudeOf0() {
        messageAreaCalculator.latitude = 0
        
        let actualLowerBoundLatitude = messageAreaCalculator.lowerBoundLatitude
        let expectedLowerBoundLatitude: Double = -1
        
        XCTAssertEqual(actualLowerBoundLatitude, expectedLowerBoundLatitude)
    }

}
