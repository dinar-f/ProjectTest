//
//  InformBanner.swift
//  ProjectTest
//
//  Created by Dinar on 19.01.2025.
//

import UIKit

final class InformBanner: UIView {
    
// MARK: Private Properties
    private var bannerType: InformBannerType = .normal
    
    private let iconView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

// MARK: - Init
//    init(type:InformBannerType, title: String) {
//        super.init(frame: .zero)
//        self.bannerType = type
//        setupView(title: title)
//        setupLayout()
//        configureAppearance()
//    }
    
    init(viewModel: ViewModel) {
        super.init(frame: .zero)
        self.bannerType = viewModel.type
        setupView(title: viewModel.title)
        setupLayout()
        configureAppearance()
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
extension InformBanner {
    private func setupView(title: String) {
        layer.cornerRadius = 12
        backgroundColor = .white
        layer.borderWidth = 1
        addSubview(iconView)
        addSubview(titleLabel)
        titleLabel.text = title
    }
    
    private func configureAppearance(){
        switch bannerType {
        case .normal:
            iconView.image = UIImage(named: "blueAlert")
            layer.borderColor = UIColor(hex: "#196CFC")?.cgColor
        case .error:
            iconView.image = UIImage(named: "redAlert")
            layer.borderColor = UIColor(hex: "#F54545")?.cgColor
        }
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
}

// MARK: - InformBannerType
extension InformBanner {
    enum InformBannerType {
        case normal
        case error
    }
}

// MARK: - ViewModel
extension InformBanner {
    struct ViewModel {
        let type: InformBannerType
        let title: String
    }
}
