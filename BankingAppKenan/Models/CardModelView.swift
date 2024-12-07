//
//  CardModelView.swift
//  BankingAppKenan
//
//  Created by Kenan on 07.12.24.
//


struct CardModell {
    let cardNumber: String
    let cardExpirationDate: String
    let cardCVC: String
    var cartBalance: Double
    let cartLogoImageName: String
    let cart16Number: String
    let cartBack: String
    
   
    
    var cardNumberFormatted: String {
        return "**** \(cardNumber.suffix(4))"
    }
    
    var cartBalanceFormatted: String {
        return String(format: "₼ %.2f", cartBalance)
    }
}
