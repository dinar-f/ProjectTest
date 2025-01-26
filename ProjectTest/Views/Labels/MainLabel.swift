//
//  MainLabel.swift
//  ProjectTest
//
//  Created by Dinar on 24.01.2025.
//

import UIKit

final class MainLabel: UILabel {
    
    init(title: String, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        setupView(title: title, fontSize: fontSize, fontWeight: fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(title: String, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        font = .systemFont(ofSize: fontSize, weight: fontWeight)
        text = title
    }
}
