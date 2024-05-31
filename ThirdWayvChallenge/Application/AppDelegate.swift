//
//  AppDelegate.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import UIKit

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        try? Network.reachability = Reachability(hostname: "www.google.com")
        startApp()
        return true
    }
    /// Set root view Controller
    ///
    private func startApp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let productsViewController = ProductsViewController(viewModel: ProductsViewModel())
        let navigation = UINavigationController()
        navigation.viewControllers = [productsViewController]
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }
    
}
