//
//  BookStoreView.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 13/07/22.
//

import UIKit

protocol BookStoreViewDelegate: AnyObject {
    func didLoadItems(_ items: [Item])
}

final class BookStoreView: UIView {
    weak var delegate: BookStoreViewDelegate?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var books = [Item]()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookStoreView: CodableView {
    func setupViewHierarchy() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func setupAdditionalConfigurations() {
        backgroundColor = .white
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "\(BookCollectionViewCell.self)")
    }
}
extension BookStoreView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BookCollectionViewCell.self)", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

extension BookStoreView: BookStoreViewControllerDelegate {
    func didLoadItems(_ items: [Item]) {
        books = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension BookStoreView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) + (flowlayout?.sectionInset.left ?? 0.0) + (flowlayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}
