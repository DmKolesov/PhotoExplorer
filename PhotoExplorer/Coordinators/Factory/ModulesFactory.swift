//
//  ModulesFactory.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 07.09.2023.
//
import UIKit

final class ModulesFactory {
    
    let mapper = ImageInfoMapper()
    let realmService = RealmService()
    
    func createInspirationModule() -> InspirationViewController {
        let errorLogger: NetworkErrorLogger = DefaultNetworkErrorLogger()
        let apiService = UnsplashAPIService(errorLogger: errorLogger)
        let repository: InspirationDataRepository = InspirationRepository(apiService: apiService)
        let inspirationViewModel: InspirationViewModel = InspirationViewModelImp(repository: repository)
        let inspirationViewController = InspirationViewController(viewModel: inspirationViewModel)
        return inspirationViewController
    }
    
    func createFavoriteModule() -> FavoritesViewController {
        let storage: DataStorable = RealmStorage(realmService: realmService)
        let repository: FavoritesDataRepository = FavoritesRepository(storage: storage, mapper: mapper)
        let viewModel: FavoritesViewModel = FavoritesViewModelImp(repository: repository)
        let favoritesViewController = FavoritesViewController(viewModel: viewModel)
        return favoritesViewController
    }
    
    func createDetailModule() -> DetailViewController {
        let storage: DataStorable = RealmStorage(realmService: realmService)
        let repository: DetailDataRepository = DetailRepository(storage: storage, mapper: mapper)
        var detailViewModel: DetailViewModel = DetailViewModelImplementation(repository: repository)
        
        // Set the delegate
        if let favoritesViewController = createFavoriteModule() as? FavoritesViewController {
            if let favoritesViewModel = favoritesViewController.viewModel as? FavoritesViewModelImp {
                detailViewModel.delegate = favoritesViewModel
            }
        }
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        return detailViewController
    }
}
