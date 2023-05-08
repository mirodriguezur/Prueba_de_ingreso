//
//  RemoteUsersLoader.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

public final class RemoteUsersLoader {
    private let client: HTTPClient
    private let url: URL
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([Users])
        case failure(Error)
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                if response.statusCode == 200, let users = try? JSONDecoder().decode([Users].self, from: data) {
                    completion(.success(users))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

