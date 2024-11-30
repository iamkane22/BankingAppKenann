//
//  SignUpController.swift
//  BankingApp
//
//  Created by Kenan on 02.11.24.
//

import UIKit
import RealmSwift
class SignUpController: UIViewController {
    var callback: ((String, Int) -> Void)?
    
    let SignupViewModel = SignUpViewModel()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var createLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var FinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "FIN"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e-mail"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var signupButton: ReusableButton = {
        let button = ReusableButton(title: "SignUP", color: .blue, onaction: {[ weak self ] in self?.signupTapped()})
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTextFields()
    }
    
    @objc func signupTapped() {
        guard let name = nameTextField.text, name.isEmpty == false,
              let email = emailTextField.text, email.isEmpty == false,
              let passwordText = passwordTextField.text, passwordText.isEmpty == false,
              let fin = FinTextField.text, fin.isEmpty == false,
              let password = Int(passwordText)
        else {
            showAlert(title: "error", message: "Please fill correct details" )
            return
        }
        
        let user = User()
        user.name = name
        user.email = email
        user.fin = fin
        user.password = passwordText
        SignUpViewModel().fetchdata(user: user)
        
        callback?(name , password)
        navigationController?.popViewController(animated: true)
        
    }

    private func configureTextFields() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        FinTextField.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(createLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(FinTextField)
        stackView.addArrangedSubview(signupButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            FinTextField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}

extension SignUpController:  UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            if let email = emailTextField.text {
                if email.isEmpty {
                    emailTextField.setBorder(color: .red)
                    
                }
            }
        }
        
        if textField == passwordTextField {
            if let password = passwordTextField.text {
                if password.isEmpty {
                    passwordTextField.setBorder(color: .red)

                    
                }
            }
        }
        
        if textField == nameTextField {
            if let name = nameTextField.text {
                if name.isEmpty {
                    nameTextField.setBorder(color: .red)

                }
            }
        }
        
        if textField == FinTextField {
            if let Fin = FinTextField.text {
                if Fin.isEmpty {
                    FinTextField.setBorder(color:.red)
                }
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == emailTextField {
            if let email = emailTextField.text {
                if email.isValidEmail(email) {
                    emailTextField.setBorder(color: .green)
                } else {
                    emailTextField.setBorder(color: .red)
                    
                }
            }
        }
        if textField == passwordTextField {
            if let password = passwordTextField.text {
                if password.count >= 8 {
                    passwordTextField.setBorder(color: .green)
                } else {
                    passwordTextField.setBorder(color: .red)

                    
                }
            }
        }
        
        if textField == nameTextField {
            if let name = nameTextField.text {
                if name.trimmingCharacters(in: .whitespaces).isEmpty || name.replacingOccurrences(of: " ", with: "").count < 6 {
                    nameTextField.setBorder(color: .red)
                    
                } else {
                    nameTextField.setBorder(color: .green)

                    
                }
            }
        }
        
        if textField == FinTextField {
            if let finText = FinTextField.text {
                if finText.trimmingCharacters(in: .whitespaces).isEmpty || finText.replacingOccurrences(of: " ", with: "").count != 7 {
                    FinTextField.setBorder(color: .red)
                } else {
                    FinTextField.setBorder(color: .green)
                    }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == FinTextField {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return updatedText.count <= 7
        }
        return true
    }
}
