//
//  VerifyViewController.swift
//  ProjectTest
//
//  Created by Dinar on 28.01.2025.
//

import UIKit
import LocalAuthentication

class VerifyViewController: UIViewController {
    
    private let userPIN: String? = UserDefaultManager.shared.getValue(forKey: "UserPIN")
    private var isFirstInput = true
    private var firstEnteredCode: String = ""
    private var secondEnteredCode: String = ""
    private var currentCode: String = "" {
        didSet {
            updateFieldsStates()
            if userPIN != nil {
                checkAuthorizationCode()
            } else {
                checkCodeCompletion()
            }
        }
    }
    
    private var currentActiveIndex = 0 {
        didSet {
            updateFieldsStates()
        }
    }
    
    private let keyboardView = KeyboardView()
    private let verifyView = VerificationView()
    private var mainLabel = MainLabel(title: "", fontSize: 22, fontWeight: .semibold)
    private let errorMesageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "PIN-коды не совпадают"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.isHidden = true
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#747474")
        label.text = "Введите пин-код"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)
        addSubviews()
        setupLayout()
        initialStateSetup()
        keyboardView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if userPIN != nil {
            checkBiometricType()
        }
    }
    
    private func initialStateSetup() {
        currentCode = ""
        currentActiveIndex = 0
        errorMesageLabel.isHidden = true
        verifyView.verifyFields.forEach { $0.viewState = .initial }
        verifyView.verifyFields.first?.viewState = .active
        if userPIN != nil {
            avatarImageView.isHidden = false
            subLabel.isHidden = false
        }
        mainLabel.text = userPIN != nil ? "Здравствуйте, Сергей!" : "Установите PIN-код"

    }
    
    private func checkBiometricType() {
        let context = LAContext()
        if context.biometryType != .none {
            openPopup(biometryType: context.biometryType)
        }
    }
    
    private func checkAuthorizationCode() {
        guard currentCode.count == 4 else { return }
        
        if currentCode == userPIN {
            openNewViewController()
        } else {
            showErrorState()
        }
    }
    
    private func checkCodeCompletion() {
        guard currentCode.count == 4 else { return }
        
        switch isFirstInput {
        case true:
            firstEnteredCode = currentCode
            isFirstInput = false
            initialStateSetup()
            mainLabel.text = "Подтвердите PIN-код"
        case false:
            secondEnteredCode = currentCode
            validateCodes()
            isFirstInput = true
        }
    }
    
    private func validateCodes() {
        if firstEnteredCode == secondEnteredCode {
            UserDefaultManager.shared.saveValue(secondEnteredCode, forKey: "UserPIN")
            openNewViewController()
        } else {
            showErrorState()
        }
        firstEnteredCode = ""
        secondEnteredCode = ""
    }
    
    private func showErrorState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
            errorMesageLabel.isHidden = false
            verifyView.verifyFields.enumerated().forEach { index, item in
                item.viewState = .error
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.initialStateSetup()
        }
    }
    
    private func updateFieldsStates() {
        verifyView.verifyFields.enumerated().forEach { index, field in
            switch true {
            case index == currentActiveIndex:
                field.viewState = .active
            case index < currentCode.count:
                field.viewState = .filled
            default:
                field.viewState = .initial
            }
        }
    }
    
    private func openNewViewController() {
        let newVC = NewViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    private func openPopup(biometryType: LABiometryType) {
        let popupVC = InformPopUp(type: biometryType == .faceID ? .faceId : .touchId)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.onConsentButtonTapped = { [weak self] in
            self?.authenticateWithBiometrics()
        }
        present(popupVC, animated: true, completion: nil)
    }
    
    func addSubviews() {
        view.addSubview(keyboardView)
        view.addSubview(avatarImageView)
        view.addSubview(subLabel)
        view.addSubview(verifyView)
        view.addSubview(mainLabel)
        view.addSubview(errorMesageLabel)
    }
    
    func setupLayout() {
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMesageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: userPIN != nil ? 108 : 52),
            
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 12),
            
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            verifyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyView.topAnchor.constraint(equalTo: mainLabel.topAnchor, constant: 74),
            
            errorMesageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMesageLabel.topAnchor.constraint(equalTo: verifyView.bottomAnchor, constant: 10),
            
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.heightAnchor.constraint(equalToConstant: 325),
        ])
    }
    
}

// MARK: - KeyboardViewDelegate
extension VerifyViewController: KeyboardViewDelegate {
    func keyboardView(didPressKey key: String) {
        if key == "delete" {
            currentCode = String(currentCode.dropLast())
            currentActiveIndex = currentCode.isEmpty ? 0 : currentCode.count
        } else if currentCode.count < 4 {
            currentCode += key
            currentActiveIndex = currentCode.count < 4 ? currentCode.count : 3
        }
    }
}

// MARK: - Biometric Authentication
private extension VerifyViewController {
    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Подтвердите вашу личность"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.openNewViewController()
                    }
                }
            }
        }
    }
}
