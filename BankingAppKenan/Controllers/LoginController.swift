import UIKit

class LoginController: UIViewController {
    
    var viewmodel: LoginViewModel
    
    required init(viewmodel: LoginViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var loginButton: ReusableButton = {
        ReusableButton(title: "Login", color: .blue, onaction: { [weak self] in self?.loginTapped() })
    }()
    
    let nametextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let paswordtextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLoginUI()
        bindViewModel() 
    }
    
    private func setupLoginUI() {
        view.addSubview(nametextField)
        view.addSubview(paswordtextField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        nametextField.translatesAutoresizingMaskIntoConstraints = false
        paswordtextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nametextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nametextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nametextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nametextField.heightAnchor.constraint(equalToConstant: 50),
            
            paswordtextField.topAnchor.constraint(equalTo: nametextField.bottomAnchor, constant: 20),
            paswordtextField.leadingAnchor.constraint(equalTo: nametextField.leadingAnchor),
            paswordtextField.trailingAnchor.constraint(equalTo: nametextField.trailingAnchor),
            paswordtextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: paswordtextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: nametextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: nametextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
         
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewmodel.loginResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.navigateToTabbar()
                case .failure(let error):
                    self?.showAlert(title: "Login Failed", message: error.localizedDescription)
                }
            }
        }
    }

    @objc private func signUpTapped() {
        let signUpVC = SignUpController()
        signUpVC.callback = { [weak self] username, password in
            self?.nametextField.text = username
            self?.paswordtextField.text = "\(password)"
        }
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func loginTapped() {
        guard let username = nametextField.text,
              let passwordText = paswordtextField.text else {
            showAlert(title: "Error", message: "Please enter valid inputs.")
            return
        }

        viewmodel.login(username: username, password: passwordText)
    }

    private func navigateToTabbar() {
        let tabbarVC = Tabbar()
        navigationController?.pushViewController(tabbarVC, animated: true)
    }

}

