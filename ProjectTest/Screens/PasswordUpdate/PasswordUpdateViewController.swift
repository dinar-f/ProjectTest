//
//  PasswordUpdateViewController.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//
import UIKit

final class PasswordUpdateViewController: UIViewController {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Обновление пароля"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector (closePasswordUpdateView), for: .touchUpInside)
        return button
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите адрес электронной почты,\nмы отправим на неё ссылку для\nобновления пароля."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 3
        return label
    }()
    
    private let emailTextField = TextField(type: .email)
    private let sendButton = BaseButton(title: "Отправить")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
        setupKeyboardObservers()
    }
    
    func addSubviews() {
        view.addSubview(closeButton)
        view.addSubview(mainLabel)
        view.addSubview(emailTextField)
        view.addSubview(infoLabel)
        view.addSubview(sendButton)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            sendButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 16)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        sendButton.transform = .identity
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupLayout() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 12),
            
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 32),
            
            sendButton.heightAnchor.constraint(equalToConstant: 56),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

@objc private extension PasswordUpdateViewController {
    func closePasswordUpdateView() {
        dismiss(animated: true, completion: nil)
    }
}
