//
//  RegisterViewController.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 25.08.25.
//

import UIKit
import RealmSwift

final class RegisterViewController: BaseViewController {
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .register
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameField: BaseField = {
        let field = BaseField()
        field.placeholder = "Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let surnameField: BaseField = {
        let field = BaseField()
        field.placeholder = "Surname"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let emailField: BaseField = {
        let field = BaseField()
        field.placeholder = "Type Your Email Here"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let phoneField: BaseField = {
        let field = BaseField()
        field.placeholder = "Phone"
        field.keyboardType = .phonePad
        field.numberLimit = 13
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: BaseField = {
        let field = BaseField()
        field.placeholder = "Password"
        field.isSecure = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let confirmPassword: BaseField = {
        let field = BaseField()
        field.placeholder = "Confirm Password"
        field.isSecure = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let birthdayField: BaseField = {
        let field = BaseField()
        field.placeholder = "Enter your Birthday"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let birthdayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.backgroundColor = .systemBackground
        picker.maximumDate = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Already Have an Account ?"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.base01, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    private let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        okButton.backgroundColor = .button01
        okButton.layer.cornerRadius = okButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePicker()
        
        let realm = try! Realm()
        print(realm.configuration.fileURL)
    }
    
    // MARK: - Setup
    override func configureUI() {
        view.addSubviews(imageView, scrollView, okButton, loginStack)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubviews(nameField,
                                      surnameField,
                                      emailField,
                                      phoneField,
                                      passwordField,
                                      confirmPassword,
                                      birthdayField)
        
        loginStack.addArrangedSubviews(loginLabel, loginButton)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            /// Title Label
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            
            /// Scroll View
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -32),
            
            /// Stack View
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48),
            
            /// Register Button
            okButton.bottomAnchor.constraint(equalTo: loginStack.topAnchor, constant: -16),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 56),
            okButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
            
            /// Login Stack
            loginStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            birthdayField.heightAnchor.constraint(greaterThanOrEqualToConstant: 56)
        ])
    }
    
    override func configureActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        viewModel.showLogin()
    }
    
    @objc func registerTapped() {
        guard validateFields() else { return }
        
        let user = createUserEntity()
        viewModel.register(user: user)
    }

    private func validateFields() -> Bool {
        nameField.validateNotEmpty()
        surnameField.validateNotEmpty()
        phoneField.validateNotEmpty()
        birthdayField.validateNotEmpty()
        
        let emailNotEmpty = emailField.validateNotEmpty()
        let passwordNotEmpty = passwordField.validateNotEmpty()
        let confirmNotEmpty = confirmPassword.validateNotEmpty()
        
        let emailValid = emailNotEmpty && emailField.validateEmail()
        let passwordValid = passwordNotEmpty && passwordField.validatePassword()
        let confirmValid = confirmNotEmpty && confirmPassword.validateConfirmPassword(match: passwordField.text ?? "")
        
        return emailValid && passwordValid && confirmValid
    }

    private func createUserEntity() -> UserEntity {
        UserEntity(
            id: UUID().uuidString,
            name: nameField.text ?? "",
            surname: surnameField.text ?? "",
            email: emailField.text ?? "",
            phone: phoneField.text ?? "",
            password: passwordField.text ?? "",
            birthday: birthdayPicker.date
        )
    }
    
    private func setupDatePicker() {
        birthdayField.inputViewCustom = birthdayPicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([space, doneButton], animated: true)
        
        birthdayField.inputAccessoryViewCustom = toolbar
    }
        
        @objc private func donePressed() {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            birthdayField.text = formatter.string(from: birthdayPicker.date)
            view.endEditing(true)
        }
}
