//
//  UsersTableViewCell.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var repoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with user: User) {
        usernameLbl.text = user.login
        let url = URL(string: user.avatarURL)
        userIcon.sd_setImage(with: url, completed: nil)
        
        repoLbl.text = "Repo"
//        repoLbl.text = "Repo: \(user.userDetails?.publicRepos)"
    }
}

