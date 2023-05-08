//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

class UsersViewModel {
    
    var dataSource: [Users]?
    let remoteUserloader: RemoteUsersLoader?
    var users: Observable<[UserTableCellViewModel]> = Observable(nil)
    
    public init(remoteUserLoader: RemoteUsersLoader = RemoteUsersLoader(url: URL(string: "http://localhost:4567/users")!)){
        self.remoteUserloader = remoteUserLoader
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in: Int) -> Int {
        dataSource?.count ?? 0
    }
    
    public func getUsers() {
        remoteUserloader?.load { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(users):
                self?.dataSource = users
                self?.mapUserData()
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
    
    private func mapUserData() {
        users.value = self.dataSource?.compactMap({UserTableCellViewModel(user: $0)})
    }
}
