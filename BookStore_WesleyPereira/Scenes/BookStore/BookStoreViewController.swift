//
//  BookStoreViewController.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 13/07/22.
//

import UIKit

protocol BookStoreViewControllerDelegate: AnyObject {
    func didLoadItems(_ items: [Item])
}

class BookStoreViewController: UIViewController {
    let viewModel: BookStoreViewModelProtocol
    
    weak var delegate: BookStoreViewControllerDelegate?
    private let bookStoreView = BookStoreView()
    
    override func loadView() {
        delegate = bookStoreView
        view = bookStoreView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchBookStore()
        viewModel.bookStore.bind({ [weak self] books in
            self?.delegate?.didLoadItems(books)
            print(books)
        })
        
    }
    
    init(viewModel: BookStoreViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
