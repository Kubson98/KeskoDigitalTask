//
//  ServiceManager.swift
//  Services
//
//  Created by Jakub Sędal on 04/04/2024.
//

import Foundation

public enum FetchingType {
    case lists
    case books
    case book(Int)
    
    var url: URL? {
        switch self {
        case .lists:
            return URL(string: "https://my-json-server.typicode.com/KeskoSenukaiDigital/assignment/lists")
        case .books:
            return URL(string: "https://my-json-server.typicode.com/KeskoSenukaiDigital/assignment/books")
        case .book(let bookId):
            return URL(string: "https://my-json-server.typicode.com/KeskoSenukaiDigital/assignment/book/\(bookId)")
        }
    }
}

public protocol ServiceManaging {
    func fetchData<T: Decodable>(for fetchingType: FetchingType, completion: @escaping (Result<[T], APIError>) -> Void)
    func fetchDetails<T: Decodable>(for: Int, completion: @escaping (Result<T, APIError>) -> Void)
}

public class ServiceManager: ServiceManaging {
    public func fetchDetails<T>(for id: Int, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        guard let url = FetchingType.book(id).url else {
            completion(.failure(.networkError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    public func fetchData<T: Decodable>(for fetchingType: FetchingType, completion: @escaping (Result<[T], APIError>) -> Void) {
        guard let url = fetchingType.url else {
            completion(.failure(.networkError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    public init() {}
}
