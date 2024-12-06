//
//  Sheet.swift
//  BankingAppKenan
//
//  Created by Kenan on 30.11.24.
//

import UIKit

class CardSelectionSheetController: UIViewController {
    
    private var cards: [CardModel]
    private var sheetTitle: String
    var onCardSelected: ((CardModel) -> Void)?
    
    init(cards: [CardModel], title: String) {
        self.cards = cards
        self.sheetTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = sheetTitle
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.reloadData()

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
}

extension CardSelectionSheetController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let card = cards[indexPath.row]
        cell.textLabel?.text = "\(card.cardNumber)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCard = cards[indexPath.row]
        let selectPan = selectedCard.cardNumber
        onCardSelected?(selectedCard)
        dismiss(animated: true, completion: nil)
    }
}
