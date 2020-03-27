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
}
