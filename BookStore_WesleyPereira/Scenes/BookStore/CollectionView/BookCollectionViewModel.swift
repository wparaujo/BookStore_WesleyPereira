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
    
    func fetchImage(from url: URL)
}

final class BookCollectionViewModel: BookCollectionViewModelProtocol {
    var observableSuccess: Observable<Data?> = Observable(nil)
    var observableError: Observable<Error?> = Observable(nil)
    
    private let service: BookCollectionServicing
    
    init(service: BookCollectionServicing) {
        self.service = service
    }
    
    func fetchImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                self?.observableError.value = NSError(domain: "", code: 404, userInfo: [:])
                return
            }

            if let error = error {
                self?.observableError.value = error
            }
            
            self?.observableSuccess.value = data
//            self?.service.fetchImage(from: url) { [weak self] data, response, error in
                
//            }
        }.resume()
    }
}
