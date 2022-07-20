//
//  BookStoreService.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 17/07/22.
//

import Foundation
import UIKit

protocol BookStoreServicing {
    func fetchBooks(pageIndex: Int, completion: @escaping (Result<BookStoreModel, Error>) -> Void)
}

class BookStoreService: BookStoreServicing {
    func fetchBooks(pageIndex: Int, completion: @escaping (Result<BookStoreModel, Error>) -> Void) {
        Api<BookStoreModel>().request(BookStoreRequest(pageIndex: pageIndex)) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
