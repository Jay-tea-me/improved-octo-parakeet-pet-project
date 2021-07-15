//
//  MessageRepository.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/07.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class GeoMessageRepository:  ObservableObject, RepositoryServices {

    private let path = "geoMessages"
    private let store = Firestore.firestore()
    @Published var geoMessages: [GeoMessage] = []
    
    init() {
        get()
    }
    
    func get() {
        store.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print (error)
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
