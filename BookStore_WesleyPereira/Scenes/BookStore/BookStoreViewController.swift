//
//  BookStoreViewController.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 13/07/22.
//

import UIKit

class BookStoreViewController: UIViewController {
    let viewModel: BookStoreViewModelProtocol
    
    override func loadView() {
        view = BookStoreView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchBookStore()
        viewModel.bookStore.bind({ books in
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
