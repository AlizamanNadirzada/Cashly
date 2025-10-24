//
//  AccountCardCell.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 21.10.25.
//

import Foundation

import UIKit

final class AccountCardCell: UICollectionViewCell {
    private let iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func configureUI() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        
        addSubviews(iconView, nameLabel, balanceLabel, cardNumberLabel)
        
        NSLayoutConstraint.activate([
            // Icon View
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 40),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            
            // Name Label
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: balanceLabel.leadingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            // Balance Label
            balanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            balanceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Number Label
            cardNumberLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            cardNumberLabel.trailingAnchor.constraint(lessThanOrEqualTo: balanceLabel.leadingAnchor, constant: -8),
            cardNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func configure(with card: CardEntity) {
        iconView.image = UIImage(named: card.logo)
        nameLabel.text = card.type
        balanceLabel.text = "\(card.balance) ₼"
        cardNumberLabel.text = "**** \(card.last4Digits)"
    }

}
