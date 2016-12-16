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
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let equipeBleuController = storyBoard.instantiateViewController(withIdentifier: "EquipeBleuViewController") as! EquipeBleuViewController
        self.addChildViewController(equipeBleuController)
        self.scrollView.addSubview(equipeBleuController.view)
        equipeBleuController.didMove(toParentViewController: self)
        
        let equipeRougeController = storyBoard.instantiateViewController(withIdentifier: "EquipeRougeViewController") as! EquipeRougeViewController
        var frameRouge = equipeRougeController.view.frame
        frameRouge.origin.x = self.view.frame.size.width
        equipeRougeController.view.frame = frameRouge
        self.addChildViewController(equipeRougeController)
        self.scrollView.addSubview(equipeRougeController.view)
        equipeRougeController.didMove(toParentViewController: self)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height - 600)
        
        getInGame(equipeBleuViewController: equipeBleuController, equipeRougeViewController: equipeRougeController)
        // Do any additional setup after loading the view.
    }
    
    func getInGame (equipeBleuViewController: EquipeBleuViewController, equipeRougeViewController: EquipeRougeViewController) {
        equipeBleuViewController.infoGame = (self.summoner?.getInGameInfo(idSummoner: (self.summoner?.idSummuner)!))!
        equipeRougeViewController.infoGame = equipeBleuViewController.infoGame
    }
}
