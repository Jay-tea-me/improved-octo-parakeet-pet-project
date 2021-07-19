//
//  RepositoryProtocol.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/06.
//

import Foundation

protocol RepositoryServices {
    func get()
    func add(_ message: GeoMessage)
}
