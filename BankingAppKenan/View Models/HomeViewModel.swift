import Foundation
import RealmSwift


enum CardType: String {
    case visa = "Visa"
    case paypal = "PayPal"
}
class HomeViewModel {
    
    class CardModell {
        let cardNumber: String
        let cardExpirationDate: String
        let cardCVC: String
        var cartBalancee: Double
        let cartlogoimagename: String
        let cartType: CardType
        let cart16number: String
        let cartback: String
        
        init(cardNumber: String, cardExpirationDate: String, cardCVC: String, cartBalancee: Double, cartlogoimagename: String , cartback: String, cart16number: String, cartType: CardType) {
            self.cardNumber = cardNumber
            self.cardExpirationDate = cardExpirationDate
            self.cardCVC = cardCVC
            self.cartBalancee = cartBalancee
            self.cartlogoimagename = cartlogoimagename
            self.cartType = cartType
            self.cart16number = cart16number
            self.cartback = cartback
        }
    
        var cardNumberFormatted: String {
            return "**** \(cardNumber.suffix(4))"
        }
        
        var cartBalanceFormatted: String {
            return String(format: "₼ %.2f", cartBalancee)
        }
    }
    
    var cards: [CardModell] = []
    private let realm = try! Realm()
    
    func loadCardsFromRealm() {
        let realmCards = realm.objects(CardModel.self)
        cards = realmCards.map { card in
            CardModell(
                cardNumber: card.cardNumber,
                cardExpirationDate: card.cardExpirationDate,
                cardCVC: card.cardCVC,
                cartBalancee: card.cardBalance,
                cartlogoimagename: "",
                cartback: "",
                cart16number: "",
                cartType: .visa
            )
        }
    }
    
    func addRandomCard() {
        let randomCard = CardModell(
            cardNumber: String(Int.random(in: 10000000...99999999)),
            cardExpirationDate: "\(Int.random(in: 1...12))/\(Int.random(in: 23...30))",
            cardCVC: String(Int.random(in: 100...999)),
            cartBalancee: Double.random(in: 0.1...10000),
            cartlogoimagename: "",
            cartback: "",
            cart16number: String(Int.random(in: 0...999999999999999)),
            cartType: Bool.random() ? .visa : .paypal
        )
        cards.append(randomCard)
        
        let newCard = CardModel()
        newCard.cardNumber = randomCard.cardNumber
        newCard.cardExpirationDate = randomCard.cardExpirationDate
        newCard.cardCVC = randomCard.cardCVC
        newCard.cardBalance = randomCard.cartBalancee
        
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

