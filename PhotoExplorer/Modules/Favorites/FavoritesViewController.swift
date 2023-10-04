//
//  FavoritesViewController.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 13.09.2023.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = makeCollectionView(with: .list, and: .favoriteCollectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    var viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsConstraints()
        viewModel.getFavoritePhotos()
        viewModel.notify = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favoriteObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath) as? FavoritesCollectionViewCell else { return UICollectionViewCell() }
        let model = viewModel.favoriteObjects[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

extension FavoritesViewController {
    func setupViewsConstraints() {
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
