//
//  AppDelegate.swift
//  ProjectTest
//
//  Created by Dinar on 11.01.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


//extension AppDelegate {
//    func openWelcomeVC(window: UIWindow?) {
//        if let window = window {
//            self.window = window
//        }
//        guard let window = self.window else {
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            return self.openWelcomeVC(window: nil)
//        }
//        DispatchQueue.main.async {
//            let viewController = AuthorizationViewController()
//            let navigationController = UINavigationController(rootViewController: viewController)
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//        }
//    }
    
//    func openMainVC(window: UIWindow?) {
//        if let window = window {
//            self.window = window
//        }
//        guard let window = self.window else {
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            return self.openMainVC(window: nil)
//        }
//        DispatchQueue.main.async {
//            let viewController = MainViewController()
//            let navigationController = UINavigationController(rootViewController: viewController)
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//        }
//    }
//}
