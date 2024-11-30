import UIKit
import RealmSwift

class LoginController: UIViewController {
    
    lazy var loginButton: ReusableButton = {
        ReusableButton(title: "Login", color: .blue, onaction: {[weak self] in self?.loginTapped()})
    }()
     
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? Sign up"
        label.textColor = .blue
        label.isUserInteractionEnabled = true
        return label
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
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFields()
        setupLoginUI()
        setupGesture()
    }
    
    private func setupFields() {
        paswordtextField.delegate = self
        nametextField.delegate = self
    }
    
    private func setupLoginUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(loginButton)
        view.addSubview(signupLabel)
        
        stackView.addArrangedSubview(nametextField)
        stackView.addArrangedSubview(paswordtextField)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nametextField.heightAnchor.constraint(equalToConstant: 50),
            paswordtextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signupLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            signupLabel.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            
        ])
    }
    
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SignGestureAction))
        signupLabel.addGestureRecognizer(gesture)
    }
    
    @objc func loginTapped() {
        guard let username = nametextField.text,
                let password = paswordtextField.text,
                !username.isEmpty,
                !password.isEmpty else {
              showAlert(title: "Error", message: "Please fill in all fields.")
              return
          }
        do {
                let realm = try Realm()
            if realm.objects(User.self).filter("name == %@ AND password == %@", username, password).first != nil {
               let tabBar = Tabbar()
                
                if let profileNav = tabBar.viewControllers?.last as? UINavigationController,
                   let profileVC = profileNav.viewControllers.first as? ProfileController {
                    profileVC.username = username
                }
                
                navigationController?.setViewControllers([tabBar], animated: true)
                } else {
                    showAlert(title: "Error", message: "Invalid username or password.")
                }
            } catch {
                print("Realm error: \(error.localizedDescription)")
                showAlert(title: "Error", message: "Something went wrong. Please try again.")
            }
        
    }
     

    
    
    
    @objc func SignGestureAction() {
        let vc = SignUpController()
        vc.callback = { [weak self] name, password in
            self?.nametextField.text = name
            self?.paswordtextField.text = "\(password)"
            print("User registered with name: \(name) and password: \(password)")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginController: UITextFieldDelegate {
}

