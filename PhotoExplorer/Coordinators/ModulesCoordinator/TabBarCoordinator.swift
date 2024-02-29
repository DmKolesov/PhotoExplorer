//
//  TabBarCoordinator.swift
//  PhotoExplorer
//
//  Created by TX 3000 on 21.09.2023.
//

import UIKit

final class TabBarCoordinator {
    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = TabBarCoordinator.makeNavigationControllers()
    private let modulesFactory = ModulesFactory()
    
    init(window: UIWindow) {
        self.window = window
        navigationControllers = TabBarCoordinator.makeNavigationControllers()
    }
    
    func start() {
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        setupInspiration()
        setupFavorites()
        
        let navigationControllers = NavigationControllersType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        
        tabBarController.setViewControllers(navigationControllers, animated: true)
        setupAppearanceTabBar(with: tabBarController)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    func openDetailScreen(with model: UnsplashInfoData, in navigationController: UINavigationController) {
        let detailVC = modulesFactory.createDetailModule()
        detailVC.viewModel.selectedModel = model
        navigationController.pushViewController(detailVC, animated: false)
    }
}

private extension TabBarCoordinator {
    static func makeNavigationControllers() -> [NavigationControllersType: UINavigationController] {
        var result: [NavigationControllersType: UINavigationController] = [:]
        
        NavigationControllersType.allCases.forEach { navigationControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem: UITabBarItem = UITabBarItem(
                title: navigationControllerKey.title,
                image: navigationControllerKey.image,
                tag: navigationControllerKey.rawValue
            )
            navigationController.tabBarItem = tabBarItem
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barStyle = .black
            navigationController.navigationBar.tintColor = .white
            navigationController.navigationBar.isTranslucent = false
            result[navigationControllerKey] = navigationController
        }
        return result
    }
    
    func setupInspiration() {
        guard let navController = self.navigationControllers[.inspiration] else {
            fatalError("fatalError setupInspiration")
        }
        
        navController.setViewControllers([], animated: false)
        let inspirationVC = modulesFactory.createInspirationModule()
        
        inspirationVC.navigationItem.title = Resources.Strings.NavBar.inspiration
        navController.setViewControllers([inspirationVC], animated: false)
        
        inspirationVC.viewModel.didSelectItem = { [weak self] selectedModel in
            self?.openDetailScreen(with: selectedModel, in: navController)
        }
        setupAppearanceNavigationBar(with: navController)
    }
    
    func setupFavorites() {
        guard let navController = self.navigationControllers[.favorite] else {
            fatalError("fatalError setupFavorites")
        }
        
        let favoriteVC = modulesFactory.createFavoriteModule()
        navController.setViewControllers([favoriteVC], animated: false)
        favoriteVC.navigationItem.title = Resources.Strings.NavBar.favorite
        
        setupAppearanceNavigationBar(with: navController)
    }
    
    func setupAppearanceNavigationBar(with controller: UINavigationController) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label,
                                                       .font: UIFont.systemFont(ofSize: 20)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label,
                                                            .font: UIFont.systemFont(ofSize: 28)]
        
        controller.navigationBar.standardAppearance = navigationBarAppearance
        controller.navigationBar.compactAppearance = navigationBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func setupAppearanceTabBar(with controller: UITabBarController) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .systemBackground
        
        controller.tabBar.scrollEdgeAppearance = tabBarAppearance
        controller.tabBar.standardAppearance = tabBarAppearance
        controller.tabBar.backgroundColor = .darkGray
        controller.tabBar.barTintColor = .systemBackground
        controller.tabBar.tintColor = .gray
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: controller.tabBar.frame.width, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemGray.cgColor
        shapeLayer.lineWidth = 0.2
        
        controller.tabBar.layer.addSublayer(shapeLayer)
    }
}

fileprivate enum NavigationControllersType: Int, CaseIterable {
    case inspiration, favorite
    
    var title: String {
        switch self {
        case .inspiration:
            return Resources.Strings.TabBar.inspiration
        case .favorite:
            return Resources.Strings.TabBar.favorite
        }
    }
    
    var image: UIImage {
        switch self {
        case .inspiration: return UIImage(systemName: Resources.Images.Tabs.magnifyingglass)!
        case .favorite: return UIImage(systemName: Resources.Images.Tabs.star)!
        }
    }
}
