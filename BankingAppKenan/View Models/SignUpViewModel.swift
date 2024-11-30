//
//  AuthViewModel.swift
//  BankingApp
//
//  Created by Kenan on 13.11.24.
//
import Foundation
import RealmSwift
///
final class SignUpViewModel {
    private var userlist: Results<User>?
    
    func fetchdata(user: User) {
        
        do {
            let realm = try Realm()
            try  realm.write {
                realm.add(user)
            }
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getdata() {
        
        do {
            _ = try Realm()
            let list = userlist
            print(list ?? "")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func validateFields(name: String, email: String, password: String, fin: String) -> String? {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || name.replacingOccurrences(of: " ", with: "").count < 6 {
            return "invalid name"
        }
        if !email.isValidEmail(email) && email.isEmpty {
            return "invalid email"
        }
        if password.count < 8 && password.isEmpty {
            return "invalid password"
        }
        if fin.trimmingCharacters(in: .whitespaces).isEmpty || fin.replacingOccurrences(of: " ", with: "").count != 7 {
            return "invalid fin"
        }
        
        return nil
    }
}

