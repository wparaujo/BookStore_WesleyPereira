//
//  BookCollectionViewModelTests.swift
//  BookStore_WesleyPereiraTests
//
//  Created by Wesley Araujo on 18/07/22.
//

import XCTest
@testable import BookStore_WesleyPereira

final class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var testErrorURLs = [URL?: Error]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url] {
                client?.urlProtocol(self, didLoad: data)
            } else {
                if let error = URLProtocolMock.testErrorURLs[url] {
                    client?.urlProtocol(self, didFailWithError: error)
                }
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
    }
}

class BookCollectionViewModelTests: XCTestCase {
    func test_requestImage_whenIsSuccesul_shouldGetData() throws {
        let url = try XCTUnwrap(URL(string: "https://success.com"))
        let stub = BookStoreModel(kind: "12345", totalItems: 400, items: [])
        let stubData = try XCTUnwrap(JSONEncoder().encode(stub))
        let sut = try makeSUT(url: url, data: stubData)
        
        sut.fetchImage(from: url) { data, _, _ in
            let expectation = self.expectation(description: "get success")
            XCTAssertEqual(sut.observableSuccess.value, data)
            expectation.fulfill()
        }
    }
    
    func test_requestImage_whenIsFailure_shouldGetError() throws {
        let url = try XCTUnwrap(URL(string: "https://failure.com"))
        let stub = NSError(domain: "", code: 404, userInfo: [:])
        let sut = try makeSUT(url: url, error: stub)

        sut.fetchImage(from: url) { _, _, error in
            let expectation = self.expectation(description: "get error")
            XCTAssertTrue(stub.isEqual(sut.observableError.value))
            expectation.fulfill()
        }
    }
    
    private func makeSUT(
        url: URL?,
        data: Data? = nil,
        error: Error? = nil
    ) throws -> BookCollectionViewModel {
        let sessionMock = try XCTUnwrap(makeSessionMock(url: url, data: data))
        
        let sut = BookCollectionViewModel(session: sessionMock)
        
        return sut
    }
    
    private func makeSessionMock(
        url: URL?,
        data: Data? = nil,
        error: Error? = nil
    ) throws -> URLSession {
        if let stubData = data {
            URLProtocolMock.testURLs = [url: stubData]
        }
        if let error = error {
            URLProtocolMock.testErrorURLs = [url: error]
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        return session
    }
}
