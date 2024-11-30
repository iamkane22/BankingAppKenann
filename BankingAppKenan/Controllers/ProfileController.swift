//
//  ProfileController.swift
//  BankingAppKenan
//
//  Created by Kenan on 21.11.24.
//

import UIKit

class ProfileController: UIViewController {

    var username: String?
    
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
        label.text = "Your Name"
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
        constraints()
    }
    
    @objc func logout() {
        let login = LoginController()
        navigationController?.popToViewController(login, animated: true)
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
        
        nameLabel.text = username ?? "Your Name"

        NSLayoutConstraint.activate([
            profilelabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profilelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: profilelabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo:profilelabel.trailingAnchor, constant: 16),
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
