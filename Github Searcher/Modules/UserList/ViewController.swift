//
//  ViewController.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: - Constants
    let searchController = UISearchController(searchResultsController: nil)
    private let userListViewModel = UserListViewModel()
    
    private var usersArray: [User] = []
    private var filteredUsersArray: [User] = []
    private var selectedUser: UserDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListViewModel.delegate = self
        fetchUsers()
    }
    
    func fetchUsers() {
        if let users: [User] = USER_DEFAULTS.object(forKey: "USERS") as? [User] {
            print(users)
            usersArray = users
            usersTableView.reloadData()
        } else {
            userListViewModel.getUsers()
        }
    }
    
    // MARK: - Private Method For Search Functionality
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredUsersArray = usersArray.filter({( item : User) -> Bool in
           return item.login.lowercased().contains(searchText.lowercased())
        })
        usersTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let vc = segue.destination as! UserDetailsViewController
            vc.userDetails = selectedUser
        }
    }
}

// MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredUsersArray.count
        }
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.userListCell, for: indexPath) as! UsersTableViewCell
        var user: User
        if isFiltering() {
            user = filteredUsersArray[indexPath.row]
        } else {
            user = usersArray[indexPath.row]
        }
        cell.usernameLbl.text = user.login
        if let detail = user.userDetails {
            cell.repoLbl.text = "Repo: \(detail.publicRepos)"
        }
        let url = URL(string: user.avatarURL)
        cell.userIcon.sd_setImage(with: url, completed: nil)
        return cell
    }
}

// MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            selectedUser = filteredUsersArray[indexPath.row].userDetails
        } else {
            selectedUser = usersArray[indexPath.row].userDetails
        }
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}


// MARK: - UserListDelegate
extension ViewController: UserListDelegate {
    func populate(users: [User]) {
        self.usersArray = users

        USER_DEFAULTS.set(users, forKey: "USERS")
        self.usersTableView.reloadData()
    }
    
    func showErrorMessage(errorMessage: String) {
        
    }
    
}

// MARK: - UISearchResultsUpdating Delegate
extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
