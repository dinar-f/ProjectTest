//
//  AuthorizationViewController.swift
//  ProjectTest
//
//  Created by Dinar on 11.01.2025.
//

import UIKit

class AuthorizationViewController: UIViewController {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "С возвращением!"
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.text = "Войти с помощью"
        return label
    }()
    
    private let emailTextField = TextField(type: .email)
    private let passwordTextField = TextField(type: .password)
    private let informBanner = InformBanner(viewModel: .init(type: .error, title: "Некорректная почта или пароль"))
    private let passwordResetButton = UnstyledButton(title: "Забыли пароль?")
    private let loginButton = BaseButton(title: "Войти")
    private let samlButton = TextIconButton(iconName: "lock", title: "Войти с помощью SAML SSO")
    private let qrButton = TextIconButton(iconName: "qr", title: "Авторизация через QR")
    private let yandexButton = IconButton(iconName: "yandex")
    private let gosuslugiButton = IconButton(iconName: "gosuslugi")
    
    private let formStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let loginButtonsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let serviceButtonsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
        setupButtonTargets()
    }
    
    @objc private func openPasswordUpdateView() {
        let passwordUpdateVC = PasswordUpdateViewController()
        present(passwordUpdateVC, animated: true, completion: nil)
    }
    
    @objc private func openQrLoginView() {
        let qrLoginVC = QrLoginViewController()
        present(qrLoginVC, animated: true, completion: nil)
    }
    
    @objc private func openPopup() {
        let popupVC = InformPopUp()
        
        // Настройка стиля представления
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        
        present(popupVC, animated: true, completion: nil)
    }
    
    @objc private func openSamlLoginView() {
        let samlLoginVC = SamlLoginViewController()
        if let sheet = samlLoginVC.sheetPresentationController {
            sheet.detents = [.custom { context in
                return samlLoginVC.preferredContentSize.height
            }]
            sheet.prefersGrabberVisible = true
        }
        samlLoginVC.preferredContentSize = CGSize(width: view.bounds.width, height: 300)
        present(samlLoginVC, animated: true, completion: nil)
    }
    
    private func setupButtonTargets() {
//        passwordResetButton.addTarget(self, action: #selector(openPopup), for: .touchUpInside) // временно
        passwordResetButton.addTarget(self, action: #selector(openPasswordUpdateView), for: .touchUpInside)
        qrButton.addTarget(self, action: #selector(openQrLoginView), for: .touchUpInside)
        samlButton.addTarget(self, action: #selector(openSamlLoginView), for: .touchUpInside)
    }
    
    func addSubviews() {
        view.addSubview(mainLabel)
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(passwordTextField)
        formStackView.addArrangedSubview(informBanner)
        view.addSubview(formStackView)
        view.addSubview(passwordResetButton)
        view.addSubview(loginButton)
        view.addSubview(subLabel)
        loginButtonsStackView.addArrangedSubview(samlButton)
        loginButtonsStackView.addArrangedSubview(qrButton)
        view.addSubview(loginButtonsStackView)
        serviceButtonsStackView.addArrangedSubview(yandexButton)
        serviceButtonsStackView.addArrangedSubview(gosuslugiButton)
        view.addSubview(serviceButtonsStackView)
    }
    
    func setupLayout() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        serviceButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            
            passwordResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordResetButton.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 24),
            
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.topAnchor.constraint(equalTo: passwordResetButton.bottomAnchor, constant: 24),
            
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            
            loginButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButtonsStackView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 24),
            
            serviceButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            serviceButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            serviceButtonsStackView.topAnchor.constraint(equalTo: loginButtonsStackView.bottomAnchor, constant: 16),
        ])
    }
}

