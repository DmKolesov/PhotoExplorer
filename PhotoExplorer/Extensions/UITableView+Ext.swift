//
//  UITableView+Ext.swift
//  testUnsplash
//
//  Created by TX 3000 on 16.08.2023.
//

import UIKit

protocol ReusableCell {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension UITableViewCell: ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
