import UIKit

class TransferController: UIViewController {
    private let viewModel = TransferViewModel()
    
    lazy var selectFrom: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select from"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(presentFromCardSheet), for: .editingDidBegin)
        return textField
    }()
    
    lazy var selectTo: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select to"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(presentToCardSheet), for: .editingDidBegin)
        return textField
    }()
    
    lazy var amount: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    lazy var transferButton: UIButton = {
        let button = UIButton()
        button.setTitle("Transfer", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(transfer), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    @objc private func presentFromCardSheet() {
        presentCardSheet(title: "Select From Card") { [weak self] selectedCard in
            self?.viewModel.selectedFromCard = selectedCard
            self?.selectFrom.text = selectedCard.cardNumber
        }
    }
    
    @objc private func presentToCardSheet() {
        presentCardSheet(title: "Select To Card") { [weak self] selectedCard in
            self?.viewModel.selectedToCard = selectedCard
            self?.selectTo.text = selectedCard.cardNumber
        }
    }
    
    private func presentCardSheet(title: String, completion: @escaping (CardModel) -> Void) {
        if viewModel.cards.isEmpty {
            let alert = UIAlertController(title: "No Cards Found", message: "Please add cards to your account before transferring.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let sheetController = CardSelectionSheetController(cards: viewModel.cards, title: title)
        sheetController.onCardSelected = completion
        
        if let sheetPresentation = sheetController.sheetPresentationController {
            sheetPresentation.detents = [.medium(), .large()]
            sheetPresentation.prefersGrabberVisible = true
        }
        
        present(sheetController, animated: true)
    }
    
    @objc private func transfer() {
        let validation = viewModel.validateTransfer(amountText: amount.text)
        
        guard validation.isValid else {
            showAlert(title: "Error", message: validation.errorMessage ?? "Unknown error")
            return
        }
        
        if viewModel.performTransfer(amountText: amount.text) {
            let alert = UIAlertController(title: "Success", message: "Transfer Completed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
        } else {
            showAlert(title: "Error", message: "Transfer failed. Please try again.")
        }
    }
    
    private func setupConstraints() {
        view.addSubview(selectFrom)
        view.addSubview(selectTo)
        view.addSubview(amount)
        view.addSubview(transferButton)
        
        selectFrom.translatesAutoresizingMaskIntoConstraints = false
        selectTo.translatesAutoresizingMaskIntoConstraints = false
        amount.translatesAutoresizingMaskIntoConstraints = false
        transferButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectFrom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            selectFrom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            selectFrom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            selectFrom.heightAnchor.constraint(equalToConstant: 48),
            
            selectTo.topAnchor.constraint(equalTo: selectFrom.bottomAnchor, constant: 48),
            selectTo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            selectTo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            selectTo.heightAnchor.constraint(equalToConstant: 48),
            
            amount.topAnchor.constraint(equalTo: selectTo.bottomAnchor, constant: 48),
            amount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            amount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            amount.heightAnchor.constraint(equalToConstant: 48),
            
            transferButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            transferButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            transferButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            transferButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}


