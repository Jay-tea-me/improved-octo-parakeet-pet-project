//
//  GeoMessageViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import Combine

final class GeoMessageViewModel: ObservableObject, Identifiable {

    @Published var geoMessage: GeoMessage
    var id = ""
    
    private var cancellables: Set<AnyCancellable> = []
    init(geoMessage: GeoMessage) {
        self.geoMessage = geoMessage
        $geoMessage
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
//        & = access property of geomessage
    }
}
