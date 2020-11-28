//
//  CollectionViewCell.swift
//  ALittleImageGalleryApp
//
//  Created by Sumair Zamir on 14/11/2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
        
    let cellImageView = UIImageView()
    
    override func prepareForReuse() {
        cellImageView.image = nil
    }
    
    func configureCell() {
        addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFit
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: topAnchor),
            cellImageView.rightAnchor.constraint(equalTo: rightAnchor),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
