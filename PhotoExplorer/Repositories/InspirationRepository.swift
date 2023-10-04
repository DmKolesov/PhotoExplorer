//
//  InspirationDataRepository.swift
//  testUnsplash
//
//  Created by TX 3000 on 19.08.2023.
//

import Foundation

protocol InspirationDataRepository {
    func fetchRandomPhotos(count: Int, completion: @escaping (Result<[UnsplashInfoData], NetworkError>) -> Void)
    func searchPhotos(query: String, completion: @escaping (Result<[UnsplashInfoData], NetworkError>) -> Void)
}

final class InspirationRepository: InspirationDataRepository {
    private let apiService: UnsplashAPIService
    private var cancellable: NetworkCancellable?

    init(apiService: UnsplashAPIService) {
        self.apiService = apiService
    }

    func fetchRandomPhotos(count: Int, completion: @escaping (Result<[UnsplashInfoData], NetworkError>) -> Void) {
        cancellable?.cancel()
        cancellable = apiService.fetchRandomPhotos(count: count, completion: completion)
    }

    func searchPhotos(query: String, completion: @escaping (Result<[UnsplashInfoData], NetworkError>) -> Void) {
        cancellable?.cancel()
        cancellable = apiService.searchPhotos(query: query, completion: completion)
    }
}
