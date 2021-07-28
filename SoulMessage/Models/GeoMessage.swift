//
//  GeoMessage.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import FirebaseFirestoreSwift
// swiftlint:disable identifier_name
struct GeoMessage: Identifiable, Codable {
    @DocumentID var id: String?
    var sender: String
    var body: String
    var latitude: Double
    var longitude: Double
    var dated: Double?
//    var location: Coordinate
}
