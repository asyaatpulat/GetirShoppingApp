//
//  MockNetworkManager.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockNetworkManager: NetworkManager {

    enum MockNetworkError: Error {
        case noData
    }

    var result: Result<[MockProductResponse], Error>?

    func fetchData<T: Decodable>(resource: Resource<T>) async throws -> T {
        guard let result = result else {
            throw MockNetworkError.noData
        }

        switch result {
        case .success(let data):
            guard let castedData = data as? T else {
                throw MockNetworkError.noData
            }
            return castedData
        case .failure(let error):
            throw error
        }
    }
}
