//
//  Resources.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 01.09.2023.
//

import UIKit

enum Resources {
    enum Strings {
        enum TabBar {
            static let inspiration = "Inspiration"
            static let favorite = "Favorite"
        }
        enum NavBar {
            static let inspiration = "Find Your Inspiration :"
            static let favorite = "You Are Inspired By :"
            static let detail = "In Detail :"
        }
        enum NetWork {
            static let apiKey = "hsbfD2yYIr9UGz0izQrIQX0vncq4LkxhZjR8k5HpWBc"
            static let randomEndpoint = "https://api.unsplash.com/photos/random"
            static let searchEndpoint = "https://api.unsplash.com/search/photos"
        }
    }
    enum Colors {
        static let active = UIColor(hexString: "#437BFE")
        static let inactive = UIColor(hexString: "#929DA5")
        static let separator = UIColor(hexString: "#E8ECEF")
        static let background = UIColor(hexString: "#F8F9F9")
        static let lightGrayColor = UIColor.lightGray.cgColor
        static let titleGray = UIColor(hexString: "#545C77")
        static let navBarTintColor = UIColor(red: 55/255, green: 120/255,
                                             blue: 250/255, alpha: 1)
        static let navBarWhiteColor = UIColor.white.cgColor
        static let navBarBlackColor = UIColor.black.cgColor
    }
    
    enum Images {
        enum Tabs {
            static let magnifyingglass = "magnifyingglass"
            static let star = "star"
        }
        enum LikeButton {
            static let heartFill = "heart.fill"
            static let heartEmpty = "heart"
        }
    }
    
    enum Fonts {
        static func helvelticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
