//
//  WelcomeViewController.swift
//  Games
//
//  Created by Jhonnatan Macias on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation
import UIKit

class WelcomeViewController: BaseViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set cornerRadius to button
        continueBtn.layer.cornerRadius = 15
    
    }
    
    /// Present GameCatalog ViewController
    ///
    /// - Parameter sender: the uibutton
    @IBAction func goToGameCatalog(_ sender: Any) {
        let gameView = UINavigationController(rootViewController: GameCatalogViewController.init())
        self.present(gameView, animated: true, completion: nil)
    }
}
