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
    private var apiService: BookStoreServicing

    init(apiService: BookStoreServicing) {
        self.apiService = apiService
    }
    
    func fetchBookStore() {
        apiService.fetchBooks { result in
            switch result {
            case .success(let response):
                self.bookStore.value = response.items
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
