//
//  PasswordUpdateViewController.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//
import UIKit

class PasswordUpdateViewController: UIViewController {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Обновление пароля"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector (closePasswordUpdateView), for: .touchUpInside)
        return button
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите адрес электронной почты,\nмы отправим на неё ссылку для\nобновления пароля."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField = CustomTextField(type: .email)
    
    @objc private func closePasswordUpdateView() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViews()
        setupLayout()
    }
    
    func bindViews() {
        view.addSubview(closeButton)
        view.addSubview(emailTextField)
        view.addSubview(mainLabel)
        view.addSubview(infoLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            mainLabel.heightAnchor.constraint(equalToConstant: .init(28)),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 14),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 32),
        ])
    }
}
