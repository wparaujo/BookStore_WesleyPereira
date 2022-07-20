//
//  BookDetailViewController.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 19/07/22.
//

import UIKit

protocol BookDetailViewControllerDelegate: AnyObject {
    func didReceiveItem(_ item: Item)
}

class BookDetailViewController: UIViewController {
    private let bookDetailView = BookDetailView()
    private let item: Item
    private let viewModel: BookDetailViewModel
    
    weak var delegate: BookDetailViewControllerDelegate?
    
    override func loadView() {
        bookDetailView.delegate = self
        view = bookDetailView
    }
    
    init(item: Item, viewModel: BookDetailViewModel) {
        self.item = item
        delegate = bookDetailView
        delegate?.didReceiveItem(item)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BookDetailViewController: BookDetailViewDelegate {
    func didTapSaveFavoriteButton() {
        viewModel.saveItem(item)
    }
}
