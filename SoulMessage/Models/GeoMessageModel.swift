//
//  GeoMessage.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import FirebaseFirestoreSwift
import CoreLocation

struct GeoMessageModel: Identifiable, Codable {
    @DocumentID var id: String?
    var sender: String
    var body: String

}
