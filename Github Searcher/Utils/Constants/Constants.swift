//
//  Constants.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import Foundation

let USER_DEFAULTS = UserDefaults.standard

struct Cell {
    static var userListCell = "UserListCell"
    static var repoListCell = "RepoListCell"
}

struct Segue {
    static var detailSegue = "DetailSegue"
}

struct ConstantString {
    static var repoSearch = "Search for User's Repositories"
    static var userSearch = "Search for Users"
}
