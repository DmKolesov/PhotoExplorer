//
//  InspirationViewModel.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 08.09.2023.
//

import Foundation

protocol InspirationViewModelInput {
    var notify: (() -> Void)? { get set }
    func fetchRandomPhotos(count: Int)
    func searchPhotos(query: String)
    var didSelectItem: ItemSelectionHandler? { get set }
}

protocol InspirationViewModelOutput {
    var isSearching: Bool { get set }
    func itemsCount() -> Int
    func getItems(at indexPath: IndexPath) -> UnsplashInfoData
}

protocol InspirationViewModel: InspirationViewModelInput, InspirationViewModelOutput {}

typealias ItemSelectionHandler = (UnsplashInfoData) -> Void

final class InspirationViewModelImp: InspirationViewModel {

    private var repository: InspirationDataRepository
    private(set) var items: [UnsplashInfoData] = []
    private(set) var lastRandomPhotos: [UnsplashInfoData] = []
    
    var notify: (() -> Void)?
    var isSearching: Bool = false
    var didSelectItem: ItemSelectionHandler?
    
    init(repository: InspirationDataRepository) {
        self.repository = repository
    }
   
    func fetchRandomPhotos(count: Int) {
        repository.fetchRandomPhotos(count: count) { result in
            self.handleFetchResult(result)
        }
    }

    func searchPhotos(query: String) {
        repository.searchPhotos(query: query) { result in
            self.handleSearchResult(result)
        }
    }
    
    func itemsCount() -> Int {
        guard isSearching else {
            return lastRandomPhotos.isEmpty ? 0 : lastRandomPhotos.count
        }
        return items.isEmpty ? 0 : items.count
    }

    func getItems(at indexPath: IndexPath) -> UnsplashInfoData {
        guard isSearching else {
            return lastRandomPhotos[indexPath.row]
        }
        return items[indexPath.row]
    }
}

extension InspirationViewModelImp {
    
    private func handleFetchResult(_ result: Result<[UnsplashInfoData], NetworkError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let photos):
                self.items = photos
                self.lastRandomPhotos = photos
                self.notify?()
            case .failure(let error):
                print("Error fetching random photos: \(error)")
            }
        }
    }
    
    private func handleSearchResult(_ result: Result<[UnsplashInfoData], NetworkError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let photos):
                self.items = photos
                self.notify?()
            case .failure(let error):
                print("Error searching photos: \(error)")
            }
        }
    }
}
