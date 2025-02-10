//
//  SamlLoginViewController.swift
//  ProjectTest
//
//  Created by Dinar on 19.01.2025.
//

import UIKit

class SamlLoginViewController: BaseViewController {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход через SAML SSO"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private var buttonBottomConstraint = NSLayoutConstraint()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector (closeSamlLoginView), for: .touchUpInside)
        return button
    }()
    
    private let domainTextField = TextField(type: .domain)
    private let sendButton = BaseButton(title: "Продолжить", type: .primary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
    }
    
    func addSubviews(){
        view.addSubview(mainLabel)
        view.addSubview(closeButton)
        view.addSubview(domainTextField)
        view.addSubview(sendButton)
    }
    
    override func adjustForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        let offset = show ? -keyboardHeight + 16 : 0
        sendButton.transform = CGAffineTransform(translationX: 0, y: offset)
    }
    
    func setupLayout(){
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        domainTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            domainTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            domainTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            domainTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 32),
            
            sendButton.heightAnchor.constraint(equalToConstant: 56),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -26),
        ])
    }
    
    @objc private func closeSamlLoginView() {
        dismiss(animated: true, completion: nil)
    }
}
