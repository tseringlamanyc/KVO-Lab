//
//  ViewController.swift
//  KVO-Lab
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class CreateVC: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var balanceTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTFs()
    }
    
    private func configureTFs() {
        userNameTF.delegate = self
        balanceTF.delegate = self 
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        guard let userName = userNameTF.text, !userName.isEmpty, let balance = balanceTF.text, !balance.isEmpty else {
            showAlert(title: "Fail", message: "Please enter name and balance")
            return
        }
        
        let user = UserAccount.shared
        user.userName = userName
        user.userBalance = Double(balance) ?? 0.0
        
        AllUsers.shared.allUsers.append(user)
        
        showAlert(title: "Success", message: "Account created")
        
        userNameTF.text = ""
        balanceTF.text = ""
    }

}

extension CreateVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
