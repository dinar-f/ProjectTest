//
//  RuleItem.swift
//  ProjectTest
//
//  Created by Dinar on 20.01.2025.
//

import UIKit

final class RuleItem: UIView {
    
    // MARK: Private Properties
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0EDFE")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let ruleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hex: "#747474")
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Init
    init(id: Int,text: String) {
        super.init(frame: .zero)
        addSubviews()
        setupView(id: id,text: text)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - Private Methods
private extension RuleItem {
    func addSubviews() {
        addSubview(circleView)
        circleView.addSubview(idLabel)
        addSubview(ruleLabel)
    }
    
    func setupView(id: Int,text: String) {
        idLabel.text = "\(id)"
        ruleLabel.text = text
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        ruleLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        NSLayoutConstraint.activate([
            
            circleView.widthAnchor.constraint(equalToConstant: 32),
            circleView.heightAnchor.constraint(equalToConstant: 32),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            idLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            idLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            ruleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 12),
            ruleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            ruleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
