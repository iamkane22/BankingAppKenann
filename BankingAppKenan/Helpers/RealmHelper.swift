//
//  RealmHelper.swift
//  BankingAppKenan
//
//  Created by Kenan on 30.11.24.
//

import Foundation
import RealmSwift

class RealmHelper
{
     let realm = try! Realm()
    
    func fetchData() -> Results<CardModel> {
        let allCardsList = realm.objects(CardModel.self)
        return allCardsList
    }
    func addObjectToRealm(object: CardModel) {
        try! realm.write({
            realm.add(object)
        })
    }
    func deleteAllCArd() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

