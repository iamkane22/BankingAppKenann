//
//  Tabbar.swift
//  BankingAppKenan
//
//  Created by Kenan on 16.11.24.
//

import UIKit

class Tabbar: UITabBarController {
    
let HomeVC = HomeController()
let ProfileVC = ProfileController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setubTabbar()
    }
    
    private func setubTabbar() {
        HomeVC.title = "Home"
        ProfileVC.title = "Profile"
        HomeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        ProfileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
        let homeNav = UINavigationController(rootViewController: HomeVC)
        let profileNav = UINavigationController(rootViewController: ProfileVC)
        self.viewControllers = ([homeNav, profileNav])
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .white
        
    }
}
