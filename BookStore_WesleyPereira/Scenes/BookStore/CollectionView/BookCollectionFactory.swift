//
//  BookCollectionFactory.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 18/07/22.
//

import Foundation
import UIKit

enum BookCollectionConfigurator {
    static func configure(_ cell: BookCollectionViewCell?, item: Item) {
        let service = BookCollectionService()
        let viewModel = BookCollectionViewModel(service: service)
        cell?.viewModel = viewModel
        guard let url = URL(string: item.volumeInfo.imageLinks.thumbnail) else { return }
        cell?.loadData(from: url)
    }
}
