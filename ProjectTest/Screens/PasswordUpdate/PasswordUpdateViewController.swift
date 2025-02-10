//
//  PasswordUpdateViewController.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//
import UIKit

final class PasswordUpdateViewController: BaseViewController {
    
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
    private let sendButton = BaseButton(title: "Отправить", type: .primary)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addSubviews()
        setupLayout()
    }
    
    override func adjustForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        let offset = show ? -keyboardHeight + 16 : 0
        sendButton.transform = CGAffineTransform(translationX: 0, y: offset)
    }
    
    func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(infoLabel)
        view.addSubview(sendButton)
    }
    
    private func setupNavigationBar() {
        title = "Обновление пароля"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        let barButtonItem = UIBarButtonItem(customView: closeButton)
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 18).isActive = true
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 18).isActive = true
        navigationItem.rightBarButtonItem = barButtonItem
    }

    
    func setupLayout() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            
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
