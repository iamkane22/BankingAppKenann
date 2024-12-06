//
//  StartController.swift
//  BankingApp
//
//  Created by Kenan on 09.11.24.
//

import UIKit
import RealmSwift

class StartController: UIViewController {
    
    let HelloLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Hello, Friend!"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        print("Realm is located at:", realm.configuration.fileURL!)
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(HelloLabel)
        
        HelloLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            HelloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HelloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        navigationController?.pushViewController(LoginController(viewmodel: LoginViewModel()), animated: true)
    }
}
