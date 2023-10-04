//
//  RealmImageInfoEntity.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 19.09.2023.
//

import Foundation
import RealmSwift

 class RealmImageInfoEntity: Object {
     @Persisted var id: String = ""
     @Persisted var likes: Int = 0
     @Persisted var user: RealmUserInfoEntity?
     @Persisted var urls: RealmImageUrlsEntity?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class RealmUserInfoEntity: Object {
    @Persisted var username: String = ""
    @Persisted var name: String = ""
}
class RealmImageUrlsEntity: Object {
    @Persisted var regular: URL?
    @Persisted var small: URL?
}

extension URL: FailableCustomPersistable {
    public typealias PersistedType = String

    public init?(persistedValue: PersistedType) {
        self.init(string: persistedValue)
    }

    public var persistableValue: PersistedType {
        return self.absoluteString
    }
}
