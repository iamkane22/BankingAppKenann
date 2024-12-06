//
//  TransferViewModel.swift
//  BankingAppKenan
//
//  Created by Kenan on 06.12.24.
//

import Foundation
import RealmSwift

class TransferViewModel {
    private let realm = try! Realm()
    private var helper = RealmHelper()
    
    var cards: [CardModel] {
        return Array(realm.objects(CardModel.self))
    }
    
    var selectedFromCard: CardModel?
    var selectedToCard: CardModel?
    
    func validateTransfer(amountText: String?) -> (isValid: Bool, errorMessage: String?) {
        guard let fromCard = selectedFromCard,
              let toCard = selectedToCard,
              let amountText = amountText,
              let amount = Double(amountText) else {
            return (false, "Please fill all fields correctly.")
        }
        
        if fromCard.cardNumber == toCard.cardNumber {
            return (false, "You cannot transfer money to the same card.")
        }
        
        if fromCard.cardBalance < amount {
            return (false, "Insufficient funds.")
        }
        
        return (true, nil)
    }
    
    func performTransfer(amountText: String?) -> Bool {
        guard let amountText = amountText,
              let amount = Double(amountText),
              let fromCard = selectedFromCard,
              let toCard = selectedToCard else { return false }
        
        let realm = helper.realm
        
        try! realm.write {
            fromCard.cardBalance -= amount
            toCard.cardBalance += amount
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("CardsUpdated"), object: nil)
        return true
    }
}
