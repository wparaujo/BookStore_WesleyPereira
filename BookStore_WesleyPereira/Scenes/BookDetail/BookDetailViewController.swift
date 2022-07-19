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
    
    weak var delegate: BookDetailViewControllerDelegate?
    
    override func loadView() {
        view = bookDetailView
    }
    
    init(item: Item) {
        self.item = item
        delegate = bookDetailView
        delegate?.didReceiveItem(item)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
