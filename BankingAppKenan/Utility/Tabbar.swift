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
let StockVC = StocksViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setubTabbar()
    }
    
    private func setubTabbar() {
        HomeVC.title = "Home"
        ProfileVC.title = "Profile"
        StockVC.title = "Stocks"
        HomeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        StockVC.tabBarItem.image = UIImage(named: "Chard")
        ProfileVC.tabBarItem.image = UIImage(systemName:  "person.crop.circle.fill")
        let homeNav = UINavigationController(rootViewController: HomeVC)
        let profileNav = UINavigationController(rootViewController: ProfileVC)
        let stock = UINavigationController(rootViewController: StockVC)
        self.viewControllers = ([homeNav, profileNav, stock])
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .white
        tabBar.barStyle = .black
        
    }
}
