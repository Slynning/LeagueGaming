//
//  Equipe2ViewController.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 02/12/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class EquipeRougeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewGameInfo: UITableView!
    
    var summoner: Summuner?
    var infoGame: [Summuner.inGameInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableViewGameInfo)
        tableViewGameInfo.dataSource = self
        tableViewGameInfo.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoGame.count > 0 ? (infoGame.first?.summoners.count)! / 2 : 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCellInGame") as! TableViewCellInGame
        let cellule = (infoGame.first?.summoners[indexPath.row + 5])!
        
        //paramétrage de la cellule
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.textLabel?.textColor = UIColor.white
        
        cell.nomInvocateurLabel.text = cellule.name
        cell.nomInvocateurLabel.textColor = UIColor.white
        cell.imageViewChampion.image = cellule.image
        cell.imageViewSpell1.image = cellule.imageSpell1
        cell.imageViewSpell2.image = cellule.imageSpell2
        return cell
    }
}
