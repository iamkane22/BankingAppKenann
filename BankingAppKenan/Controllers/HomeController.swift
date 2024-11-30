//
//  HomeController.swift
//  BankingAppKenan
//
//  Created by Kenan on 21.11.24.
//

import UIKit

class HomeController: UIViewController {
    
    private var cards: [HomeViewModel.CardModel] = []
    
    lazy var  collectionview: UICollectionView = {
        lazy var collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionview.dataSource = self
        collectionview.backgroundColor = .clear
        
        return collectionview
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = cards.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(addRandomCard), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = .green
        button.tintColor = .white
        
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemRed
        button.tintColor = .white
        
        return button
    }()
    
    lazy var transferButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(transferButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.setImage(UIImage(systemName: "arrow.right.arrow.left"), for: .normal)
        button.clipsToBounds = true
        button.backgroundColor = .blue
        button.tintColor = .white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
        constraint ()
        backimage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionview.reloadData()
    }
    
    private func setupCollectionView() {
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    private func setupLayout() {
        let design = UICollectionViewFlowLayout()
        design.scrollDirection = .horizontal
        design.minimumLineSpacing = 0
        collectionview.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")
        collectionview.collectionViewLayout = design
        collectionview.isPagingEnabled = true
        collectionview.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = cards.count > 0 ? cards.count : 1
    }
    
    private func backimage() {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "BackCollaction")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
    }
    
    @objc private func addRandomCard() {
        let randomCard = HomeViewModel.CardModel(
            cardNumber: String(Int.random(in: 10000000...99999999)),
            cardExpirationDate: "\(Int.random(in: 1...12))/\(Int.random(in: 23...30))",
            cardCVC: String(Int.random(in: 100...999)),
            cartBalance: Double.random(in: 0.1...10000),
            cartlogoimagename: "",
            cartback: "",
            
            cart16number: String(Int.random(in: 0...999999999999999)),
            cartType:  Bool.random() ? .visa : .paypal
        )
        cards.append(randomCard)
        collectionview.reloadData()
        pageControl.numberOfPages = cards.count
    }
    
    @objc private func transferButtonTapped() {
        if cards.count < 2 {
            showAlert(message: "Please add new card")
        } else {
            let transferController = TransferController()
            transferController.configure(with: cards)
            navigationController?.pushViewController(transferController, animated: true)
        }
    }
    
    @objc private func deleteButtonTapped() {
        if !cards.isEmpty {
            cards.removeLast() }
        else {
            showAlert(message: "Kartin yoxdu brat")
        }
        pageControl.numberOfPages = cards.count
        collectionview.reloadData()
    }
    
    private func constraint () {
        view.addSubview(collectionview)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        view.addSubview(pageControl)
        view.addSubview(transferButton)
        
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        transferButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            transferButton.heightAnchor.constraint(equalToConstant: 50),
            transferButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            transferButton.centerXAnchor.constraint(equalTo: collectionview.centerXAnchor),
            transferButton.widthAnchor.constraint(equalToConstant: 50),
            transferButton.heightAnchor.constraint(equalToConstant: 50),
            
            collectionview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionview.heightAnchor.constraint(equalToConstant: 250),
            
            pageControl.topAnchor.constraint(equalTo: collectionview.bottomAnchor, constant: 5),
            pageControl.centerXAnchor.constraint(equalTo: collectionview.centerXAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo:addButton.leadingAnchor, constant: -16),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.widthAnchor.constraint(equalToConstant: 50),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
        let card = cards[indexPath.row]
        cell.configure(model: card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageindex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        guard scrollView.frame.width > 0 else { return }
        guard scrollView.contentSize.width > 0 else { return }
        pageControl.currentPage = pageindex
    }
}

