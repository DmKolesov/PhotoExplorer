//
//  ImageInfo.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 19.09.2023.
//

import Foundation

struct UnsplashInfoData: Codable {
    let id: String
    let likes: Int
    let user: UserInfo
    let urls: ImageUrls
}

struct UserInfo: Codable {
    let username: String
    let name: String
}

struct ImageUrls: Codable {
    let regular: URL
    let small: URL
}

struct UnsplashInfoSearchResponse: Codable {
    let results: [UnsplashInfoData]
}
