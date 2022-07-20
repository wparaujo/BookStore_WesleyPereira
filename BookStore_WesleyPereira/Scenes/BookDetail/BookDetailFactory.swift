//
//  BookDetailFactory.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 19/07/22.
//

import Foundation

enum BookDetailFactory {
    static func make(withItem item: Item) -> BookDetailViewController {
        let persistence = FavoritePersistence()
        let viewModel = BookDetailViewModel(persistence: persistence)
        let viewController = BookDetailViewController(
            item: item,
            viewModel: viewModel
        )
        return viewController
    }
}
