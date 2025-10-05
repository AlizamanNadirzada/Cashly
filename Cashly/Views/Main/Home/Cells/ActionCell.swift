//
//  ActionCell.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.09.25.
//

import UIKit

final class ActionCell: UICollectionViewCell {
    private var action: (() -> Void)?
    
    private let iconView: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .systemBlue
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubviews(iconView, titleLabel)
        
        NSLayoutConstraint.activate([
            // Icon View
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.widthAnchor.constraint(equalToConstant: 30),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configureData(model: ActionCellModel, onTap: @escaping () -> Void) {
        iconView.image = UIImage(systemName: model.iconName)
        titleLabel.text = model.title
        self.action = onTap
    }
    
    func configureTarget() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        action?()
    }
}

