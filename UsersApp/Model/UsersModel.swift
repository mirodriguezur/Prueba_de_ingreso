//
//  UsersModel.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

public struct Users: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let email: String
    public let phone: String
    
    public init(id: Int, name: String, email: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
}
