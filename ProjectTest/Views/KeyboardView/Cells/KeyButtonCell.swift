//
//  Untitled.swift
//  ProjectTest
//
//  Created by Dinar on 28.01.2025.
//

import UIKit

class KeyButtonCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#F5F5F5")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        button.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(button)
    }
    
    func configureCell(itemLabel: String) {
        button.setTitle(itemLabel, for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.allowUserInteraction, .curveEaseOut]) {
                self.button.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.allowUserInteraction, .curveEaseOut]) {
                self.button.transform = .identity
            }
    }
}
