//
//  UserListViewModel.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import Foundation
import Alamofire

protocol UserListDelegate {
    func populate(users: [User])
    func showErrorMessage(errorMessage : String)
}

class UserListViewModel {
    
    //MARK: - Variables
    var delegate : UserListDelegate?
//    private var users: [User] = []
    
    //MARK: - Network Request
    func searchUsersWith(char: String) {
        AlamofireRequests.sharedInstance.GETRequest(url: Api.sharedInstance.searchGithubUser(with: char, page: 1)) { (success, response: Users?, error) in
            if success {
                guard let users = response else {
                    return
                }
//                for i in 0...users.items.count - 1 {
//                    self.getUserDetails(user: users.items[i], isLast: (i == users.items.count - 1))
//                }
                self.delegate?.populate(users: users.items)
            } else {
                self.delegate?.showErrorMessage(errorMessage: error ?? "Unknown Error")
            }
        }
    }
    
//    func getUserDetails(user: User, isLast: Bool) {
//        AlamofireRequests.sharedInstance.GETRequest(url: Api.sharedInstance.getUserDetails(username: user.login)) { (success, response: UserDetails?, error) in
//            if success {
//                if let detail = response {
//                    var updatedUser = user
//                    updatedUser.userDetails = detail
//                    self.users.append(updatedUser)
//                    if isLast {
//                        self.delegate?.populate(users: self.users)
//                    }
//                }
//            } else {
//                self.delegate?.showErrorMessage(errorMessage: error ?? "Unknown Error")
//            }
//        }
//    }
}
