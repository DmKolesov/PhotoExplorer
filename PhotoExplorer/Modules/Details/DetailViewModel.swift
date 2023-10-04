//
//  DetailViewModel.swift
//  testUnsplash
//
//  Created by TX 3000 on 26.08.2023.
//

import Foundation

enum FavoriteActionType {
    case add
    case delete
}

protocol DetailsModuleDelegate: AnyObject {
    func didPerformFavoriteAction(_ actionType: FavoriteActionType, object: UnsplashInfoData)
}
protocol DetailViewModelInput {
    var delegate: DetailsModuleDelegate? { get set }
}

protocol DetailViewModelOutput {
    var selectedModel: UnsplashInfoData? { get set }
    func likeButtonTapped(isLiked: Bool)
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput {}
  
final class DetailViewModelImplementation: DetailViewModel {
    var selectedModel: UnsplashInfoData?
    private var selectedModels: [UnsplashInfoData] = []
    private let repository: DetailDataRepository
    weak var delegate: DetailsModuleDelegate?
    
    init(repository: DetailDataRepository) {
        self.repository = repository
    }
    
    func likeButtonTapped(isLiked: Bool) {
        guard let selectedModel = selectedModel else {
            return
        }
        if isLiked {
            repository.saveToFavoritesObject(object: selectedModel)
            delegate?.didPerformFavoriteAction(.add, object: selectedModel)
        } else {
            repository.deleteObject(selectedModel.id)
            delegate?.didPerformFavoriteAction(.delete, object: selectedModel)
        }
    }
}
