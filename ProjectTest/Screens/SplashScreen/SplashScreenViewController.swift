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
//    private let warningBanner = WarningBanner(title: "Проверьте подключение к интернету") {
//        startLoading()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#196CFC")
        bindViews()
        setupLayout()
//        warningBanner.show(in: self.view)
        startLoading()
    }
    
    private func bindViews() {
        view.addSubview(loadingSpinner)
        loadingSpinner.isHidden = true
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func startLoading() {
        loadingSpinner.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.checkInternetConnection()
        }
    }
    
    private func checkInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.loadingSpinner.isHidden = true
                DispatchQueue.main.async {
                    let authorizationVC = AuthorizationViewController()
                    self.navigationController?.pushViewController(authorizationVC, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.loadingSpinner.isHidden = true
                    let banner = WarningBanner(title: "Проблемы с интернетом. Нажмите кнопку, чтобы повторить загрузку.", action: {
                        self.startLoading()
                    })
                    banner.show(in: self.view)
                }
            }
            monitor.cancel()
        }
    }
}
