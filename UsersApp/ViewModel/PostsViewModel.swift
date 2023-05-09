//
//  PostsViewModel.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 8/05/23.
//

import Foundation

class PostsViewModel {
    
    var dataSource: [Posts]?
    let remoteUserLoader: RemoteUsersLoader?
    var posts: Observable<[PostsTableCellViewModel]> = Observable(nil)
    
    public init(remoteUserLoader: RemoteUsersLoader = RemoteUsersLoader(url: URL(string: "https://jsonplaceholder.typicode.com")!)){
        self.remoteUserLoader = remoteUserLoader
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    public func getPosts(userId: Int) {
        remoteUserLoader?.loadPosts(userId: userId) { [weak self] result in
            switch result {
            case let .success(posts):
                self?.dataSource = posts
                self?.mapPostData()
            case let .failure(error):
                switch error {
                case .connectivity:
                    //TODO: implement this
                    break
                case .invalidData:
                    //TODO: implement this
                    break
                }
            }
        }
    }
    
    private func mapPostData() {
        posts.value = self.dataSource?.compactMap({PostsTableCellViewModel(post:$0)})
    }
}
