//
//  BookStoreRequest.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 17/07/22.
//

import Foundation

enum BookStoreRequest: ApiRequest {
    typealias Response = BookStoreModel
    
    var method: HTTPMethod {
        .get
    }
    
    var path: String {
        "books/v1/volumes"
    }
    
    var queryItems: [String : String] {
        [
            "q": "ios",
            "maxResults": "20",
            "startIndex": "0"
        ]
    }
}
