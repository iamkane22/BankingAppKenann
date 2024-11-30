//
//  TransferController.swift
//  BankingAppKenan
//
//  Created by Kenan on 21.11.24.
//

import UIKit

class TransferController: UIViewController {
    
    private var cards: [HomeViewModel.CardModel] = []
    private var selectedFromCard: HomeViewModel.CardModel?
    private var selectedToCard: HomeViewModel.CardModel?
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var selectFrom: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select from"
        textField.borderStyle = .roundedRect
        textField.inputView = pickerView
        textField.tag = 0
        return textField
    }()
    
    lazy var selectTo: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select to"
        textField.borderStyle = .roundedRect
        textField.inputView = pickerView
        textField.tag = 1
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
        button.addTarget(self, action: #selector(transfer), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
    }
    
    func configure(with cards: [HomeViewModel.CardModel]) {
        self.cards = cards
    }
    
    @objc func transfer() {
        guard let fromCard = selectedFromCard, let toCard = selectedToCard, let amountText = amount.text, let transferAmount = Double(amountText) else {
            showAlert(message: "Please fill in all fields correctly.")
            return
        }
        
        if fromCard.cartBalance >= transferAmount {
            fromCard.cartBalance -= transferAmount
            toCard.cartBalance += transferAmount
            navigationController?.popViewController(animated: true)
            showAlert(title: "Succes", message: "Transfer is successful.")

        } else {
            showAlert(message: "Insufficient funds.")
        }
    }
    
    private func setupConstrain() {
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
            transferButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

extension TransferController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cards.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let card = cards[row]
        return card.cardNumberFormatted
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCard = cards[row]
        if selectFrom.isFirstResponder {
            selectedFromCard = selectedCard
            selectFrom.text = selectedCard.cardNumberFormatted
        } else if selectTo.isFirstResponder {
            selectedToCard = selectedCard
            selectTo.text = selectedCard.cardNumberFormatted
        }
    }
}
