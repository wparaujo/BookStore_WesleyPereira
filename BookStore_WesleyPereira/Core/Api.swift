//
//  Api.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 15/07/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol ApiRequest {
    associatedtype Response
    
    var method: HTTPMethod {get}
    var queryItems: [String: String] { get }
    var headers: [String: String] { get }
    var url: String { get }
    var baseUrl: String { get }
    var path: String { get }
    
    func decode(_ data: Data) throws -> Response
}

extension ApiRequest {
    var baseUrl: String {
        "https://www.googleapis.com/"
    }
    
    var url: String {
        baseUrl + path
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var queryItems: [String: String] {
        [:]
    }
}

extension ApiRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

protocol ApiServicing {
    func request<Request: ApiRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

final class Api: ApiServicing {
    func request<Request: ApiRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else { return }
        let queryItems = request.queryItems.map { URLQueryItem(name: $0, value: $1) }
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            guard let data = data else { return completion(.failure(NSError())) }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }.resume()
    }
}
