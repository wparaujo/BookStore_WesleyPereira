//
//  BookStoreViewModelTests.swift
//  BookStore_WesleyPereiraTests
//
//  Created by Wesley Araujo on 17/07/22.
//

import XCTest
@testable import BookStore_WesleyPereira

//class BookStoreApiServiceMock: BookStoreServicing {
//    var result: Result<BookStoreModel, Error>?
//    var success = false
//
//    func fetchBooks(completion: @escaping (Result<BookStoreModel, Error>) -> Void) {
//        success = true
////        guard let result = result else { return }
////        completion(result)
//    }
//}

//class BookStoreViewModelTests: XCTestCase throws {
//    
//    guard let jsonData = """
// {
//      "kind": "books#volume",
//      "id": "x6qjAwAAQBAJ",
//      "etag": "tpTlPVzCjFk",
//      "selfLink": "https://www.googleapis.com/books/v1/volumes/x6qjAwAAQBAJ",
//      "volumeInfo": {
//        "title": "Aprendendo Programação iOS",
//        "subtitle": "Do Xcode à App Store",
//        "authors": [
//          "Alasdair Allan"
//        ],
//        "publisher": "Novatec Editora",
//        "publishedDate": "2013-07-01",
//        "description": "Tenha acesso a uma rápida introdução à programação para iPhone, iPad e iPod touch. Com este guia fácil de acompanhar, você aprenderá a desenvolver seu primeiro aplicativo iOS comercializável, da abertura do Xcode ao envio de seu produto para a App Store. Quer você seja um desenvolvedor iniciante em programação para Mac ou um desenvolvedor experiente no Mac, pronto para trabalhar com o iOS, este é o seu livro. Você aprenderá na prática a utilizar a Objective-C e seus principais frameworks, escrevendo vários aplicativos iOS de exemplo, dando a você as habilidades básicas para a construção de seus próprios aplicativos de forma independente. Recheado de exemplos de código, este livro foi reformulado e atualizado para o iOS 6 e o Xcode 4. - Descubra as vantagens da construção de aplicativos iOS nativos. - Dê seus primeiros passos com a Objective-C e os frameworks Cocoa Touch. - Aprofunde-se nas classes de visão de tabela para construção de interfaces de usuário. - Manipule a entrada de dados, processe documentos XML e JSON e armazene dados no SQLite. - Utilize sensores iOS, incluindo o acelerômetro, o magnetômetro, a câmera e o GPS. - Construa aplicativos que utilizam os frameworks Core Location e MapKit. - Integre o serviço iCloud da Apple em seus aplicativos. - Percorra o processo de distribuição de seu aplicativo na App Store. \"O livro Aprendendo programação iOS aborda tudo que um programador iOS aspirante necessita saber para dar seus primeiros passos nessa plataforma. Um livro completo e de leitura muito agradável. Recomendado!\" — Fraser Speirs, Diretor da Connected Flow, Ltd. e criador do FlickrExport",
//        "industryIdentifiers": [
//          {
//            "type": "ISBN_13",
//            "identifier": "9788575223635"
//          },
//          {
//            "type": "ISBN_10",
//            "identifier": "8575223631"
//          }
//        ],
//        "readingModes": {
//          "text": false,
//          "image": true
//        },
//        "pageCount": 448,
//        "printType": "BOOK",
//        "categories": [
//          "Computers"
//        ],
//        "maturityRating": "NOT_MATURE",
//        "allowAnonLogging": false,
//        "contentVersion": "preview-1.0.0",
//        "panelizationSummary": {
//          "containsEpubBubbles": false,
//          "containsImageBubbles": false
//        },
//        "imageLinks": {
//          "smallThumbnail": "http://books.google.com/books/content?id=x6qjAwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
//          "thumbnail": "http://books.google.com/books/content?id=x6qjAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
//        },
//        "language": "pt-BR",
//        "previewLink": "http://books.google.com.br/books?id=x6qjAwAAQBAJ&printsec=frontcover&dq=ios&hl=&cd=1&source=gbs_api",
//        "infoLink": "http://books.google.com.br/books?id=x6qjAwAAQBAJ&dq=ios&hl=&source=gbs_api",
//        "canonicalVolumeLink": "https://books.google.com/books/about/Aprendendo_Programa%C3%A7%C3%A3o_iOS.html?hl=&id=x6qjAwAAQBAJ"
//      },
//      "saleInfo": {
//        "country": "BR",
//        "saleability": "NOT_FOR_SALE",
//        "isEbook": false
//      },
//      "accessInfo": {
//        "country": "BR",
//        "viewability": "PARTIAL",
//        "embeddable": true,
//        "publicDomain": false,
//        "textToSpeechPermission": "ALLOWED",
//        "epub": {
//          "isAvailable": false
//        },
//        "pdf": {
//          "isAvailable": false
//        },
//        "webReaderLink": "http://play.google.com/books/reader?id=x6qjAwAAQBAJ&hl=&printsec=frontcover&source=gbs_api",
//        "accessViewStatus": "SAMPLE",
//        "quoteSharingAllowed": false
//      },
//      "searchInfo": {
//        "textSnippet": "- Percorra o processo de distribuição de seu aplicativo na App Store. &quot;O livro Aprendendo programação iOS aborda tudo que um programador iOS aspirante necessita saber para dar seus primeiros passos nessa plataforma."
//      }
//    }
//""".data(using: .utf8) else { return }
//        
////    let stub = BookStoreModel(kind: "12345", totalItems: 400, items: nil)
//    let url = try XCTUnwrap(URL(string: "https://example.com"))
//    let stub = try JSONDecoder().decode(BookStoreModel.self, from: jsonData)
//    let stubData = try XCTUnwrap(JSONEncoder().encode(stub))
//    let (sut, _) = try makeSUT(url: url, data: stubData)
//
//    sut.fetchBookStore(pageIndex: 0)
//    
//    XCTAssertEqual(sut.bookStore.value.kind, stub.kind)
//    XCTAssertNil(sut.error.value)
//    }
//    
//    func test_error() {
////        let (sut, serviceSpy) = makeSUT()
////        let error = NSError(domain: "", code: 404, userInfo: [:])
////        let resultError: Result<BookStoreModel, Error> = .failure(error)
////        serviceSpy.result = resultError
////
////        sut.fetchBookStore(pageIndex: 0)
////        
////        XCTAssertTrue(error.isEqual(sut.error.value))
////        XCTAssertTrue(sut.bookStore.value.isEmpty)
//    }
//
////    private func makeSUT() -> (sut: BookStoreViewModel, serviceSpy: BookStoreApiServiceMock) {
////        let serviceSpy = BookStoreApiServiceMock()
////        let sut = BookStoreViewModel(apiService: serviceSpy)
////
////        return (sut: sut, serviceSpy: serviceSpy)
//    }
//    
//    private func makeSUT(
//        url: URL?,
//        data: Data? = nil,
//        error: Error? = nil
//    ) throws -> (sut: BookStoreViewModel, serviceSpy: BookStoreApiServiceMock) {
//        let sessionMock = try XCTUnwrap(makeSessionMock(url: url, data: data))
//        let serviceSpy = BookStoreApiServiceMock()
//        
//        let sut = BookStoreViewModel(apiService: serviceSpy, session: sessionMock)
//        
//        return (sut: sut, serviceSpy: serviceSpy)
//    }
//    
//    private func makeSessionMock(
//        url: URL?,
//        data: Data? = nil,
//        error: Error? = nil
//    ) throws -> URLSession {
//        if let stubData = data {
//            URLProtocolMock.testURLs = [url: stubData]
//        }
//        if let error = error {
//            URLProtocolMock.testErrorURLs = [url: error]
//        }
//        
//        let config = URLSessionConfiguration.ephemeral
//        config.protocolClasses = [URLProtocolMock.self]
//        let session = URLSession(configuration: config)
//        
//        return session
//    }
//}
