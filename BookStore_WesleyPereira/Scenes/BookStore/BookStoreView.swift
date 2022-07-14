//
//  BookStoreView.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 13/07/22.
//

import UIKit

final class BookStoreView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookStoreView: CodableView {
    func setupViewHierarchy() {
        // implement later
    }
    
    func setupConstraints() {
        // implement later
    }
    
    func setupAdditionalConfigurations() {
        // implement later
    }
}
