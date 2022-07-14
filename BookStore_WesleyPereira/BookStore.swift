import Foundation

struct BookStore: Codable {
    let kind: String
    let totalItems: Int
    let items: [Item]
}

struct Item: Codable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
    let accessInfo: AccessInfo
    let searchInfo: SearchInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String
    let authors: [String]
}

struct SaleInfo: Codable {
    let country: String
    let saleability: String
    let isBook: Bool
}

struct AccessInfo: Codable {
    let country, viewability: String
    let embeddable, publicDomain: Bool
    let textToSpeechPermission: String
    let epub, pdf: Epub
    let webReaderLink: String
    let accessViewStatus: String
    let quoteSharingAllowed: Bool
}

struct Epub: Codable {
    let isAvailable: Bool
}

struct SearchInfo: Codable {
    let textSnippet: String
}
