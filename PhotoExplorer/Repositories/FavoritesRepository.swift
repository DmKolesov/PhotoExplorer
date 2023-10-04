//
//  FavoritesRepository.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 14.09.2023.
//

import UIKit

protocol FavoritesDataRepository {
    func getAllFavoriteObjects(completion: @escaping (Result<[UnsplashInfoData], DataStorageError>) -> Void)
}

final class FavoritesRepository: FavoritesDataRepository {
    
    private let storage: DataStorable
    private let mapper: ImageInfoMapper
    
    init(storage: DataStorable, mapper: ImageInfoMapper) {
        self.storage = storage
        self.mapper = mapper
    }
    
    func getAllFavoriteObjects(completion: @escaping (Result<[UnsplashInfoData], DataStorageError>) -> Void) {
        do {
            let realmObjects = try storage.loadAllObjectsFromRealm()
            let domainObjects = realmObjects.map { mapper.mapToDomainModel(realmModel: $0) }
            completion(.success(domainObjects))
        } catch {
            completion(.failure(DataStorageError.loadFailed)) 
        }
    }
}
