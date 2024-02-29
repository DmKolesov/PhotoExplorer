//
//  FavoritesCollectionViewCell.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 13.09.2023.
//

import UIKit

final class FavoritesCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with photo: UnsplashInfoData) {
        imageView.setImage(with: photo.urls.regular)
    }
}

private extension FavoritesCollectionViewCell {
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
}
