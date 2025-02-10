//
//  IconButtonCell.swift
//  ProjectTest
//
//  Created by Dinar on 29.01.2025.
//

import UIKit

class IconButtonCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "deleteIcon"), for: .normal)
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
}
