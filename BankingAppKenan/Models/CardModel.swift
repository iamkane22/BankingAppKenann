import RealmSwift
import Foundation

class CardModel: Object {
    @Persisted var cardNumber: String
    @Persisted var cardName: String = ""
    @Persisted var cardExpirationDate: String
    @Persisted var cardCVC: String
    @Persisted var cardId: String = UUID().uuidString
    @Persisted var cardBalance: Double
}

