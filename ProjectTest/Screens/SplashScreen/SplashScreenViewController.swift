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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#196CFC")
        bindViews()
        setupLayout()
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
    
    func openAuthorizationViewController() {
        let authorizationVC = AuthorizationViewController()
        self.navigationController?.pushViewController(authorizationVC, animated: true)
    }
    
    private func checkInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.loadingSpinner.isHidden = true
                DispatchQueue.main.async {
                    self.openAuthorizationViewController()
                }
            } else {
                DispatchQueue.main.async {
                    self.loadingSpinner.isHidden = true
                    
                    // Как переделать баннер чтобы я не имел сильной ссылки на него
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
