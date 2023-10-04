//
//  BaseViewController.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 01.09.2023.
//

import UIKit

enum Cell {
    case inspirationCollectionViewCell
    case favoriteCollectionViewCell
    case detailCollectionViewCell
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func makeCollectionView(with display: CollectionDisplay, and cell: Cell) -> UICollectionView {
        let layout = CustomCollectionViewFlowLayout(display: display)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
 
        switch cell {
        case .inspirationCollectionViewCell:
            collectionView.register(InspirationViewCell.self,
                                    forCellWithReuseIdentifier: InspirationViewCell.identifier)
        case .favoriteCollectionViewCell:
            collectionView.register(FavoritesCollectionViewCell.self,
                                    forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        case .detailCollectionViewCell:
            collectionView.register(DetailCollectionViewCell.self,
                                    forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        }
        return collectionView
    }
}
