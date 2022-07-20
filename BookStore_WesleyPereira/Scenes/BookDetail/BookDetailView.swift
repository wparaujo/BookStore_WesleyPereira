//
//  BookDetailView.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 19/07/22.
//

import UIKit

protocol BookDetailViewDelegate: AnyObject {
    func didTapSaveFavoriteButton()
}

extension BookDetailView.LayoutSize {
    enum ContentView {
        static let proportionalWidth = 0.9
    }
    
    enum Button {
        static let heightButton: CGFloat = 48
    }
}

final class BookDetailView: UIView {
    fileprivate enum LayoutSize {}
    
    private var item: Item?
    
    weak var delegate: BookDetailViewDelegate?
    
    private lazy var contentStatckView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitle("Buy", for: .normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBuyBook), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favorite", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSaveFavorite), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapBuyBook() {
        guard let buyLink = item?.saleInfo.buyLink,
              let url = URL(string: buyLink) else {
                  return
        }
        UIApplication.shared.open(url)
    }
    
    @objc
    private func didTapSaveFavorite() {
        delegate?.didTapSaveFavoriteButton()
    }
}

extension BookDetailView: CodableView {
    func setupViewHierarchy() {
        addSubview(contentStatckView)
        
        contentStatckView.addArrangedSubview(titleLabel)
        contentStatckView.addArrangedSubview(authorLabel)
        contentStatckView.addArrangedSubview(descriptionLabel)
        contentStatckView.addArrangedSubview(buyButton)
        contentStatckView.addArrangedSubview(favoriteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStatckView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: LayoutSize.ContentView.proportionalWidth),
            contentStatckView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStatckView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buyButton.heightAnchor.constraint(equalToConstant: LayoutSize.Button.heightButton),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: LayoutSize.Button.heightButton)
        ])
    }
    
    func setupAdditionalConfigurations() {
        backgroundColor = .white
    }
}

extension BookDetailView: BookDetailViewControllerDelegate {
    func didReceiveItem(_ item: Item) {
        self.item = item
        titleLabel.text = item.volumeInfo.title
        authorLabel.text = item.volumeInfo.authors.joined(separator: ", ")
        descriptionLabel.attributedText = item.searchInfo?.textSnippet.htmlToAttributedString
        if item.saleInfo.saleability == .forSale {
            buyButton.isHidden = true
        }
    }
}
