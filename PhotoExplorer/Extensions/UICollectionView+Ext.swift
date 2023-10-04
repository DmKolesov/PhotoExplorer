//
//  UICollectionView+Ext.swift
//  testUnsplash
//
//  Created by TX 3000 on 16.08.2023.
//

import UIKit

protocol ReusableCollectionViewCell {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableCollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
