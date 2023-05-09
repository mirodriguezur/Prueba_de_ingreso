//
//  Publications.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 8/05/23.
//

import Foundation

public struct Posts: Decodable, Equatable {
    public let title: String
    public let body: String
    
    public init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
