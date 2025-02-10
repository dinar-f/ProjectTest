//
//  InformPopUp.swift
//  ProjectTest
//
//  Created by Dinar on 22.01.2025.
//

import UIKit

final class InformPopUp: UIViewController {
    var onConsentButtonTapped: (() -> Void)?
    
    // MARK: Private Properties
    private let popupType: InformPopUpType
    
    init(type: InformPopUpType) {
        self.popupType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
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
        label.text = "Быстрый вход по биометрии вместо ввода PIN-кода."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hex: "#747474")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let consentButton = BaseButton(title: "Использовать", type: .primary)
    private let rejectButton = BaseButton(title: "Пропустить", type: .secondary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.clipsToBounds = true
        addSubviews()
        setupView()
        setupLayout()
        setupButtonTargets()
    }
}

// MARK: - Public Properties
extension InformPopUp {
    enum InformPopUpType {
        case faceId
        case touchId
        
        var imageName: String {
            switch self {
            case .faceId:
                return  "faceID"
            case .touchId:
                return "touchID"
            }
        }
        
        var mainTitle: String {
            switch self {
            case .faceId:
                return "Использовать Face ID?"
            case .touchId:
                return "Использовать Touch ID?"
            }
        }
    }
}

    // MARK: - Private Methods
private extension InformPopUp {
    func addSubviews() {
        view.addSubview(overlayView)
        overlayView.addSubview(imageView)
        overlayView.addSubview(mainTitle)
        overlayView.addSubview(messageLabel)
        overlayView.addSubview(consentButton)
        overlayView.addSubview(rejectButton)
    }
    
    func setupView() {
        imageView.image = UIImage(named: popupType.imageName)
        mainTitle.text = popupType.mainTitle
    }
    
    func setupLayout() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        consentButton.translatesAutoresizingMaskIntoConstraints = false
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overlayView.widthAnchor.constraint(equalToConstant: 340),
            overlayView.heightAnchor.constraint(equalToConstant: 400),
            
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
            
            consentButton.heightAnchor.constraint(equalToConstant: 56),
            consentButton.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 28),
            consentButton.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -28),
            consentButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            
            rejectButton.heightAnchor.constraint(equalToConstant: 56),
            rejectButton.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 28),
            rejectButton.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -28),
            rejectButton.topAnchor.constraint(equalTo: consentButton.bottomAnchor, constant: 12),
        ])
    }
    
    func setupButtonTargets() {
        rejectButton.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        consentButton.addTarget(self, action: #selector(consentButtonAction), for: .touchUpInside)
    }
    
    @objc private func consentButtonAction() {
        dismiss(animated: true) { [weak self] in
            self?.onConsentButtonTapped?()
        }
    }
    
    @objc private func closePopUp() {
        dismiss(animated: true, completion: nil)
    }
}
