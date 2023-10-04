//
//  CoordinatorsFactory.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 08.09.2023.
//

import UIKit

final class CoordinatorsFactory {
    func createTabBarCoordinator(_ window: UIWindow) -> TabBarCoordinator {
        return TabBarCoordinator(window: window)
    }
}
