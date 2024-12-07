import Foundation
import RealmSwift


class HomeViewModel {
    
    var cards: [CardModell] = []
    private let realm = try! Realm()
    
    func loadCardsFromRealm() {
        let realmCards = realm.objects(CardModel.self)
        cards = realmCards.map { card in
            CardModell(
                cardNumber: card.cardNumber,
                cardExpirationDate: card.cardExpirationDate,
                cardCVC: card.cardCVC,
                cartBalance: card.cardBalance,
                cartLogoImageName: "",
                cart16Number: "",
                cartBack: ""
            )
        }
    }
    
    func addRandomCard() {
        let randomCard = CardModell(
            cardNumber: String(Int.random(in: 10000000...99999999)),
            cardExpirationDate: "\(Int.random(in: 1...12))/\(Int.random(in: 23...30))",
            cardCVC: String(Int.random(in: 100...999)),
            cartBalance: Double.random(in: 0.1...10000),
            cartLogoImageName: "",
            cart16Number: "",
            cartBack: String(Int.random(in: 0...999999999999999))
        )
        cards.append(randomCard)
        
        let newCard = CardModel()
        newCard.cardNumber = randomCard.cardNumber
        newCard.cardExpirationDate = randomCard.cardExpirationDate
        newCard.cardCVC = randomCard.cardCVC
        newCard.cardBalance = randomCard.cartBalance
        
        try! realm.write {
            realm.add(newCard)
        }
    }
    
    func deleteLastCard() -> Bool {
        guard !cards.isEmpty else { return false }
        let cardToDelete = cards.removeLast()
        
        if let realmCard = realm.objects(CardModel.self).filter("cardNumber == %@", cardToDelete.cardNumber).first {
            try! realm.write {
                realm.delete(realmCard)
            }
        }
        return true
    }
}

