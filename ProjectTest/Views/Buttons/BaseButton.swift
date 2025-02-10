//
//  NewButton.swift
//  ProjectTest
//
//  Created by Dinar on 08.02.2025.
//

import UIKit

final class BaseButton: UIButton {
    
    var viewType: BaseButtonType = .primary
    override var isEnabled: Bool {
        didSet {
            updateBackground()
        }
    }
    
    var isLoading = false{
        didSet {
            updateView()
        }
    }
    
    // MARK: Private Properties
    private let spinner = SpinnerLoader(color: .white, size: .small)
    
    init(title: String, type: BaseButtonType) {
        super.init(frame: .zero)
        self.viewType = type
        self.isEnabled = true
        setTitle(title, for: .normal)
        setupView(with: viewType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
private extension BaseButton {
    
    func setupView(with viewType : BaseButtonType) {
        layer.cornerRadius = 12
        layer.borderWidth = 1
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        setTitleColor(viewType.enabledTextColor, for: .normal)
        layer.borderColor = viewType.borderColor.cgColor
    }
    
    func updateBackground() {
        if isEnabled {
            backgroundColor = viewType.enabledBackgroundColor
        } else {
            backgroundColor = viewType.disabledBackgroundColor
        }
    }
    
    func updateView(){
        if isLoading == true {
            setTitle(nil, for: .normal)
            spinner.isHidden = false
        } else {
            spinner.isHidden = true
        }
    }
}


// MARK: - Public Properties
extension BaseButton {
    enum BaseButtonType {
        case primary
        case secondary
        
        var enabledBackgroundColor: UIColor {
            switch self {
            case .primary:
                return UIColor(hex: "#196CFC") ?? .clear
            case .secondary:
                return .white
            }
        }
        
        var enabledTextColor: UIColor {
            switch self {
            case .primary:
                return .white
            case .secondary:
                return .black
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .primary:
                return .clear
            case .secondary:
                return UIColor(hex: "#E0E0E0") ?? .clear  // Почему обязательно нужно задавать деволтное значение
            }
        }
        
        var disabledBackgroundColor: UIColor {
            return UIColor(hex: "#F0F0F0") ?? .clear
        }
    }
}
