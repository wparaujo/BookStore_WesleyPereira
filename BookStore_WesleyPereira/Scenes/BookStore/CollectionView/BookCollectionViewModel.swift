//
//  BookCollectionViewModel.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 18/07/22.
//

import Foundation

protocol BookCollectionViewModelProtocol {
    var observableSuccess: Observable<Data?> { get }
    var observableError: Observable<Error?> { get }
    
    func fetchImage(from url: URL, completion: ((Data?, URLResponse?, Error?) -> Void)?)
}

extension BookCollectionViewModelProtocol {
    func fetchImage(from url: URL, completion: ((Data?, URLResponse?, Error?) -> Void)? = nil) {
        fetchImage(from: url, completion: completion)
    }
}

final class BookCollectionViewModel: BookCollectionViewModelProtocol {
    var observableSuccess: Observable<Data?> = Observable(nil)
    var observableError: Observable<Error?> = Observable(nil)
    private let session: URLSession
        
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchImage(from url: URL, completion: ((Data?, URLResponse?, Error?) -> Void)?) {
        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.observableError.value = error
            }
            
            self?.observableSuccess.value = data
            completion?(data, response, error)
        }.resume()
    }
}
