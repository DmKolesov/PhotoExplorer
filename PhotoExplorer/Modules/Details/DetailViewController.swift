//
//  DetailViewController.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 12.09.2023.
//

import UIKit

class DetailViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = makeCollectionView(with: .full, and: .detailCollectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewConstraints()
        
        if let model = viewModel.selectedModel {
            title = "Author: \(model.user.username)"
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        
        if let model = viewModel.selectedModel {
            cell.configure(with: model)
            cell.likeButtonTappedClosure = { [weak self] isLiked in
                self?.viewModel.likeButtonTapped(isLiked: isLiked)
            }
        }
        return cell
    }
}

extension DetailViewController {
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
