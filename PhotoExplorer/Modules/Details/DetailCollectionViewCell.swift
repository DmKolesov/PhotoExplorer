//
//  DetailCollectionViewCell.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 12.09.2023.
//
import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let authorLabel = UILabel()
    private let likeButton = UIButton()
    
    var likeButtonTappedClosure: ((Bool) -> Void)?
    var likedClosure: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeButtonTapped() {
        if let closure = likeButtonTappedClosure {
            let newLikedState = !likeButton.isSelected
            closure(newLikedState)
            updateLikeButton(isLiked: newLikedState)
            likedClosure?(newLikedState)
        }
    }
    
    func configure(with model: UnsplashInfoData) {
        imageView.setImage(with: model.urls.regular)
        authorLabel.text = model.user.name
        updateLikeButton(isLiked: likeButton.isSelected)
    }
    
    func updateLikeButton(isLiked: Bool) {
        likeButton.isSelected = isLiked
        let imageName = isLiked ? Resources.Images.LikeButton.heartFill : Resources.Images.LikeButton.heartEmpty
        let image = UIImage(systemName: imageName)
        likeButton.setImage(image, for: .normal)
    }
}

extension DetailCollectionViewCell {
    func setupUI() {
        setupImageView()
        setupAuthorLabel()
        setupLikeButton()
        setupConstraints()
    }
    
    private func setupImageView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
    }
    
    private func setupAuthorLabel() {
        authorLabel.textColor = .white
        authorLabel.font = UIFont.boldSystemFont(ofSize: 16)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
    }
    
    private func setupLikeButton() {
        likeButton.setImage(UIImage(systemName: Resources.Images.LikeButton.heartFill), for: .normal)
        likeButton.tintColor = .white
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        contentView.addSubview(likeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor)
        ])
    }
}
