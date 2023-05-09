//
//  PostsTableCellViewModel.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 8/05/23.
//

import Foundation

class PostsTableCellViewModel {
    var title: String
    var body: String
    
    public init(post: Posts) {
        self.title = post.title
        self.body = post.body
    }
}
