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
    private let store: Firestore = Firestore.firestore()

    @Published var geoMessages: [GeoMessage] = []

    @Published var mapLocationManager = MapLocationManager()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        print("init geo repo")

        bindRegionUpdate()

    }

    private func bindRegionUpdate() {
        mapLocationManager.$region
            .sink { _ in
                self.get()
            }.store(in: &cancellables)

    }
    
    func get() {
        if !mapLocationManager.initialised { return }
        let dbRef = store.collection(path)
        dbRef
            .whereField("latitude", isGreaterThan: mapLocationManager.lowerBoundsLatitude)
            .whereField("latitude", isLessThan: mapLocationManager.upperBoundsLatitude)
        dbRef
            .whereField("longitude", isGreaterThan: mapLocationManager.lowerBoundsLongitude)
            .whereField("longitude", isLessThan: mapLocationManager.upperBoundsLongitude)

        dbRef.addSnapshotListener { (snapshot, error) in
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
