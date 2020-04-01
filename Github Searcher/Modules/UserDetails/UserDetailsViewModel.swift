//
//  UserDetailsViewModel.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import Foundation
import Alamofire

protocol UserReposDelegate {
    func populate(repos: [Repo], userDetail: UserDetails)
    func showErrorMessage(errorMessage : String)
}

class UserReposViewModel {
    
    //MARK: - Variables
    var delegate : UserReposDelegate?
    
    //MARK: - Network Request
    func getRepos(username: String, userDetails: UserDetails) {
        
        AlamofireRequests.sharedInstance.GETRequest(url: Api.sharedInstance.getReposList(for: username)) { (success, response: [Repo]?, error) in
            if success {
                self.delegate?.populate(repos: response ?? [], userDetail: userDetails)
            } else {
                self.delegate?.showErrorMessage(errorMessage: error ?? "Unknown Error")
            }
        }
    }
    
    func getUserDetails(username: String) {
        AlamofireRequests.sharedInstance.GETRequest(url: Api.sharedInstance.getUserDetails(username: username)) { (success, response: UserDetails?, error) in
            if success {
                if let detail = response {
                    self.getRepos(username: username, userDetails: detail)
                }
            } else {
                self.delegate?.showErrorMessage(errorMessage: error ?? "Unknown Error")
            }
        }
    }
}
