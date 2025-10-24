//
//  TransferViewController.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 21.10.25.
//

import UIKit

final class TransferViewController: BaseViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Transfer between my cards"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let senderView = ListView(selectTitle: "Selected From Card")
    private let receiverView = ListView(selectTitle: "Selected To Card")
    private let transferViewModel = TransferViewModel()

    private let amountField: BaseField = {
        let field = BaseField()
        field.placeholder = "Amount"
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Transfer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .base01
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, senderView, receiverView, amountField, actionButton)
        
        senderView.translatesAutoresizingMaskIntoConstraints = false
        receiverView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Sender View
            senderView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            senderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            senderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            senderView.heightAnchor.constraint(equalToConstant: 56),
            
            // Receiver View
            receiverView.topAnchor.constraint(equalTo: senderView.bottomAnchor, constant: 20),
            receiverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            receiverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            receiverView.heightAnchor.constraint(equalToConstant: 56),
            
            // Amount Field
            amountField.topAnchor.constraint(equalTo: receiverView.bottomAnchor, constant: 20),
            amountField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            amountField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Action Button
            actionButton.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            actionButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    override func configureActions() {
        senderView.isUserInteractionEnabled = true
        receiverView.isUserInteractionEnabled = true

        let clickSender = UITapGestureRecognizer(target: self, action: #selector(fromTapped))
        senderView.addGestureRecognizer(clickSender)
        
        let clickReceiver = UITapGestureRecognizer(target: self, action: #selector(toTapped))
        receiverView.addGestureRecognizer(clickReceiver)
        
        actionButton.addTarget(self, action: #selector(transferTapped), for: .touchUpInside)
        
        transferViewModel.onUpdate = { [weak self] in
            self?.updateTransferButton()
        }
    }
    
    @objc private func fromTapped() {
        let controller = AccountViewController(viewModel: AccountViewModel())
        controller.onCardSelected = { [weak self] card in
            guard let self = self else { return }

            self.transferViewModel.selectedFromCard = card
            self.senderView.setSelectedCard(card)

            if self.transferViewModel.selectedToCard?.id == card.id {
                self.transferViewModel.resetToCard()
                self.receiverView.reset()
            }
        }
        present(controller, animated: true)
    }

    @objc private func toTapped() {
        let controller = AccountViewController(viewModel: AccountViewModel())
        controller.onCardSelected = { [weak self] card in
            guard let self = self else { return }

            self.transferViewModel.selectedToCard = card
            self.receiverView.setSelectedCard(card)

            if self.transferViewModel.selectedFromCard?.id == card.id {
                self.transferViewModel.resetFromCard()
                self.senderView.reset()
            }
        }
        present(controller, animated: true)
    }
    
    @objc func transferTapped() {
        
    }
    
    private func updateTransferButton() {
        let isEnabled = transferViewModel.selectedFromCard != nil &&
        transferViewModel.selectedToCard != nil
        
        actionButton.isEnabled = isEnabled
        actionButton.alpha = isEnabled ? 1.0 : 0.5
    }
}
