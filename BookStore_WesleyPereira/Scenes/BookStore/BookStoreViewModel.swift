//
//  BookStoreViewModel.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 13/07/22.
//

import Foundation

protocol BookStoreViewModelProtocol {
    func fetchBookStore()
    var bookStore: Observable<[Item]> { get set }
    var error: Observable<Error?> { get set }
}

final class BookStoreViewModel: BookStoreViewModelProtocol {
    var bookStore: Observable<[Item]> = Observable([])
    var error: Observable<Error?> = Observable(nil)
    
    func fetchBookStore() {
        Api().request(BookStoreRequest()) { result in
            switch result {
            case .success(let response):
                self.bookStore.value = response.items
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
