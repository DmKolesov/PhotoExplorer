//
//  SceneDelegate.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 28.08.2023.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private var tabBarCoordinator: TabBarCoordinator?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        guard let window = window else { return }
        window.windowScene = windowScene

        tabBarCoordinator = TabBarCoordinator(window: window)
        tabBarCoordinator?.start()
    }
}
