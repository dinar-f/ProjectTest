//
//  Customloader.swift
//  ProjectTest
//
//  Created by Dinar on 18.01.2025.
//

import UIKit

final class SpinnerLoader: UIView {
    
    var isLoading = true {
        didSet {
            toggleAnimation()
        }
    }
    
// MARK: Private Properties
    private var circleLayer = CAShapeLayer()
    
// MARK: - Init
    init(color: Color, size: Size) {
        super.init(frame: .zero)
        setupLoader(color: color)
        toggleAnimation()
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: size.dimensions.width),
            self.heightAnchor.constraint(equalToConstant: size.dimensions.height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth / 2
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                radius: radius,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: true)
        circleLayer.path = path.cgPath
    }
}

    // MARK: - Public Properties
extension SpinnerLoader {
    enum Color {
        case white
        case red
        case blue
        
        var strokeStroke: CGColor? {
            switch self {
            case .white:
                return UIColor.white.cgColor
            case .red:
                return UIColor(hex: "#FC3F1D")?.cgColor
            case .blue:
                return UIColor(hex: "#0066B3")?.cgColor
            }
        }
    }
    
    enum Size {
        case small
        case normal
        
        var dimensions: CGSize {
            switch self {
            case .small:
                return CGSize(width: 24, height: 24)
            case .normal:
                return CGSize(width: 40, height: 40)
            }
        }
    }
}

// MARK: - Private Methods
private extension SpinnerLoader {
    func setupLoader(color: Color) {
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color.strokeStroke
        circleLayer.lineWidth = 3.0
        layer.addSublayer(circleLayer)
    }
    
    func toggleAnimation() {
        if isLoading {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1.0
            animation.repeatCount = .infinity
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            circleLayer.add(animation, forKey: Consts.loaderKey)
        } else {
            circleLayer.removeAnimation(forKey: Consts.loaderKey)
        }
    }
}

// MARK: - Consts
extension SpinnerLoader {
    enum Consts {
        static let loaderKey = "loadingAnimation"
    }
}
