//
//  UserDetailsViewController.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import UIKit

class UserDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var joinDate: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var topInfoView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Constants
    private let repoListViewModel = UserReposViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Variables
    var userDetails: UserDetails?
    var name: String?
    private var reposArray: [Repo] = []
    private var filteredRepoArray: [Repo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoListViewModel.delegate = self
        fetchUserDetails(username: name!)
        setupSearchBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.isActive = false
    }
    
    func populateUserDetails() {
        activityIndicator.stopAnimating()
        topInfoView.isHidden = false
        repoTableView.isHidden = false
        if let details = userDetails {
            username.text = details.login
            if let mail = details.email {
                email.isHidden = false
                email.text = mail
            }
            if let loc = details.location {
                location.isHidden = false
                location.text = loc
            }
            if let bioDetail = details.bio {
                bio.isHidden = false
                bio.text = bioDetail
            }
            joinDate.text = details.createdAt
            followers.text = "\(details.followers) Followers"
            following.text = "Following \(details.following)"

            let url = URL(string: details.avatarURL)
            avatar.sd_setImage(with: url, completed: nil)
            fetchUserDetails(username: details.login!)
        }
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = ConstantString.repoSearch
        searchController.searchBar.sizeToFit()
        repoTableView.tableHeaderView = searchController.searchBar
    }
    
    func fetchUserDetails(username: String) {
        repoListViewModel.getUserDetails(username: username)
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
        filteredRepoArray = reposArray.filter({( item : Repo) -> Bool in
            return item.name.lowercased().contains(searchText.lowercased())
        })
        repoTableView.reloadData()
    }
}

// MARK: - TableView DataSource
extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredRepoArray.count
        }
        return reposArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.repoListCell, for: indexPath) as! ReposTableViewCell
        var repo : Repo!
        if isFiltering() {
            repo = filteredRepoArray[indexPath.row]
        } else {
            repo = reposArray[indexPath.row]
        }
        cell.configureCell(with: repo)
        return cell
    }
}

// MARK: - TableView Delegate
extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var repo : Repo!
        if isFiltering() {
            repo = filteredRepoArray[indexPath.row]
        } else {
            repo = reposArray[indexPath.row]
        }
        guard let url = URL(string: repo.htmlURL) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
}

// MARK: - UserReposDelegate Method
extension UserDetailsViewController: UserReposDelegate {
    func populate(repos: [Repo], userDetail: UserDetails) {
        reposArray = repos
        self.userDetails = userDetail
        
        populateUserDetails()
        self.repoTableView.reloadData()
    }
    
    func showErrorMessage(errorMessage: String) {
        self.showAlert(title: "Error", message: errorMessage)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension UserDetailsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
