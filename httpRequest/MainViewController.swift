//
//  MainViewController.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 25/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var nomInvocateurLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSummunerSegue" {
            let tabBarController = segue.destination as! UITabBarController
            let destinationViewController = tabBarController.viewControllers?[0] as! SummunerViewController
            let data = HttpRequestLeague().getDataFromServeur(url: (ApiLeague(region: "euw").summunerApi(summunerName: self.nomInvocateurLabel.text!)))
            destinationViewController.data = data
        }
    }
}
