//
//  BookStoreFactory.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 14/07/22.
//

import Foundation
import UIKit

final class BookStoreFactory {
    static func make() -> UIViewController {
        let service = BookStoreService()
        let viewModel = BookStoreViewModel(apiService: service)
        let viewController = BookStoreViewController(
            viewModel: viewModel
        )
        
        return viewController
    }
}
