//
//  HomeViewModel.swift
//  BankingAppKenan
//
//  Created by Kenan on 21.11.24.
//

import Foundation

enum CardType: String {
    case visa = "Visa"
    case paypal = "PayPal"
}

class HomeViewModel {
    
    class CardModel {
        let cardNumber: String
        let cardExpirationDate: String
        let cardCVC: String
        var cartBalance : Double
        let cartlogoimagename: String
        let cartType: CardType
        let cart16number:String
        let cartback: String
        
        init(cardNumber: String, cardExpirationDate: String, cardCVC: String, cartBalance: Double, cartlogoimagename: String , cartback: String, cart16number:String, cartType: CardType) {
            self.cardNumber = cardNumber
            self.cardExpirationDate = cardExpirationDate
            self.cardCVC = cardCVC
            self.cartBalance = cartBalance
            self.cartlogoimagename = cartlogoimagename
            self.cartType = cartType
            self.cart16number = cart16number
            self.cartback = cartback
        }
    
        var cardNumberFormatted: String {
            return "**** \(cardNumber.suffix(4))"
        }
        
        var cartBalanceFormatted: String {
            return String(format: "₼ %.2f", cartBalance)
        }
    }
}
