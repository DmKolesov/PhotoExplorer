//
//  RealmService.swift
//  testUnsplash
//
//  Created by TX 3000 on 27.08.2023.
//

import Foundation
import RealmSwift

final class RealmService {

    private lazy var realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }()

    func saveObject(_ object: RealmImageInfoEntity) throws {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let storageError as DataStorageError {
            throw storageError
        } catch {
            print("Failed to save object: \(error)")
            throw DataStorageError.saveFailed
        }
    }

    func getAllObjects() throws -> [RealmImageInfoEntity] {
        let realmObjects = realm.objects(RealmImageInfoEntity.self)
        
        if realmObjects.isEmpty {
            throw DataStorageError.objectNotFound
        }
        
        return Array(realmObjects)
    }
    
    func deleteObject(_ objectID: String) throws {
        guard let object = realm.object(ofType: RealmImageInfoEntity.self, forPrimaryKey: objectID) else {
            throw DataStorageError.objectNotFound
        }

        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let storageError as DataStorageError {
            throw storageError
        } catch {
            print("Failed to delete object: \(error)")
            throw DataStorageError.deleteFailed
        }
    }
}
