//
//  UsersViewController+SearchBar.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation
import UIKit

extension UsersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredUsers = usersDataSource
        } else {
            filteredUsers.removeAll()
            for user in usersDataSource {
                if user.name.lowercased().hasPrefix(searchText.lowercased()){
                    filteredUsers.append(user)
                }
            }
            if filteredUsers.isEmpty {
                showAlert()
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "List is empty", message: "This user does not exist in the list", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
