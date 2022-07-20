//
//  BookStoreRequest.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 17/07/22.
//

import Foundation

struct BookStoreRequest: ApiRequest {
    private let pageIndex: Int
    
    init(pageIndex: Int = 0) {
        self.pageIndex = pageIndex
    }
    
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
            "startIndex": "\(pageIndex)"
        ]
    }
}
