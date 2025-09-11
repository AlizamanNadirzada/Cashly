//
//  BaseField.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 25.08.25.
//

import UIKit

class BaseField: UIView {
    var numberLimit: Int?
    
    private let containerView = UIView()
    private let textField = UITextField()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    var placeholder: String = "" {
        didSet { placeholderLabel.text = placeholder }
    }
    
    var isSecure: Bool {
        get { textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }
    
    var keyboardType: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    
    var inputViewCustom: UIView? {
        get { textField.inputView }
        set { textField.inputView = newValue }
    }
    
    var inputAccessoryViewCustom: UIView? {
        get { textField.inputAccessoryView }
        set { textField.inputAccessoryView = newValue }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue; updatePlaceholder() }
    }
    
    var errorMessage: String? {
        didSet {
            let hasError = !(errorMessage?.isEmpty ?? true)
            errorLabel.text = errorMessage
            errorLabel.isHidden = !hasError
            containerView.layer.borderColor = hasError ? UIColor.red.cgColor : UIColor.secondaryLabel.cgColor
            
            invalidateIntrinsicContentSize()
        }
    }
    
    weak var delegate: UITextFieldDelegate? {
        didSet { textField.delegate = self }
    }
    
    private var placeholderTopConstraint: NSLayoutConstraint!
    private var placeholderCenterConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
        
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        containerView.layer.borderWidth = 0.2
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        containerView.layer.cornerRadius = 8
        
        textField.delegate = self
        
        // Add container and error label to mainView
        [containerView, errorLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        // Add textField and placeholder to container
        [textField, placeholderLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
    }
    
    private func configureConstraints() {
        placeholderTopConstraint = placeholderLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8)
        placeholderCenterConstraint = placeholderLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        
        NSLayoutConstraint.activate([
            /// Container View
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 56),
            
            /// Text Field
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            /// PlaceHolder
            placeholderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            placeholderCenterConstraint,
            
            /// Error Label
            errorLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 6),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func textChanged() {
        updatePlaceholder()
        errorMessage = nil
    }
    
    private func updatePlaceholder() {
        let shouldFloat = !(textField.text ?? "").isEmpty || textField.isFirstResponder
        
        UIView.animate(withDuration: 0.2) {
            if shouldFloat {
                self.placeholderCenterConstraint.isActive = false
                self.placeholderTopConstraint.isActive = true
                self.placeholderLabel.font = .systemFont(ofSize: 12)
            } else {
                self.placeholderTopConstraint.isActive = false
                self.placeholderCenterConstraint.isActive = true
                self.placeholderLabel.font = .systemFont(ofSize: 16)
            }
            self.containerView.layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let containerHeight: CGFloat = 56
        let errorHeight = errorLabel.isHidden ? 0 : errorLabel.intrinsicContentSize.height + 6
        return CGSize(width: UIView.noIntrinsicMetric, height: containerHeight + errorHeight)
    }
}

extension BaseField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updatePlaceholder()
        delegate?.textFieldDidBeginEditing?(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatePlaceholder()
        delegate?.textFieldDidEndEditing?(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn?(textField) ?? true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard let limit = numberLimit else { return true }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= limit
    }
}

extension BaseField {
    @discardableResult
    func validateNotEmpty() -> Bool {
        guard let text = text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "\(placeholder) cannot be empty"
            return false
        }
        
        errorMessage = nil
        return true
    }
    
    func validateEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text) {
            errorMessage = "Email is wrong format"
            return false
        }
        errorMessage = nil
        return true
    }
    
    func validatePassword(minLength: Int = 8) -> Bool {
        guard let text = text else { return false }
        if text.count < minLength {
            errorMessage = "Password must be at least \(minLength) characters long"
            return false
        }
        errorMessage = nil
        return true
    }
    
    func validateConfirmPassword(match textToMatch: String) -> Bool {
        guard let text = text else { return false }
        if text != textToMatch {
            errorMessage = "Passwords do not match"
            return false
        }
        errorMessage = nil
        return true
    }
}

