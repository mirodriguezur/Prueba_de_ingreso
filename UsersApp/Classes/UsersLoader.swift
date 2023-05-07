//
//  UsersLoader.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

public enum LoadUsersResult {
    case success([UsersLoader])
    case failure(Error)
}

public protocol UsersLoader {
    func load(completion: @escaping (LoadUsersResult) -> Void)
}
