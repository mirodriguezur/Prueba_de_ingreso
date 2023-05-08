//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

protocol AlertPresenter {
    func showConnectivityErrorAlert()
    func showInvalidDataAlert()
}

class UsersViewModel {
    
    var dataSource: [Users]?
    let remoteUserloader: RemoteUsersLoader?
    var users: Observable<[UserTableCellViewModel]> = Observable(nil)
    
    var delegate: AlertPresenter?
    
    public init(remoteUserLoader: RemoteUsersLoader = RemoteUsersLoader(url: URL(string: "https://jsonplaceholder.typicode.com/users")!)){
        self.remoteUserloader = remoteUserLoader
    }
    
    func numberOfSections() -> Int {
        1
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
                    self?.delegate?.showConnectivityErrorAlert()
                case .invalidData:
                    self?.delegate?.showInvalidDataAlert()
                }
            }
        }
    }
    
    private func mapUserData() {
        users.value = self.dataSource?.compactMap({UserTableCellViewModel(user: $0)})
    }
}
