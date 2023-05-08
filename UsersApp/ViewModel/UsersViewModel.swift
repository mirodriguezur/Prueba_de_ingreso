//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

class UsersViewModel {
    
    var dataSource = [Users]()
    let remoteUserloader: RemoteUsersLoader?
    
    public init(remoteUserLoader: RemoteUsersLoader = RemoteUsersLoader(url: URL(string: "http://localhost:4567/users")!)){
        self.remoteUserloader = remoteUserLoader
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in: Int) -> Int {
        30
    }
    
    public func getUsers() {
        remoteUserloader?.load { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(users):
                self?.dataSource = users
            case let .failure(error):
                switch error {
                case .connectivity:
                    print("connectivity error")
                case .invalidData:
                    print("invalid data")
                }
            }
        }
    }
}
