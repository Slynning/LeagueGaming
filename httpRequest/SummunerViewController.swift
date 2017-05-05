
//
//  ViewController.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 23/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class SummunerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var typePartiePicker: UIPickerView!
    @IBOutlet weak var totalWinLabel: UILabel!
    @IBOutlet weak var totalKillLabel: UILabel!
    @IBOutlet weak var totalAssistLabel: UILabel!
    @IBOutlet weak var tourelleDetruiteLabel: UILabel!
    @IBOutlet weak var totalMinionKillLabel: UILabel!
    
    var typePartieDataSource = [String]()
    
    var data: Data = Data()
    var summuner: Summuner?
    let httpRequestLeague = HttpRequestLeague()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typePartiePicker.dataSource = self
        self.typePartiePicker.delegate = self
        
        let util = Utils()
        
        let nomInvocateur = util.recursiviteOptimale(data: data, info: "name")
        let levelInvocateur = Int(util.recursiviteOptimale(data: data, info: "summonerLevel"))
        let idInvocateur = Int(util.recursiviteOptimale(data: data, info: "id"))
        self.summuner = Summuner(name: nomInvocateur, level: levelInvocateur!, idSummuner: idInvocateur!)
        self.summuner?.statSummunerData = httpRequestLeague.getDataFromServeur(url: (ApiLeague(region: "euw").statSummonerWith(summonerId: (summuner?.idSummuner)!)))
        
        let matchHistoryViewController = self.tabBarController?.viewControllers?[1] as! MatchHistoryViewController
        matchHistoryViewController.summoner = self.summuner
        
        let inGameInfoViewController = self.tabBarController?.viewControllers?[3] as! InGame
        inGameInfoViewController.summoner = self.summuner
        
        self.typePartieDataSource = (summuner?.getListePartie())!
        getStatSummuner()
    }
    
    func getStatSummuner () {
        print ("info mis à jour avec : \(typePartieDataSource[typePartiePicker.selectedRow(inComponent: 0)])")
        summuner?.statParGame(typeDePartie: typePartieDataSource[typePartiePicker.selectedRow(inComponent: 0)])
        updateUI()
    }
    
    func updateUI () {
        nomLabel.text = "Nom : \((summuner?.name)!)"
        levelLabel.text = "Niveau : \((summuner?.level)!)"
        totalWinLabel.text = "Total win : \((summuner?.statAllGame.win)!)"
        totalKillLabel.text = "Total kill : \((summuner?.statAllGame.totalKill)!)"
        totalAssistLabel.text = "Total assist : \((summuner?.statAllGame.totalAssist)!)"
        tourelleDetruiteLabel.text = "Tourelle détruite : \((summuner?.statAllGame.tourelleDetruite)!)"
        totalMinionKillLabel.text = "Minion tués : \((summuner?.statAllGame.totalMinionsKill)!)"
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typePartieDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typePartieDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getStatSummuner()
    }
}



