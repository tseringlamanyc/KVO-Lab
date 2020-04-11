//
//  UserProfileVC.swift
//  KVO-Lab
//
//  Created by Tsering Lama on 4/10/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    private var allUsersObservation: NSKeyValueObservation?
     private var balanceObservation: NSKeyValueObservation?
   
    private var allUsers = [UserAccount]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureUsersObservation()
        updateUI()
    }
    
    private func configureUsersObservation() {
          allUsersObservation = AllUsers.shared.observe(\.allUsers, options: [.old, .new], changeHandler: { [weak self](allusers, change) in
              guard let newUsers = change.newValue else {return}
              self?.allUsers = newUsers
          })
      }
    
    private func loadData() {
        allUsers = AllUsers.shared.allUsers
     }
    
    private func updateUI() {
        welcomeLabel.text = "Welcome \(allUsers.first?.userName ?? "No user")"
         balanceLabel.text = "Balance $ \(allUsers.first?.userBalance ?? 0.0)"
        
        balanceObservation = UserAccount.shared.observe(\.userBalance, options: [.new], changeHandler: { [weak self](account, change) in
            guard let newBalance = change.newValue else {return}
            let stringBalance = String(format: "%2.f", newBalance)
            self?.balanceLabel.text = "Balance $ \(stringBalance)"
        })
    }
    
}
