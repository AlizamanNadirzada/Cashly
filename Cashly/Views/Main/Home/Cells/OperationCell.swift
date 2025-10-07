//
//  OperationCell.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 03.10.25.
//

import UIKit

final class OperationCell: UICollectionViewCell {
    private let iconview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let getButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubviews(iconview, titleLabel, getButton)
        
        NSLayoutConstraint.activate([
            // Icon View
            iconview.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconview.heightAnchor.constraint(equalToConstant: 26),
            iconview.widthAnchor.constraint(equalToConstant: 26),
            
            // Title Label
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconview.trailingAnchor, constant: 16),
             
            // Button
            getButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            getButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configureData(model: OperationCellModel) {
        iconview.image = UIImage(systemName: "\(model.iconName)")
        titleLabel.text = model.title
    }
}
