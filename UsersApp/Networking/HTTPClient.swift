//
//  HTTPClient.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
