//
//  CardCell.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 30.09.25.
//

import UIKit

final class CardCell: UICollectionViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cashly"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func configureUI() {
        addSubviews(nameLabel, iconView, amountLabel, dateLabel, cardNumberLabel)
        
        self.layer.borderColor = UIColor.systemYellow.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        gradientLayer.colors = [
            UIColor.lightGray.withAlphaComponent(0.3).cgColor,
            UIColor(hex: "00AF32").cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.locations = [0.0, 0.9, 0.7]
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // Name Label
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            // Icon View
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            iconView.widthAnchor.constraint(equalToConstant: 57),
            
            // Amount Label
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            // Date Label
            cardNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cardNumberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            // Card Number
            dateLabel.bottomAnchor.constraint(equalTo: cardNumberLabel.topAnchor, constant: -8),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}

extension CardCell {
    func configureData(with model: CardEntity) {
        amountLabel.text = "\(model.balance)₼"
        dateLabel.text = "\(format(date: model.expiryDate))"
        cardNumberLabel.text = "**** \(model.last4Digits)"
        iconView.image = UIImage(named: model.logo)
    }
    
    private func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter.string(from: date)
    }
}

