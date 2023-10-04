//
//  UIImage+Ext.swift
//  testUnsplash
//
//  Created by TX 3000 on 17.08.2023.
//


import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL) {
        self.kf.setImage(with: url)
    }
}
