//
//  CodableView.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 13/07/22.
//

import Foundation

protocol CodableView {
    func buildLayout()
    func setupViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurations()
}

extension CodableView {
    func buildLayout() {
        setupViewHierarchy()
        setupConstraints()
        setupAdditionalConfigurations()
    }
}
