//
//  BookCollectionViewCell.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 17/07/22.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    var viewModel: BookCollectionViewModel?
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    convenience init(viewModel: BookCollectionViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
    }
    
    func loadData(from url: URL) {
        viewModel?.fetchImage(from: url)
        viewModel?.observableSuccess.bind({ [weak self] data in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data)
                self?.setNeedsLayout()
            }
        })
        
        viewModel?.observableError.bind({ error in
            //
        })
    }
    
    func configure(withItem item: Item) {
        BookCollectionConfigurator.configure(
            self,
            item: item
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookCollectionViewCell: CodableView {
    func setupViewHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurations() {
    }
}
