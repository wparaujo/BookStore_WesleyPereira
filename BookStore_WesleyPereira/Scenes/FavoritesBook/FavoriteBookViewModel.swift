//
//  FavoriteBookViewModel.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 19/07/22.
//

import Foundation

protocol FavoriteBookViewModelProtocol {
    var observableSuccess: Observable<[Item]?> { get }
//    var observableError: Observable<[Error]> { get }
    
    func loadBooks()
}

final class FavoriteBookViewModel: FavoriteBookViewModelProtocol {
    var observableSuccess: Observable<[Item]?> = Observable(nil)
//    var observableError: Observable<[Error?]>
    
    private let persistence: FavoritePersistenceProtocol
    
    init(persistence: FavoritePersistenceProtocol) {
        self.persistence = persistence
    }
    
    func loadBooks() {
        guard let favoriteBooks: [Item] = persistence.retrieveAll() else {
            return
        }
        
        observableSuccess.value = favoriteBooks
    }
}
