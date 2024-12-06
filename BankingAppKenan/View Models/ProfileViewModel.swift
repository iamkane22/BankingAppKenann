//
//  ProfileViewModel.swift
//  BankingAppKenan
//
//  Created by Kenan on 06.12.24.
//
import Foundation

class ProfileViewModel {
    private(set) var username: String
    
    init(username: String) {
        self.username = username
    }
    
    func getDisplayName() -> String {
        return username.isEmpty ? "Your Name" : username
    }
}

