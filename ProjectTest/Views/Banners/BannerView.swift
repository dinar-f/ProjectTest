//
//  BannerView.swift
//  ProjectTest
//
//  Created by Dinar on 23.01.2025.
//

import UIKit

class BannerView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init(message: String) {
        super.init(frame: CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width - 32, height: 100)) 
        backgroundColor = .black
        label.text = message
        addSubview(label)
        label.frame = bounds
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = windowScene.windows.first { $0.isKeyWindow }
            window?.addSubview(self)

            UIView.animate(withDuration: 0.5, animations: {
                self.frame.origin.y = 44
            })
        }
    }
}
