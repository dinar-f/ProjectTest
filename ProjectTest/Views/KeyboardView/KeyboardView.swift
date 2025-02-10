//
//  KeyboardView.swift
//  ProjectTest
//
//  Created by Dinar on 28.01.2025.
//

import UIKit

protocol KeyboardViewDelegate: AnyObject {
    func keyboardView(didPressKey key: String)
}

class KeyboardView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    weak var delegate: KeyboardViewDelegate?
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setDelegates()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(collectionView)
        collectionView.register(KeyButtonCell.self, forCellWithReuseIdentifier: "KeyButtonCell")
        collectionView.register(IconButtonCell.self, forCellWithReuseIdentifier: "IconButtonCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCell")
        collectionView.collectionViewLayout = createLayout()
    }
    
    func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let isLastRow = sectionIndex == 3
            
            if !isLastRow {
                return self.createFullNumbersSection()
            } else {
                return self.createOneNumbersSection()
            }
        }
    }
    
    private func createFullNumbersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                              heightDimension: .absolute(64))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(64))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])
        group.interItemSpacing = .fixed(8)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        return section
    }
    
    private func createOneNumbersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                heightDimension: .absolute(64))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(64))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0,1,2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyButtonCell", for: indexPath) as? KeyButtonCell else { return
                UICollectionViewCell()}
            var title = ""
            switch indexPath.section {
            case 0: title = "\(indexPath.item + 1)"
            case 1: title = "\(indexPath.item + 4)"
            case 2: title = "\(indexPath.item + 7)"
            default: break
            }
            cell.configureCell(itemLabel: title)
            return cell
        case 3:
            switch indexPath.item {
            case 0:
                return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyButtonCell", for: indexPath) as? KeyButtonCell else { return UICollectionViewCell() }
                cell.configureCell(itemLabel: "0")
                return cell
            case 2:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconButtonCell", for: indexPath) as? IconButtonCell else { return
                    UICollectionViewCell()}
                return cell
            default:
                return UICollectionViewCell()
            }
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var key: String = ""
        switch indexPath.section {
        case 0, 1, 2:
            key = "\(indexPath.item + 1 + indexPath.section * 3)"
        case 3:
            if indexPath.item == 1 {
                key = "0"
            } else if indexPath.item == 2 {
                key = "delete"
            }
        default:
            break
        }
        delegate?.keyboardView(didPressKey: key)
    }
}

