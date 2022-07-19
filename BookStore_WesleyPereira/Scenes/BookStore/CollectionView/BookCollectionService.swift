//
//  BookCollectionService.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 18/07/22.
//

import Foundation

protocol BookCollectionServicing {
    func fetchImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class BookCollectionService: BookCollectionServicing {
    func fetchImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion)
    }
}
