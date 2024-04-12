//
//  NetworkManager.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 12.04.2024.
//

import Foundation

enum Path {
    case products
    case suggestedProducts
    
    var baseURL: String {
        return "https://65c38b5339055e7482c12050.mockapi.io/api"
    }
    
    var path: URL {
        switch self {
        case .products:
            return URL(string: "\(baseURL)/products")!
        case .suggestedProducts:
            return URL(string: "\(baseURL)/suggestedProducts")!
        }
    }
}

struct Resource<T: Decodable> {
    var url: Path
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: resource.url.path) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NSError(domain: "Decode Error", code: 0)))
            }
        }.resume()
    }
}
