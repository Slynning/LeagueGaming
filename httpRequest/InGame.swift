//
//  InGame.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 02/12/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class InGame: UIViewController {
    
    var summoner: Summuner?
    var inGameInfo: [Summuner.inGameInfo]?
    var equipeBleuController : EquipeBleuViewController!
    var equipeRougeController : EquipeRougeViewController!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        equipeBleuController = storyBoard.instantiateViewController(withIdentifier: "EquipeBleuViewController") as! EquipeBleuViewController
        self.addChildViewController(equipeBleuController)
        self.scrollView.addSubview(equipeBleuController.view)
        equipeBleuController.didMove(toParentViewController: self)
        
        equipeRougeController = storyBoard.instantiateViewController(withIdentifier: "EquipeRougeViewController") as! EquipeRougeViewController
        var frameRouge = equipeRougeController.view.frame
        frameRouge.origin.x = self.view.frame.size.width
        equipeRougeController.view.frame = frameRouge
        self.addChildViewController(equipeRougeController)
        self.scrollView.addSubview(equipeRougeController.view)
        equipeRougeController.didMove(toParentViewController: self)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height - 600)
        
        getInGame()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInGame()
    }
    
    func getInGame () {
        inGameInfo = (self.summoner?.getInGameInfo(idSummoner: (self.summoner?.idSummuner)!))!
        
        if((inGameInfo?.count)! == 0){
            let alert = UIAlertController(title: "Alert", message: "L'invocateur n'est pas dans une partie", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.equipeBleuController.infoGame = inGameInfo!
            self.equipeRougeController.infoGame = inGameInfo!
        }
    }
}
