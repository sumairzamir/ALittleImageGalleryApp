//
//  View.swift
//  ALittleImageGalleryApp
//
//  Created by Sumair Zamir on 14/11/2020.
//

import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCollectionViewLayout()
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let collectionViewLayout = UICollectionViewFlowLayout()
    let searchBar = UISearchBar()
    
    func configureView() {
        backgroundColor = .systemBackground
        addMultipleSubviews([collectionView, searchBar])
        configureCollectionView()
        configureSearchBar()
        configureConstraints()
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureSearchBar() {
        searchBar.placeholder = StringConstants.placeholderText.value
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureCollectionViewLayout() {
        collectionViewLayout.minimumInteritemSpacing = FloatConstants.standardSpacing.value
        collectionViewLayout.minimumLineSpacing = FloatConstants.standardSpacing.value
        
        let numberOfCellsPerRows: CGFloat = FloatConstants.cellsPerRow.value
        let width = collectionView.frame.width - collectionViewLayout.minimumInteritemSpacing
        
        layoutIfNeeded()
        collectionViewLayout.itemSize = CGSize(width: (width)/numberOfCellsPerRows, height: FloatConstants.cellHeight.value)
    }
    
}
