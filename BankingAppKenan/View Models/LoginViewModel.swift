import Foundation
import RealmSwift

class LoginViewModel {

    var loginResult: ((Result<String, Error>) -> Void)?
    
    func login(username: String, password: String) {
        guard !username.isEmpty else {
            loginResult?(.failure(LoginError.emptyFields))
            return
        }
        
        do {
            let realm = try Realm()
            if realm.objects(User.self).filter("name == %@ AND password == %@", username, password).first != nil {
                loginResult?(.success(username))
            } else {
                loginResult?(.failure(LoginError.invalidCredentials))
            }
        } catch {
            loginResult?(.failure(error))
        }
    }
    
    enum LoginError: LocalizedError {
        case emptyFields
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .emptyFields:
                return "Please fill in all fields."
            case .invalidCredentials:
                return "Invalid username or password."
            }
        }
    }
}
