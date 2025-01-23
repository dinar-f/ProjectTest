//
//  InformPopUp.swift
//  ProjectTest
//
//  Created by Dinar on 22.01.2025.
//

import UIKit

final class InformPopUp: UIViewController {
    
    // MARK: Private Properties
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "letter")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        label.text = "Проверьте электронную почту"
        label.textAlignment = .center
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправили ссылку на обновление пароля по адресу usermail@gmail.com."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hex: "#747474")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let mainButton = BaseButton(title: "ОК")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.clipsToBounds = true
        addSubviews()
        setupLayout()
        setupButtonTargets()
    }
}

    // MARK: - Private Methods
private extension InformPopUp {
    func addSubviews() {
        view.addSubview(overlayView)
        overlayView.addSubview(imageView)
        overlayView.addSubview(mainTitle)
        overlayView.addSubview(messageLabel)
        overlayView.addSubview(mainButton)
    }
    
    func setupLayout() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overlayView.widthAnchor.constraint(equalToConstant: 340),
            overlayView.heightAnchor.constraint(equalToConstant: 392),
            
            imageView.heightAnchor.constraint(equalToConstant: 112),
            imageView.widthAnchor.constraint(equalToConstant: 112),
            imageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 28),
            
            mainTitle.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 28),
            mainTitle.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -28),
            mainTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            
            messageLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 28),
            messageLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -28),
            messageLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 12),
            
            mainButton.heightAnchor.constraint(equalToConstant: 56),
            mainButton.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 28),
            mainButton.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -28),
            mainButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
        ])
    }
    
    func setupButtonTargets() {
        mainButton.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
    }
    
    @objc private func closePopUp() {
        dismiss(animated: true, completion: nil)
    }
}
