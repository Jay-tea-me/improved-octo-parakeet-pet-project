//
//  FormViewObject.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/27.
//

import Foundation

class FormViewObject: ObservableObject {
    @Published var geoMessage: GeoMessage

    init(geoMessage: GeoMessage) {
        self.geoMessage = geoMessage
    }
}
