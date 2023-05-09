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
    
    public init(url: URL, client: HTTPClient = URLSessionHTTPClient()) {
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
    
    public enum ResultPosts: Equatable {
        case success([Posts])
        case failure(Error)
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else {
                return
                
            }
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
    
    public func loadPosts(userId: Int, completion: @escaping (ResultPosts) -> Void) {
//        let path = "/posts?userId=\(userId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let urlPost = url.appendingPathComponent(path)
//
        
        let path = "/posts"
        let userId = "\(userId)"
        var urlComponents = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [URLQueryItem(name: "Id", value: userId)]
        let urlPost = urlComponents.url!
        
        
        client.get(from: urlPost) { [weak self] result in
            guard self != nil else {
                return
                
            }
            switch result {
            case let .success(data, response):

                if response.statusCode == 200, let posts = try? JSONDecoder().decode([Posts].self, from: data) {
                    completion(.success(posts))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

