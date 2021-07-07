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
    @Published var geoMessageListViewModel: [GeoMessageViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        geoMessageRepository.$geoMessages
            .map{ geoMessages in
                geoMessages.map(GeoMessageViewModel.init)
            }
            .assign(to: \.geoMessageListViewModel, on: self)
            .store(in: &cancellables)
    }
    
    func add(_ geoMessage: GeoMessage) {
        geoMessageRepository.add(geoMessage)
    }
    
}
