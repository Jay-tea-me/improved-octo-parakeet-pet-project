//
//  MessageRepository.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
import Combine
import Foundation

final class GeoMessageRepository: ObservableObject, RepositoryServices {

    private let path = "geoMessages"
    private let store: Firestore!

    @Published var geoMessages: [GeoMessage] = []

    @Published var mapLocationManager = MapLocationManager()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        print("init geo repo")
        store = Firestore.firestore()
        get()
        bindRegionUpdate()

    }

    private func bindRegionUpdate() {
        mapLocationManager.$region
            .sink { _ in
                self.get()
            }.store(in: &cancellables)
    }
    
    func get() {
        if !mapLocationManager.initialised {return}
        store.collection(path)
            .whereField("latitude", isGreaterThan: mapLocationManager.lowerBoundsLatitude)
            .whereField("latitude", isLessThan: mapLocationManager.upperBoundsLatitude)
            .addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.geoMessages = snapshot?.documents.compactMap {
                try? $0.data(as: GeoMessage.self)
            } ?? []
        }
    }
    
    func add(_ message: GeoMessage) {
        do {
            _ = try store.collection(path).addDocument(from: message)
        } catch {
            fatalError("Failed To Add Message")
        }
    }
}
