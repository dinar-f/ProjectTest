//
//  QrLoginViewController.swift
//  ProjectTest
//
//  Created by Dinar on 19.01.2025.
//

import UIKit

class QrLoginViewController: BaseViewController {
    
    private let scrollView = UIScrollView()
    private let scrollViewContent = UIView()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector (closeQrLoginView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qrLoginBanner")
        return imageView
    }()
    
    private let mainButton = BaseButton(title: "Сканировать QR-код", type: .primary)
    private let informBanner = InformBanner(viewModel: .init(type: .normal, title: "Данная опция возможна только в случае, если на компьютере вы авторизованы при помощи почты и пароля."))
    
    private let rulesListStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        addSubviews()
        setupLayout()
        setupButtonTargets()
    }
    
    private func setupButtonTargets() {
        mainButton.addTarget(self, action: #selector(openQRScanner), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        title = "Авторизация через QR"
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
    
    func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        scrollViewContent.addSubview(qrImageView)
        scrollViewContent.addSubview(rulesListStackView)
        createRuleItemViews()
        scrollViewContent.addSubview(informBanner)
        view.addSubview(mainButton)
    }
    
    func createRuleItemViews() {
        let ruleItems = ViewModel().ruleItems
        for ruleItem in ruleItems {
            let ruleItemView = RuleItem(id: ruleItem.id, text: ruleItem.text)
            rulesListStackView.addArrangedSubview(ruleItemView)
        }
    }
    
    func setupLayout(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        qrImageView.translatesAutoresizingMaskIntoConstraints = false
        rulesListStackView.translatesAutoresizingMaskIntoConstraints = false
        informBanner.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor ,constant: -88),
            
            scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            scrollViewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            qrImageView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16),
            qrImageView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16),
            qrImageView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 0),
            
            rulesListStackView.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16),
            rulesListStackView.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16),
            rulesListStackView.topAnchor.constraint(equalTo: qrImageView.bottomAnchor, constant: 24),
            
            informBanner.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16),
            informBanner.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16),
            informBanner.topAnchor.constraint(equalTo: rulesListStackView.bottomAnchor, constant: 24),
            informBanner.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -20),
            
            mainButton.heightAnchor.constraint(equalToConstant: 56),
            mainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
        ])
    }
}

// MARK: - Navigation Handlers
@objc extension QrLoginViewController {
    
    //Почему QRScannerViewController открывается как present, а не как обычный экран
    private func openQRScanner() {
        let qrScannerVC = QRScannerViewController()
        navigationController?.pushViewController(qrScannerVC, animated: true)
    }
    
    private func closeQrLoginView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - ViewModel
extension QrLoginViewController {
    struct ViewModel {
        let ruleItems: [RuleInfo] = [
            .init(id: 1, text: "Зайдите в ваш личный кабинет на компьютере"),
            .init(id: 2, text: "Перейдите в раздел Профиль > Привязать устройство по QR-коду"),
            .init(id: 3, text: "Наведите телефон на экран, чтобы просканировать QR-код")
            
        ]
        let tipText: String = """
                              Данная опция возможна только 
                              в случае, если на компьютере 
                              вы авторизованы при помощи почты 
                              и пароля.
                              """
    }
    
    struct RuleInfo {
        let id: Int
        let text: String
    }
}
