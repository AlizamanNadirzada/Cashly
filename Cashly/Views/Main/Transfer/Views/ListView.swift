//
//  ListView.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 21.10.25.
//

import UIKit

class ListView: UIView {
    var selectTitle: String
    private var selectedCard: CardEntity?
    
    private let borderView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "chevron.down")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .base01
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let cardNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoView: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "chevron.down"))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .base01
        icon.isHidden = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    init(selectTitle: String) {
        self.selectTitle = selectTitle
        super.init(frame: .zero)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        borderView.backgroundColor = .white
        borderView.layer.cornerRadius = 8
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOpacity = 0.1
        borderView.layer.shadowOffset = CGSize(width: 0, height: 4)
        borderView.layer.shadowRadius = 8
    }
    
    private func configureUI() {
        addSubview(borderView)
        borderView.addSubviews(titleLabel, iconView, cardNameLabel, balanceLabel, logoView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = selectTitle
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // Border View
            borderView.topAnchor.constraint(equalTo: topAnchor),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 56),
            
            // Select Label
            titleLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 12),
            
            // Icon View
            iconView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -12),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            
            // Logo
            logoView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor),
            logoView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 8),
            logoView.heightAnchor.constraint(equalToConstant: 32),
            logoView.widthAnchor.constraint(equalToConstant: 32),
            
            // Card Name
            cardNameLabel.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 8),
            cardNameLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 12),
            
            // Balance Label
            balanceLabel.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -8),
            balanceLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 12)
        ])
    }
    
    func setSelectedCard(_ card: CardEntity) {
        selectedCard = card
        cardNameLabel.text = card.type
        balanceLabel.text = "₼ \(card.balance)"
        logoView.image = UIImage(named: card.logo)
        
        titleLabel.isHidden = true
        cardNameLabel.isHidden = false
        balanceLabel.isHidden = false
        logoView.isHidden = false
    }
    
    func reset() {
        selectedCard = nil
        titleLabel.isHidden = false
        cardNameLabel.isHidden = true
        balanceLabel.isHidden = true
        logoView.isHidden = true
    }
}
