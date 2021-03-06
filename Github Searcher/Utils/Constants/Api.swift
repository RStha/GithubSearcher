//
//  Api.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import Foundation

class Api {
    static let sharedInstance = Api()

    static let baseURL = "https://api.github.com"
    
    let userURL = baseURL + "/users"
    
    func getUsersList(from: Int) -> String {
        return userURL + "?since=\(from)"
    }
    
    func getUserDetails(username: String) -> String{
        return userURL + "/\(username)"
    }
    
    func getReposList(for username: String) -> String{
        return userURL + "/\(username)/repos"
    }
    
    func searchGithubUser(with chars: String, page: Int) -> String {
        return Api.baseURL + "/search/users?q=\(chars)&page=\(page)"
    }
    
}
