//
//  FavoriteBookFactory.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 19/07/22.
//

import Foundation

enum FavoriteBookFactory {
    static func make() -> FavoriteBookViewController {
        let persistence = FavoritePersistence()
        let viewModel = FavoriteBookViewModel(persistence: persistence)
        let viewController = FavoriteBookViewController(viewModel: viewModel)
        
        return viewController
    }
}
