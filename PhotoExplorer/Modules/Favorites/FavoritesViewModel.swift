//
//  FavoritesViewModel.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 13.09.2023.
//

import Foundation

protocol FavoritesViewModelInput {
    func getFavoritePhotos()
}

protocol FavoritesViewModelOutput {
    var favoriteObjects: [UnsplashInfoData] { get }
    var notify: (() -> Void)? { get set }
}

protocol FavoritesViewModel: FavoritesViewModelInput, FavoritesViewModelOutput {}

final class FavoritesViewModelImp: FavoritesViewModel, DetailsModuleDelegate {
    private let repository: FavoritesDataRepository
    private(set) var favoriteObjects: [UnsplashInfoData] = []
    var notify: (() -> Void)?
    
    init(repository: FavoritesDataRepository) {
        self.repository = repository
    }
    
    func getFavoritePhotos() {
        repository.getAllFavoriteObjects { result in
            switch result {
            case .success(let objects):
                self.favoriteObjects = objects
                self.notify?()
            case .failure(let error):
                print("Error in repository with: \(error.localizedDescription)")
            }
        }
    }
    
    func didPerformFavoriteAction(_ actionType: FavoriteActionType, object: UnsplashInfoData) {
        switch actionType {
        case .add:
            favoriteObjects.append(object)
        case .delete:
            favoriteObjects.removeAll { $0.id == object.id }
        }
        DispatchQueue.main.async {
            self.notify?()
        }
    }
}
