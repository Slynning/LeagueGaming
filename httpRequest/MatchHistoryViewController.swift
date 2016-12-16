//
//  MatchHistoryViewController.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 29/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit
import CoreData

class MatchHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewMatchHistory: UITableView!
    
    var summoner: Summuner?
    var listGame: [Summuner.gameInfoHistory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableViewMatchHistory)
        tableViewMatchHistory.dataSource = self
        tableViewMatchHistory.delegate = self
        getMatchHistory()
    }
    
    func getMatchHistory () {
        listGame = (summoner?.getMatchHistory())!
        tableViewMatchHistory.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGame.count;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCellMatchHistory") as! TableViewCellMatchHistory
        let cellule = listGame[indexPath.row]
        
        //paramétrage de la cellule
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.textLabel?.textColor = UIColor.white
        cell.gameModeLabel.text = cellule.subType
        cell.scoreLabel.text = String(cellule.numKill) + "/" + String(cellule.numDead) + "/" + String(cellule.numAssist)
        cell.imageChampion.image = cellule.championImage
        cell.ipEarnedLabel.text = "+ \(cellule.ipEarned) IP"
        cell.dateLabel.text = Utils().getDateFromTimeStamp(timeStampSince1070: TimeInterval(cellule.date/1000))
        cell.backgroundColor = cellule.win ? UIColor.init(red: 0.64, green: 0.81, blue: 0.92, alpha: 0.5)
                                            :UIColor.init(red: 0.88, green: 0.71, blue: 0.70, alpha: 0.8)
        return cell
    }
}
