//
//  DetailRepository.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 19.09.2023.
//

import Foundation

protocol DetailDataRepository {
    func saveToFavoritesObject(object: UnsplashInfoData)
    func deleteObject(_ objectID: String)
}

final class DetailRepository: DetailDataRepository {
    private let storage: DataStorable
    private let mapper: ImageInfoMapper
    private var storedObjects: [UnsplashInfoData] = []
    
    init(storage: DataStorable, mapper: ImageInfoMapper) {
        self.storage = storage
        self.mapper = mapper
    }
    
    func saveToFavoritesObject(object: UnsplashInfoData) {
        do {
            if !storedObjects.contains(where: { $0.id == object.id }) {
                storedObjects.append(object)
                let realmObject = mapper.mapToRealmModel(domainModel: object)
                try storage.saveObjectToRealm(realmObject)
            } else {
                throw DataStorageError.objectAlreadyExists
            }
        }
        catch {
            print("Error saving object to Realm: \( DataStorageError.saveFailed)")
        }
    }
    
    func deleteObject(_ objectID: String) {
        do {
            try storage.deleteObjectFromRealm(objectID)
        }
        catch {
            print("Error deleting object from Realm: \(error)")
        }
    }
}
