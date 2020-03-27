//
//  UserDetailsViewController.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var userDetails: UserDetails!
    
    private let repoListViewModel = UserReposViewModel()
    
    private var reposArray: [Repo] = []
    
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var joinDate: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoListViewModel.delegate = self
        populateUserDetails()
    }
    
    func populateUserDetails() {
        if let details = userDetails {
            username.text = details.login
            email.text = details.email
            location.text = details.location
            joinDate.text = details.createdAt
            followers.text = "\(details.followers) Followers"
            following.text = "Following \(details.following)"

            let url = URL(string: details.avatarURL)
            avatar.sd_setImage(with: url, completed: nil)
            fetchRepos(username: details.login!)
        }
    }
        
    func fetchRepos(username: String) {
        repoListViewModel.getRepos(username: username)
    }
}

extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.repoListCell, for: indexPath) as! ReposTableViewCell
        let repo = reposArray[indexPath.row]
        cell.repoName.text = repo.name
        cell.fork.text = "\(repo.forks) Forks"
        cell.star.text = "\(repo.stargazersCount) Stars"
        return cell
    }
}

extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = userDetails else {
            return
        }
        guard let url = URL(string: details.reposURL) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
}

extension UserDetailsViewController: UserReposDelegate {
    func populate(repos: [Repo]) {
        reposArray = repos
        self.repoTableView.reloadData()
    }
    
    func showErrorMessage(errorMessage: String) {
    }
}
