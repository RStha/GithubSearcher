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
    
    private let userListViewModel = UserListViewModel()
    
    private var usersArray: [User] = []
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let vc = segue.destination as! UserDetailsViewController
            vc.userDetails = selectedUser
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.userListCell, for: indexPath) as! UsersTableViewCell
        cell.usernameLbl.text = usersArray[indexPath.row].login
        if let detail = usersArray[indexPath.row].userDetails {
            cell.repoLbl.text = "Repo: \(detail.publicRepos)"
        }
        let url = URL(string: usersArray[indexPath.row].avatarURL)
        cell.userIcon.sd_setImage(with: url, completed: nil)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = usersArray[indexPath.row].userDetails
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}

extension ViewController: UserListDelegate {
    func populate(users: [User]) {
        self.usersArray = users

        USER_DEFAULTS.set(users, forKey: "USERS")
        self.usersTableView.reloadData()
    }
    
    func showErrorMessage(errorMessage: String) {
        
    }
    
    
}
