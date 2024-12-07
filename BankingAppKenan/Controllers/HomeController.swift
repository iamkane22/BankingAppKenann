import UIKit
import RealmSwift

class HomeController: UIViewController {

    private let viewModel = HomeViewModel()
    private var cards: [CardModell] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .gray
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        return pageControl
    }()
    

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(addRandomCard), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = .green
        button.tintColor = .white
        return button
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemRed
        button.tintColor = .white
        return button
    }()

    private lazy var transferButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right.arrow.left"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(transferButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.backgroundColor = .blue
        button.tintColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        loadCardsFromRealm()
        collectionView.isScrollEnabled = true
        view.backgroundColor = .black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCardsFromRealm()
        collectionView.reloadData()
    }

    @objc private func loadCardsFromRealm() {
        viewModel.loadCardsFromRealm()
        cards = viewModel.cards
        pageControl.numberOfPages = cards.count
    }

    @objc private func addRandomCard() {
        viewModel.addRandomCard()
        loadCardsFromRealm()
        collectionView.reloadData()
    }

    @objc private func deleteButtonTapped() {
        guard viewModel.deleteLastCard() else {
            showAlert(message: "No cards available to delete")
            return
        }
        loadCardsFromRealm()
        collectionView.reloadData()
    }

    @objc private func transferButtonTapped() {
        guard cards.count >= 2 else {
            showAlert(message: "Please add more cards to transfer funds")
            return
        }
        let transferController = TransferController()
        navigationController?.pushViewController(transferController, animated: true)
    }

    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        view.addSubview(transferButton)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        transferButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 250),

            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),

            deleteButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -16),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.widthAnchor.constraint(equalToConstant: 50),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),

            transferButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transferButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            transferButton.widthAnchor.constraint(equalToConstant: 50),
            transferButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

   
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.configure(model: cards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width > 0 else { return }
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}

