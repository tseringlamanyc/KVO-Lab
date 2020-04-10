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
    @IBOutlet weak var depositSlider: UISlider!
    @IBOutlet weak var withdrawlSlider: UISlider!
    @IBOutlet weak var depositLabel: UILabel!
    @IBOutlet weak var withdrawLabel: UILabel!
    
    public var aUser: UserAccount?
    
    private var balanceObservation: NSKeyValueObservation?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureBalanceObservation()
        configureSliders()
    }
    
    private func updateUI() {
        welcomeLabel.text = "Welcome \(aUser?.userName ?? "")"
        currentBalance.text = "Current balance = $\(aUser?.userBalance ?? 0.0)"
    }
    
    private func configureBalanceObservation() {
        balanceObservation = UserAccount.shared.observe(\.userBalance, options: [.new], changeHandler: { [weak self ](account, change) in
            guard let newBalance = change.newValue else {return}
            let stringBalance = String(format: "%2.f", newBalance)
            self?.currentBalance.text = "New balance = $ \(stringBalance)"
        })
    }
    
    private func configureSliders() {
        depositSlider.minimumValue = 0.0
        depositSlider.maximumValue = 500.0
        
        withdrawlSlider.minimumValue = 0.0
        withdrawlSlider.maximumValue = 500.0
    }
    
    @IBAction func depositeChanged(_ sender: UISlider) {
        let balanceChanged = Double(sender.value)
        let stringBalance = String(format: "%2.f", balanceChanged)
        depositLabel.text = "Deposit - $ \(stringBalance)"
        UserAccount.shared.userBalance = (aUser?.userBalance ?? 0.0) + balanceChanged
    }
    
    @IBAction func withdrawlChanged(_ sender: UISlider) {
        let balanceChanged = Double(sender.value)
        let stringBalance = String(format: "%2.f", balanceChanged)
        withdrawLabel.text = "Withdraw - $ \(stringBalance)"
        UserAccount.shared.userBalance = (aUser?.userBalance ?? 0.0) - balanceChanged
    }
}
