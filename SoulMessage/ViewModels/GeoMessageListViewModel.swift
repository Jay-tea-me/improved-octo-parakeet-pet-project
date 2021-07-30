//
//  MessageListViewModel.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import Foundation
import Combine

final class GeoMessageListViewModel: ObservableObject {
    @Published var geoMessageRepository = GeoMessageRepository()
    @Published var listGeoMessageViewModel: [GeoMessageViewModel] = []

    private var cancellables: Set<AnyCancellable> = []

    init() {
        geoMessageRepository.$geoMessages
            .map { geoMessage in
                geoMessage.map(GeoMessageViewModel.init)
            }
            .assign(to: \.listGeoMessageViewModel, on: self)
            .store(in: &cancellables)

        MapLocationManager.setMode(mode: .ar)
    }

    func add(_ geoMessage: GeoMessage) {
        geoMessageRepository.add(geoMessage)
    }
}
