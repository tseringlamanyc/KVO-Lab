//
//  TransactionVC.swift
//  KVO-Lab
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class TransactionVC: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var currentBalance: UILabel!
    
    public var aUser = UserAccount.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateUI() {
        welcomeLabel.text = "Welcome \(aUser.userName)"
    }
    
    @IBAction func depositeChanged(_ sender: UISlider) {
    }
    
    @IBAction func withdrawlChanged(_ sender: UISlider) {
    }
}
