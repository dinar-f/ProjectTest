//
//  VerificationViewController.swift
//  ProjectTest
//
//  Created by Dinar on 23.01.2025.
//

import UIKit

class VerificationViewController: UIViewController {
    private let accessCode = "1234"
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Подтвердите PIN-код"
        return label
    }()
    
    private let verifyView = VerifyView()
    private let spinnerLoader = SpinnerLoader(color: .blue, size: .normal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
        verifyView.verifyDelegate = self
        spinnerLoader.isHidden = true
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func checkCode() {
        spinnerLoader.isHidden = false
        let fieldsCode = verifyView.getFieldsValue()
        if fieldsCode == accessCode {
            print("ok")
        } else {
            print("error")
//            verifyView.showEroor()
        }
    }
    
    func addSubviews() {
        view.addSubview(mainLabel)
        view.addSubview(verifyView)
        view.addSubview(spinnerLoader)
    }
    
    func setupLayout() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        spinnerLoader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 96),
            
            verifyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 64),
            
            spinnerLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerLoader.topAnchor.constraint(equalTo: verifyView.bottomAnchor, constant: 110)
        ])
    }
}

// MARK: Verify Protocol
extension VerificationViewController: VerifyProtocol {
    func verifyCode() {
        checkCode()
    }
}
