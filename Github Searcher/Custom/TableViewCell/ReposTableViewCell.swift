//
//  ReposTableViewCell.swift
//  Github Searcher
//
//  Created by fm-pc-lt-29/Ruji on 3/27/20.
//  Copyright © 2020 Ruji. All rights reserved.
//

import UIKit

class ReposTableViewCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var fork: UILabel!
    @IBOutlet weak var star: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with repo: Repo) {
        repoName.text = repo.name
        fork.text = "\(repo.forks) Forks"
        star.text = "\(repo.stargazersCount) Stars"
    }

}
