//
//  FavoritePersistence.swift
//  BookStore_WesleyPereira
//
//  Created by Wesley Araujo on 19/07/22.
//

import Foundation

struct FavoriteBooks: Codable {
    var books: [Item]
}

protocol FavoritePersistenceProtocol {
//    associatedtype T: Codable
    
    func save<T: Codable>(item: T)
    func retrieve<T: Codable>(by index: Int) -> T?
    func retrieveAll<T: Codable>() -> [T]?
}

final class FavoritePersistence: FavoritePersistenceProtocol {
    func save<T: Codable>(item: T) {
        var favoriteItems: [T]?
        // Verificar conteúdo do user defaults, se houver, retornar o array
        if let booksData = UserDefaults.standard.data(forKey: "Books") {
            let decoder = JSONDecoder()
            if let loadedBooks = try? decoder.decode([T].self, from: booksData) {
                favoriteItems = loadedBooks
                print(loadedBooks)
            }
        } else {
            let encoder = JSONEncoder()
            favoriteItems = [item]
//            favoriteItems?.append(item)
            
            if let encoded = try? encoder.encode(favoriteItems) {
                UserDefaults.standard.set(encoded, forKey: "Books")
            }
        }
        
        // adicionar novo item no array
//        guard var favoriteItems = favoriteItems else { return }
        favoriteItems?.append(item)
        
        // salvar user defaults
        UserDefaults.standard.removeObject(forKey: "Books")
        
        let encoder = JSONEncoder()
        guard let favoriteItems = favoriteItems else {
            return
        }

        if let encoded = try? encoder.encode(favoriteItems) {
            UserDefaults.standard.set(encoded, forKey: "Books")
        }
    }
    
    func retrieve<T: Codable>(by index: Int) -> T? {
        var favoriteItems: [T]?
        
        // Verificar conteudo do user defaults
        if let booksData = UserDefaults.standard.data(forKey: "Books") {
            let decoder = JSONDecoder()
            if let loadedBooks = try? decoder.decode([T].self, from: booksData) {
                favoriteItems = loadedBooks
                print(loadedBooks)
            }
        }
        
        // retornar array
//        guard let item = favoriteItems?[index] else { return }
        
        // pegar objeto pelo index
        return favoriteItems?[index]
    }
    
    func retrieveAll<T: Codable>() -> [T]? {
        // Verificar conteudo do user defaults
        var favoriteItems: [T]?
        
        // Verificar conteudo do user defaults
        if let booksData = UserDefaults.standard.data(forKey: "Books") {
            let decoder = JSONDecoder()
            if let loadedBooks = try? decoder.decode([T].self, from: booksData) {
                favoriteItems = loadedBooks
                print(loadedBooks)
            }
        }
        
        return favoriteItems
    }
}
