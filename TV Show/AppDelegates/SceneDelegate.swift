//
//  SceneDelegate.swift
//  TV Show
//
//  Created by Hao Kim on 11/24/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    //MARK: -Properties
    var window: UIWindow?
    
    let tabBarController = UITabBarController()
    
    let moviesVC = Movies()
    let favoritesVC = Favorites()
    let settingsVC = Settings()
    let aboutVC = About()
    
    enum typeScreen {
        case movies
        case favorites
        case settings
        case about
    }
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        return (scene?.delegate as! SceneDelegate)
    }
    //MARK: -Public func
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        
        window.makeKeyAndVisible()
        createTabBar()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
    //MARK: tabBar
    func createTabBar() -> Void {
        //movies
        let moviesNavi = UINavigationController(rootViewController: moviesVC)
        moviesNavi.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "ic-tabbar-home") , tag: 0)
        
        //favorites
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesNavi.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    
        
        //settings
        let settingsNavi = UINavigationController(rootViewController: settingsVC)
        settingsNavi.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "ic-tabbar-settings"), tag: 2)
        
        //about
        let aboutNavi = UINavigationController(rootViewController: aboutVC)
        aboutNavi.tabBarItem = UITabBarItem(title: "About", image: UIImage(named: "ic-tabbar-about"), tag: 3)
        
        //tabBarController
        
        tabBarController.viewControllers = [moviesNavi, favoritesNavi, settingsNavi, aboutNavi]
        
        //view root
        window!.rootViewController = tabBarController
    }
//    //MARK: movies
//    func createMovies() -> Void {
//
//    }
//    //MARK: favorites
//    func createFavorites() -> Void {
//
//    }
//    //MARK: settings
//    func createSettings() -> Void {
//
//    }
//    //MARK: about
//    func createAbout() -> Void {
//
//    }
//    func changeScreen( screen: typeScreen) {
//        switch screen {
//        case .movies:
//            createMovies()
//        case .favorites:
//            createFavorites()
//        case .settings:
//            createSettings()
//        case .about:
//            createAbout()
//        }
//    }
}

