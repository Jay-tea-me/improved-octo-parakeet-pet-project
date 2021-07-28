//
//  MKCoordinatesExtension.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/28.
//

import Foundation
import MapKit

extension MKCoordinateRegion {

    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D, span: MKCoordinateSpan)
    }

}
