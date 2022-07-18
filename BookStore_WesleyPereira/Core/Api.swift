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
    var method: HTTPMethod {get}
    var queryItems: [String: String] { get }
    var headers: [String: String] { get }
    var url: String { get }
    var baseUrl: String { get }
    var path: String { get }
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

protocol Networking {
    associatedtype Entity
    
    func request<Entity: Decodable>(
        _ request: ApiRequest,
        urlSession: URLSession,
        completion: @escaping (Result<Entity, Error>) -> Void)
}

final class Api<Entity: Decodable> {
    func request(
        _ request: ApiRequest,
        urlSession: URLSession = .shared,
        completion: @escaping (Result<Entity, Error>) -> Void) {

        guard var urlComponent = URLComponents(string: request.url) else { return }
        let queryItems = request.queryItems.map { URLQueryItem(name: $0, value: $1) }
        urlComponent.queryItems = queryItems
        
            guard let url = urlComponent.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            guard let data = data else { return completion(.failure(NSError())) }
            
            do {
                let response = try JSONDecoder().decode(Entity.self, from: data)
                completion(.success(response))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }.resume()
    }
}
