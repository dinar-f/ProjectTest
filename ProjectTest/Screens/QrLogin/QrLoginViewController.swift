//
//  QrLoginViewController.swift
//  ProjectTest
//
//  Created by Dinar on 19.01.2025.
//

import UIKit

class QrLoginViewController: UIViewController {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация через QR"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector (closeQrLoginView), for: .touchUpInside)
        return button
    }()
    
    private let qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "qrLoginBanner")
        return imageView
    }()
    
    private let mainButtonBackgroungView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let mainButton = BaseButton(title: "Сканировать QR-код")
    private let informBanner = InformBanner(viewModel: .init(type: .normal, title: "Данная опция возможна только в случае, если на компьютере вы авторизованы при помощи почты и пароля."))
    
    private let rulesListStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
    }
    
    func addSubviews(){
        view.addSubview(mainLabel)
        view.addSubview(closeButton)
        contentStackView.addArrangedSubview(qrImageView)
        createRuleItemViews()
        contentStackView.addArrangedSubview(rulesListStackView)
        contentStackView.addArrangedSubview(informBanner)
        view.addSubview(contentStackView)
        mainButtonBackgroungView.addSubview(mainButton)
        view.addSubview(mainButtonBackgroungView)
        
        
        scrollView.addSubview(contentStackView)
        view.addSubview(scrollView)
        
//        view.insertSubview(contentStackView, aboveSubview: mainButtonBackgroungView)
    }
    
    func createRuleItemViews() {
        let ruleItems = ViewModel().ruleItems
        for ruleItem in ruleItems {
            let ruleItemView = RuleItem(id: ruleItem.id, text: ruleItem.text)
            rulesListStackView.addArrangedSubview(ruleItemView)
        }
    }
    
    func setupLayout(){
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        qrImageView.translatesAutoresizingMaskIntoConstraints = false
        informBanner.translatesAutoresizingMaskIntoConstraints = false
        rulesListStackView.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButtonBackgroungView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo:  mainLabel.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: mainButtonBackgroungView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            mainLabel.heightAnchor.constraint(equalToConstant: .init(28)),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
          
            mainButtonBackgroungView.heightAnchor.constraint(equalToConstant: 122),
            mainButtonBackgroungView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainButtonBackgroungView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainButtonBackgroungView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            mainButton.heightAnchor.constraint(equalToConstant: 56),
            mainButton.leadingAnchor.constraint(equalTo: mainButtonBackgroungView.leadingAnchor, constant: 16),
            mainButton.rightAnchor.constraint(equalTo: mainButtonBackgroungView.rightAnchor, constant: -16),
            mainButton.topAnchor.constraint(equalTo: mainButtonBackgroungView.topAnchor, constant: 16),
        ])
    }
    
    @objc private func closeQrLoginView() {
        dismiss(animated: true, completion: nil)
    }
//    
//    func createRuleItemViews() {
//        let ruleItems = ViewModel().ruleItems
//        for viewModel in ruleItems {
//            let view = UIView()
//            view.configure(with: viewModel)
//            stackView.addArangedSubview(view)
//        }
//    }
//    
//    func setupSubviews() {
//        stackView.addArangedSubview(titleLabel)
//        stackView.addArangedSubview(imageView)
//        createRuleItemViews()
//        
//    }
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
