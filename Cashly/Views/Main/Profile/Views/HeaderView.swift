//
//  HeaderView.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 28.09.25.
//

import UIKit

final class HeaderView: UIView {
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .personIcon)
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
        configureConstraints()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(profileLabel)
        addSubview(borderView)
        addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        borderView.addSubview(imageView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // Profile label
            profileLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            profileLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // Border View
            borderView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 16),
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            borderView.heightAnchor.constraint(equalToConstant: 80),
            borderView.widthAnchor.constraint(equalToConstant: 80),
            
            // Image View
            imageView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -12),
            imageView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -12),
            
            // Stack View
            stackView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: 16)
        ])
    }
    
    func configureData(user: UserObject) {
        nameLabel.text = user.name + " " + user.surname
        emailLabel.text = user.email
    }
}
