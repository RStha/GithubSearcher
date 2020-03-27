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
    private var users: [User] = []
    
    //MARK: - Network Request
    func getUsers() {
        
        AlamofireRequests.sharedInstance.GETRequest(url: Api.sharedInstance.getUsersList(from: 0)) { (success, response: [User]?, error) in
            if success {
                guard let users = response else {
                    return
                }
                
                for user in users {
                    self.getUserDetails(user: user)
                }
                print("\(self.users) Users101")
                self.delegate?.populate(users: self.users)
            } else {
                self.delegate?.showErrorMessage(errorMessage: error ?? "Unknown Error")
            }
        }
    }
    
    func getUserDetails(user: User) {
        AlamofireRequests.sharedInstance.GETRequest(url: Api.sharedInstance.getUserDetails(username: user.login)) { (success, response: UserDetails?, error) in
            if success {
                if let detail = response {
                    var updatedUser = user
                    updatedUser.userDetails = detail
                    self.users.append(updatedUser)
                }
            } else {
                self.delegate?.showErrorMessage(errorMessage: error ?? "Unknown Error")
            }
        }
    }
}
