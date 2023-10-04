//
//  CustomCollectionViewFlowLayout.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 21.09.2023.
//

import UIKit

enum CollectionDisplay {
    case grid
    case list
    case full
}

final class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var display: CollectionDisplay
    
    init(display: CollectionDisplay) {
        self.display = display
        super.init()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        scrollDirection = .vertical
        switch display {
        case .grid:
            configureGridLayout()
        case .list:
            configureListLayout()
        case .full:
            configureFullLayout()
        }
    }
    
    private func configureGridLayout() {
        guard let collectionView = collectionView, collectionView.frame.width > 0 else {
            return
        }
        
        let spacing: CGFloat = 8
        let itemWidth = (collectionView.frame.width - spacing * 3) / 2
        
        itemSize = CGSize(width: itemWidth, height: itemWidth)
        sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        minimumLineSpacing = spacing
        minimumInteritemSpacing = spacing
    }
    
    private func configureListLayout() {
        guard let collectionView = collectionView, collectionView.frame.width > 0 else {
            return
        }
        
        let spacing: CGFloat = 8
        let itemWidth = collectionView.frame.width - spacing * 2
        let estimatedHeight: CGFloat = 160
        
        itemSize = CGSize(width: itemWidth, height: estimatedHeight)
        sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        minimumLineSpacing = spacing
        minimumInteritemSpacing = spacing
    }
    
    private func configureFullLayout() {
        guard let collectionView = collectionView, collectionView.frame.width > 0 else {
            return
        }
        
        let spacing: CGFloat = 0
        let itemWidth = collectionView.frame.width
        let itemHeight = collectionView.frame.height
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        minimumLineSpacing = spacing
        minimumInteritemSpacing = spacing
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        configureLayout()
    }
}

