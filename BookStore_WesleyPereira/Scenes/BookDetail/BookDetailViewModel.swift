//
//  BookDetailViewModel.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 19/07/22.
//

import Foundation

protocol BookDetailViewModelProtocol {
    func saveItem(_ item: Item)
}

final class BookDetailViewModel: BookDetailViewModelProtocol {
    private var persistence: FavoritePersistenceProtocol
    
    init(persistence: FavoritePersistenceProtocol) {
        self.persistence = persistence
    }
    
    func saveItem(_ item: Item) {
        persistence.save(item: item)
        guard let booksData = UserDefaults.standard.data(forKey: "Books") else { return }
        guard let algo = try? JSONDecoder().decode([Item].self, from: booksData) else { return }
        print(algo)
    }
}
