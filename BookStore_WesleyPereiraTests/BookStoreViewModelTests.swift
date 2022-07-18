//
//  BookStoreViewModelTests.swift
//  BookStore_WesleyPereiraTests
//
//  Created by Wesley Araujo on 17/07/22.
//

import XCTest
@testable import BookStore_WesleyPereira

class BookStoreApiServiceMock: BookStoreServicing {
    var result: Result<BookStoreModel, Error>?
    
    func fetchBooks(completion: @escaping (Result<BookStoreModel, Error>) -> Void) {
        guard let result = result else { return }
        completion(result)
    }
}

class BookStoreViewModelTests: XCTestCase {
    
    func test_sucess() {
        let (sut, serviceSpy) = makeSUT()
        let bookStoreStub = BookStoreModel(kind: "12345", totalItems: 400, items: [])
        let resultSuccess: Result<BookStoreModel, Error> = .success(bookStoreStub)
        serviceSpy.result = resultSuccess

        sut.fetchBookStore()
        
        XCTAssertEqual(sut.bookStore.value, bookStoreStub.items)
        XCTAssertNil(sut.error.value)
    }
    
    func test_error() {
        let (sut, serviceSpy) = makeSUT()
        let error = NSError(domain: "", code: 404, userInfo: [:])
        let resultError: Result<BookStoreModel, Error> = .failure(error)
        serviceSpy.result = resultError

        sut.fetchBookStore()
        
        XCTAssertTrue(error.isEqual(sut.error.value))
        XCTAssertTrue(sut.bookStore.value.isEmpty)
    }

    private func makeSUT() -> (sut: BookStoreViewModel, serviceSpy: BookStoreApiServiceMock) {
        let serviceSpy = BookStoreApiServiceMock()
        let sut = BookStoreViewModel(apiService: serviceSpy)

        return (sut: sut, serviceSpy: serviceSpy)
    }
}
