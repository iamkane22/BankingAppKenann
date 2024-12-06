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
        return textField
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
        ])
    }
    
    private func bindViewModel() {
        viewmodel.loginResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let username):
                    self?.navigateToMainApp(username: username)
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    @objc func loginTapped() {
        guard let username = nametextField.text,
              let passwordText = paswordtextField.text,
              let password = Int(passwordText) else {
            showAlert(title: "Error", message: "Please enter valid inputs.")
            return
        }
        viewmodel.login(username: username, password: password)
    }
    
    private func navigateToMainApp(username: String) {
        let tabBar = Tabbar()
        if let profileNav = tabBar.viewControllers?.last as? UINavigationController,
           let profileVC = profileNav.viewControllers.first as? ProfileController {
            profileVC.nameLabel.text = username
        }
        navigationController?.setViewControllers([tabBar], animated: true)
    }
    
    }

