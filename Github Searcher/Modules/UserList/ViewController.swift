//
//  ViewController.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: - Constants
    let searchController = UISearchController(searchResultsController: nil)
    private let userListViewModel = UserListViewModel()
    
    // MARK: - Variables
    private var usersArray: [User] = []
    private var selectedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListViewModel.delegate = self
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = ConstantString.userSearch
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func fetchUsersWith(char: String) {
        userListViewModel.searchUsersWith(char: char)
    }
    
    // MARK: - Private Method For Search Functionality
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if searchText.count > 0 {
            fetchUsersWith(char: searchText.lowercased())
        } else {
            usersArray = []
            usersTableView.reloadData()
        }
    }
    
    // MARK: - Navigation Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.detailSegue {
            let vc = segue.destination as! UserDetailsViewController
            vc.name = selectedUser.login
        }
    }
}

// MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.userListCell, for: indexPath) as! UsersTableViewCell
        cell.configureCell(with: usersArray[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = usersArray[indexPath.row]
        performSegue(withIdentifier: Segue.detailSegue, sender: self)
    }
}

// MARK: - UserListDelegate
extension ViewController: UserListDelegate {
    func populate(users: [User]) {
        self.usersArray = users
        self.usersTableView.reloadData()
    }
    
    func showErrorMessage(errorMessage: String) {
        self.showAlert(title: "Error", message: errorMessage)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
