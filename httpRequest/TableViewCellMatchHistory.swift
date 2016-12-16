//
//  TableViewCellMatchHistory.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 01/12/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class TableViewCellMatchHistory: UITableViewCell {
    
    @IBOutlet weak var gameModeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageChampion: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ipEarnedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
