//
//  SplashScreenViewController.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//

import UIKit
import Network

class SplashScreenViewController: UIViewController {
    private let loadingSpinner = SpinnerLoader(color: .white, size: .normal)
    private let warningBanner = WarningBanner(title: "Проверьте подключение к интернету")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#196CFC")
        bindViews()
        setupLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.checkInternetConnection()
        }
    }
    
    private func bindViews() {
        view.addSubview(loadingSpinner)
        view.addSubview(warningBanner)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            warningBanner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningBanner.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160)
        ])
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
