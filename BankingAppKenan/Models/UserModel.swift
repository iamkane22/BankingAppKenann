//
//  Model.swift
//  BankingAppKenan
//
//  Created by Kenan on 17.11.24.
//
import RealmSwift
import Foundation

class User: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var password: String
    @Persisted var fin: String
}
