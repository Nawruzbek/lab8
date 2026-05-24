import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "💊 Аптека"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваше здоровье - наша забота"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Пароль"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Вход", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Регистрация", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Забыли пароль?", for: .normal)
        btn.setTitleColor(.systemGray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
        setupActions()
        checkAutoLogin()
        setupTextFieldDelegates()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Setup
    private func setupGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(cardView)
        
        cardView.addSubview(emailTextField)
        cardView.addSubview(passwordTextField)
        cardView.addSubview(loginButton)
        cardView.addSubview(registerButton)
        cardView.addSubview(forgotPasswordButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            cardView.heightAnchor.constraint(equalToConstant: 320),
            
            emailTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32),
            emailTextField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            registerButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            registerButton.widthAnchor.constraint(equalToConstant: 120),
            registerButton.heightAnchor.constraint(equalToConstant: 48),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }
    
    private func setupTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func checkAutoLogin() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            print("🟢 Auto-login: пользователь уже авторизован")
            navigateToMainScreen()
        }
    }
    
    // MARK: - Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    // MARK: - Actions
    @objc private func loginTapped() {
        print("🟢 Login button tapped")
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Заполните все поля")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(message: "Введите корректный email адрес")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(message: "Пароль должен содержать минимум 6 символов")
            return
        }
        
        let savedEmail = UserDefaults.standard.string(forKey: "userEmail")
        let savedPassword = UserDefaults.standard.string(forKey: "userPassword")
        
        print("🟢 Введено: \(email), Сохранено: \(savedEmail ?? "nil")")
        
        if email == savedEmail && password == savedPassword {
            print("🟢 Логин успешен")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            navigateToMainScreen()
        } else {
            print("🔴 Неверные учетные данные")
            showAlert(message: "Неверный email или пароль")
        }
    }
    
    @objc private func registerTapped() {
        print("🟢 Register button tapped")
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Заполните все поля")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(message: "Введите корректный email адрес")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(message: "Пароль должен содержать минимум 6 символов")
            return
        }
        
        let existingEmail = UserDefaults.standard.string(forKey: "userEmail")
        if email == existingEmail {
            showAlert(message: "Пользователь с таким email уже существует")
            return
        }
        
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        print("🟢 Регистрация успешна для: \(email)")
        
        showAlert(message: "Регистрация успешна!") { [weak self] in
            print("🟢 Переход на главный экран после регистрации")
            self?.navigateToMainScreen()
        }
    }
    
    @objc private func forgotPasswordTapped() {
        showAlert(message: "Для восстановления пароля обратитесь к администратору")
    }
    
    private func navigateToMainScreen() {
        print("🟢 navigateToMainScreen вызван")
        
        let mainVC = MedicinesViewController()
        let navController = UINavigationController(rootViewController: mainVC)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        
        // Если уже есть представленный контроллер, сначала его закроем
        if presentedViewController != nil {
            dismiss(animated: false) { [weak self] in
                self?.present(navController, animated: true) {
                    print("🟢 Главный экран показан (после закрытия старого)")
                }
            }
        } else {
            present(navController, animated: true) {
                print("🟢 Главный экран показан")
            }
        }
    }
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginTapped()
        }
        return true
    }
}
