//
//  TableViewCellInGame.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 05/12/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class TableViewCellInGame: UITableViewCell {
    
    @IBOutlet weak var nomInvocateurLabel: UILabel!
    @IBOutlet weak var imageViewChampion: UIImageView!
    @IBOutlet weak var imageViewSpell1: UIImageView!
    @IBOutlet weak var imageViewSpell2: UIImageView!
    @IBOutlet weak var nomChampionLabel: UILabel!
    @IBOutlet weak var imageViewRank: UIImageView!
    @IBOutlet weak var nomRankLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
