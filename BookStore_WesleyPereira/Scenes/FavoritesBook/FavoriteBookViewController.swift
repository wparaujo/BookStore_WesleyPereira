//
//  FavoriteBookViewController.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 18/07/22.
//

import UIKit

class FavoriteBookViewController: UIViewController {
    private let viewModel: FavoriteBookViewModelProtocol
    private var books: [Item]?
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadBooks()
        viewModel.observableSuccess.bind({ [weak self] books in
            self?.books = books
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
//            print(books)
        })
    }
    
    init(viewModel: FavoriteBookViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteBookViewController: CodableView {
    func setupViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func setupAdditionalConfigurations() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "\(BookCollectionViewCell.self)")
    }
}

extension FavoriteBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let books = books else { return 0 }
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BookCollectionViewCell.self)", for: indexPath) as? BookCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        guard let book = books?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(withItem: book)
        return cell
    }
}

extension FavoriteBookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: size, height: size)
    }
}

extension FavoriteBookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row] else { return }
        navigationController?.pushViewController(BookDetailFactory.make(withItem: book), animated: true)
    }
}
