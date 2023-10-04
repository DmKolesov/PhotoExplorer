//
//  ImageInfoMapper.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 19.09.2023.
//

import Foundation
import RealmSwift

struct ImageInfoMapper {
    
    // MARK: - Mapping from ImageInfo to RealmImageInfoEntity
    
    func mapToRealmModel(domainModel: UnsplashInfoData) -> RealmImageInfoEntity {
        let realmModel = RealmImageInfoEntity()
        realmModel.id = domainModel.id
        realmModel.likes = domainModel.likes
        realmModel.user = mapToRealmUser(domainModel: domainModel.user)
        realmModel.urls = mapToRealmImageUrls(domainModel: domainModel.urls)
        return realmModel
    }
    
    private func mapToRealmUser(domainModel: UserInfo) -> RealmUserInfoEntity {
        let realmUser = RealmUserInfoEntity()
        realmUser.username = domainModel.username
        realmUser.name = domainModel.name
        return realmUser
    }
    
    private func mapToRealmImageUrls(domainModel: ImageUrls) -> RealmImageUrlsEntity {
        let realmImageUrls = RealmImageUrlsEntity()
        realmImageUrls.regular = domainModel.regular
        realmImageUrls.small = domainModel.small
        return realmImageUrls
    }
    
    // MARK: - Mapping from RealmImageInfoEntity to ImageInfo
    func mapToDomainModel(realmModel: RealmImageInfoEntity) -> UnsplashInfoData {
        return UnsplashInfoData(
            id: realmModel.id,
            likes: realmModel.likes,
            user: mapToDomainModel(realmUser: realmModel.user),
            urls: mapToDomainModel(realmImageUrls: realmModel.urls)
        )
    }
    
    private func mapToDomainModel(realmUser: RealmUserInfoEntity?) -> UserInfo {
        guard let realmUser = realmUser else {
            return UserInfo(username: "", name: "")
        }
        return UserInfo(
            username: realmUser.username,
            name: realmUser.name
        )
    }
    
    private func mapToDomainModel(realmImageUrls: RealmImageUrlsEntity?) -> ImageUrls {
        guard let regularURL = realmImageUrls?.regular, let smallURL = realmImageUrls?.small else {
            return ImageUrls(
                regular: URL(string: Resources.Strings.NetWork.randomEndpoint)!,
                small: URL(string: Resources.Strings.NetWork.randomEndpoint)!
            )
        }
        return ImageUrls(
            regular: regularURL,
            small: smallURL
        )
    }
}
