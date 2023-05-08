//
//  UsersViewController.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = UsersViewModel()
    
    var usersDataSource: [UserTableCellViewModel] = []
    var filteredUsers: [UserTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchBar.delegate = self
        
        setupView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getUsers()
    }
    
    private func setupView() {
        setupHeaderTitle()
        setupTableView()
    }
    
    private func setupHeaderTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Prueba de ingreso"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        
        let titleView = UIStackView(arrangedSubviews: [titleLabel])
        titleView.axis = .vertical
        titleView.alignment = .leading
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftBarButtonItem.width = -16
        
        navigationItem.leftBarButtonItems = [leftBarButtonItem, UIBarButtonItem(customView: titleView)]
        
        navigationItem.titleView = titleView
        
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0/255.0, green: 102.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
    func bindViewModel() {
        viewModel.users.bind { [weak self] users in
            guard let self = self,
                  let users = users else {
                return
            }
            self.usersDataSource = users
            filteredUsers = usersDataSource
            self.reloadTableView()
        }
    }
}

extension UsersViewController: AlertPresenter {
    func showConnectivityErrorAlert() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            
            let alert = UIAlertController(title: "Connection failure", message: "Check your internet connectivity", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func showInvalidDataAlert() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            
            let alert = UIAlertController(title: "Invalid data", message: "Try again later", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
