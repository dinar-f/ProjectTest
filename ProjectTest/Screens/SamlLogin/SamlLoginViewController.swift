//
//  SamlLoginViewController.swift
//  ProjectTest
//
//  Created by Dinar on 19.01.2025.
//

import UIKit

class SamlLoginViewController: UIViewController {
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
    private let sendButton = BaseButton(title: "Продолжить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
        registerKeyboardNotifications()
    }
    
    func addSubviews(){
        view.addSubview(mainLabel)
        view.addSubview(closeButton)
        view.addSubview(domainTextField)
        view.addSubview(sendButton)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupLayout(){
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        domainTextField.translatesAutoresizingMaskIntoConstraints = false
        buttonBottomConstraint = sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        
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
            buttonBottomConstraint,
        ])
    }
    
    @objc private func closeSamlLoginView() {
        dismiss(animated: true, completion: nil)
    }
}


extension SamlLoginViewController {
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            buttonBottomConstraint.constant = -keyboardHeight - 16
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        buttonBottomConstraint.constant = -16
    }
}

