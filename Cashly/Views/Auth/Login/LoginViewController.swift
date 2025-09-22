//
//  LoginViewController.swift
//  Cashly
//
//  Created by Nadirzada Alizaman on 25.08.25.
//

import UIKit
import Lottie

final class LoginViewController: BaseViewController {
    // MARK: - UI Elements
    private let lottieView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loginAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.play()
        return animationView
    }()

    
    private let emailTextField: BaseField = {
        let field = BaseField()
        field.placeholder = "Type Your Email Here"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordTextField: BaseField = {
        let field = BaseField()
        field.placeholder = "Password"
        field.isSecure = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(.base01, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account ?"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register Now", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.base01, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let registerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
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
        
        checkValidity()
    }
    
    // MARK: - Setup
    override func configureUI() {
        view.addSubviews(lottieView,
                         emailTextField,
                         passwordTextField,
                         forgotButton,
                         okButton ,
                         registerStack)
        
        registerStack.addArrangedSubviews(registerLabel, registerButton)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            /// Lottie
            lottieView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            lottieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lottieView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lottieView.heightAnchor.constraint(equalToConstant: 400),
            
            /// Email
            emailTextField.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            /// Password
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            /// Forget Button
            forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            forgotButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            /// Login Button
            okButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 16),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.heightAnchor.constraint(equalToConstant: 56),
            okButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
            
            /// Register Stack
            registerStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            registerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func configureActions() {
        registerButton.addTarget(self, action: #selector(getRegister), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
    }
    
    @objc func getRegister() {
        viewModel.showRegister()
    }
    
    @objc func forgotTapped() {
        let alert = UIAlertController(title: "Forgot Password",
                                      message: "This feature isn’t available at the moment.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func loginTapped() {
        let emailValid = emailTextField.validateNotEmpty() && emailTextField.validateEmail()
        let passwordValid = passwordTextField.validateNotEmpty() && passwordTextField.validatePassword()
        
        if emailValid && passwordValid {
            viewModel.login(
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? ""
            )
        }
    }
    
    func checkValidity() {
        viewModel.onError = { [weak self] message in
            self?.showErrorAlert(message: message)
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert,animated: true)
    }
}
