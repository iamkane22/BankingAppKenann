import UIKit

class ProfileController: UIViewController {

    var viewModel: ProfileViewModel? 
    
    lazy var logoutbutton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    
    let profilelabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: .init(30))
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: .init(30))
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackCollactionProfile")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        constraints()
        updateUI()
    }
    
    @objc func logout() {
        // Kullanıcı çıkışı simüle ediyoruz.
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateUI() {
        nameLabel.text = viewModel?.getDisplayName() ?? "Your Name"
    }

    private func constraints() {
        view.addSubview(profilelabel)
        view.addSubview(nameLabel)
        view.addSubview(profileImage)
        view.addSubview(logoutbutton)
        view.sendSubviewToBack(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profilelabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutbutton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profilelabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profilelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: profilelabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profilelabel.trailingAnchor, constant: 16),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            logoutbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            logoutbutton.heightAnchor.constraint(equalToConstant: 34),
            logoutbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            logoutbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
    }
}

