//
//  UserTableCellViewModel.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

class UserTableCellViewModel {
    var id: Int
    var name: String
    var phone: String
    var email: String
    
    init(user: Users) {
        self.id = user.id
        self.name = user.name
        self.phone = user.phone
        self.email = user.email
    }
}
