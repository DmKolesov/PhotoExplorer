//
//  RealmManager.swift
//  testUnsplash
//
//  Created by TX 3000 on 27.08.2023.
//

import UIKit

protocol DataStorable {
    func saveObjectToRealm(_ object: RealmImageInfoEntity) throws
    func deleteObjectFromRealm(_ objectID: String) throws
    func loadAllObjectsFromRealm() throws -> [RealmImageInfoEntity]
}

final class RealmStorage: DataStorable {
    
    private let realmService: RealmService
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func saveObjectToRealm(_ object: RealmImageInfoEntity) throws {
        do {
            try realmService.saveObject(object)
        } catch {
            throw DataStorageError.objectAlreadyExists
        }
    }
    
    func deleteObjectFromRealm(_ objectID: String) throws {
        do {
            try realmService.deleteObject(objectID)
        } catch {
            throw DataStorageError.deleteFailed
        }
    }
    
    func loadAllObjectsFromRealm() throws -> [RealmImageInfoEntity] {
        do {
            let objects = try realmService.getAllObjects()
            return objects
 
        } catch {
            throw DataStorageError.loadFailed
        }
    }
}
