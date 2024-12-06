//
//  CartCell.swift
//  BankingAppKenan
//
//  Created by Kenan on 21.11.24.
//

import UIKit

class CartCell: UICollectionViewCell {
    lazy var  identifier = "CardCell"
    lazy var cardNumberLabel = UILabel()
    lazy var expirationDateLabel = UILabel()
    lazy var  balanceLabel = UILabel()
    lazy var logoImageView = UIImageView()
    lazy var sixteennumbersLabel = UILabel()
    lazy var cartback = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemBlue
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        cardNumberLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cardNumberLabel.textColor = .white
        
        expirationDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        expirationDateLabel.textColor = .white
        
        balanceLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        balanceLabel.textColor = .white
        
        logoImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(cardNumberLabel)
        contentView.addSubview(expirationDateLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(logoImageView)
        contentView.addSubview(sixteennumbersLabel)
        contentView.addSubview(cartback)
        contentView.sendSubviewToBack(cartback)
    }
    
    private func setupConstraints() {
        cardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        expirationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        sixteennumbersLabel.translatesAutoresizingMaskIntoConstraints = false
        cartback.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sixteennumbersLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sixteennumbersLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            logoImageView.widthAnchor.constraint(equalToConstant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            cardNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cardNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            expirationDateLabel.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 10),
            expirationDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            balanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            balanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cartback.topAnchor.constraint(equalTo: contentView.topAnchor),
            cartback.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cartback.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cartback.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func configure(model: HomeViewModel.CardModell) {
        cardNumberLabel.text = model.cardNumber
        expirationDateLabel.text = "Exp: \(model.cardExpirationDate)"
        balanceLabel.text = model.cartBalanceFormatted
        logoImageView.image = UIImage(named: model.cartlogoimagename)
        cartback.image = UIImage(named: "Cartimage")
    }
}
