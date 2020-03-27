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
    func populate(repos: [Repo])
    func showErrorMessage(errorMessage : String)
}

class UserReposViewModel {
    
    //MARK: - Variables
    var delegate : UserReposDelegate?
    
    //MARK: - Network Request
    func getRepos(username: String) {
        
        AlamofireRequests.sharedInstance.GETRequest(url: Api.sharedInstance.getReposList(for: username)) { (success, response: [Repo]?, error) in
            if success {
                USER_DEFAULTS.set(response, forKey: "REPOS")
                self.delegate?.populate(repos: response ?? [])
            } else {
                self.delegate?.showErrorMessage(errorMessage: error ?? "Unknown Error")
            }
        }
    }
}
