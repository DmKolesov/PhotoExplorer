//
//  InspirationViewController.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 01.09.2023.
//

import UIKit

final class InspirationViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = makeCollectionView(with: .grid, and: .inspirationCollectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var searchBar = UISearchBar()
    var viewModel: InspirationViewModel
    
    init(viewModel: InspirationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewConstraints()
        setupViews()
        navigationController?.navigationBar.barTintColor = Resources.Colors.navBarTintColor
        viewModel.fetchRandomPhotos(count: 30)
        viewModel.notify = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension InspirationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedModel = viewModel.getItems(at: indexPath)
        viewModel.didSelectItem?(selectedModel)
    }
}

extension InspirationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InspirationViewCell.identifier, for: indexPath) as? InspirationViewCell else {
            return UICollectionViewCell()
        }
        let item = viewModel.getItems(at: indexPath)
        cell.configure(with: item)
        return cell
    }
}

private extension InspirationViewController {
    func setupViews() {
        searchBar.becomeFirstResponder()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
}

// MARK: - UISearchBarDelegate

extension InspirationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.isSearching = false
            collectionView.reloadData()
        } else {
            viewModel.isSearching = true
            viewModel.searchPhotos(query: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.isSearching = false
        collectionView.reloadData()
    }
}

private extension InspirationViewController {
    func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
