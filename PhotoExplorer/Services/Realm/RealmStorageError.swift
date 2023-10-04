//
//  RealmStorageError.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 22.09.2023.
//

import Foundation

enum DataStorageError: Error {
    case objectAlreadyExists
    case objectNotFound
    case realmInitializationFailed
    case saveFailed
    case loadFailed
    case deleteFailed

    var description: String {
        switch self {
        case .objectAlreadyExists:
            return "Object already exists in storage."
        case .objectNotFound:
            return "Object not found in storage."
        case .realmInitializationFailed:
            return "Failed to initialize Realm."
        case .saveFailed:
            return "Failed to save object to storage."
        case .loadFailed:
            return "Failed to load objects from storage."
        case .deleteFailed:
            return "Failed to delete object from storage."
        }
    }
}
