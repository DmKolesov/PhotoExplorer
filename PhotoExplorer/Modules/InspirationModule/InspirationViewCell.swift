//
//  InspirationViewCell.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 01.09.2023.
//

import UIKit

class InspirationViewCell: UICollectionViewCell {
    
   private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with photo: UnsplashInfoData) {
        imageView.setImage(with: photo.urls.regular)
    }
}

extension InspirationViewCell {
    func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }
}
