//
//  SplashScreenViewController.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//

import UIKit
import Network

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.checkInternetConnection()
        }
    }
    
    private func checkInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    let authorizationVC = AuthorizationViewController()
                    self.navigationController?.pushViewController(authorizationVC, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                }
            }
            monitor.cancel()
        }
    }
}
