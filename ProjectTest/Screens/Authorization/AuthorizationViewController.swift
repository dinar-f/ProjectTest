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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.text = "Войти с помощью"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField = CustomTextField(type: .email)
    let passwordTextField = CustomTextField(type: .password)
    let loginButton = CustomPrimaryButton(title: "Войти")
    let yandexButton = CustomIconButton(iconName: "yandex")
    let gosuslugiButton = CustomIconButton(iconName: "gosuslugi")
    let passwordResetButton = CustomUnstyledButton(title: "Забыли пароль?")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViews()
        setupLayout()
        passwordResetButton.addTarget(self, action: #selector(openPasswordUpdateView), for: .touchUpInside)
    }
    
    @objc private func openPasswordUpdateView() {
        let passwordUpdateVC = PasswordUpdateViewController()
        let navigationController = UINavigationController(rootViewController: passwordUpdateVC)
        present(navigationController, animated: true, completion: nil)
    }
    
    func bindViews() {
        view.addSubview(mainLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordResetButton)
        view.addSubview(gosuslugiButton)
        view.addSubview(yandexButton)
        view.addSubview(loginButton)
        view.addSubview(subLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            mainLabel.heightAnchor.constraint(equalToConstant: .init(56)),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),

            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            
            passwordResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordResetButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordResetButton.bottomAnchor, constant: 26),
            
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            
            yandexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yandexButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 186),
            gosuslugiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gosuslugiButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 146),
        ])
    }
}

