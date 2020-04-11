//
//  UsersVC.swift
//  KVO-Lab
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var allUsersObservation: NSKeyValueObservation?
    private var balanceObservation: NSKeyValueObservation?
    
    private var allUsers = [UserAccount]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadAllUsers()
        configureUsersObservation()
    }
    
    private func loadAllUsers() {
        allUsers = AllUsers.shared.allUsers
    }
    
    
    private func configureUsersObservation() {
        allUsersObservation = AllUsers.shared.observe(\.allUsers, options: [.old, .new], changeHandler: { [weak self](allusers, change) in
            guard let newUsers = change.newValue else {return}
            self?.allUsers = newUsers
        })
    }
    
    deinit {
        allUsersObservation?.invalidate()
    }
}

extension UsersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let aUser = allUsers[indexPath.row]
        cell.textLabel?.text = aUser.userName
        cell.detailTextLabel?.text = "$ \(aUser.userBalance.description)"
        
        balanceObservation = UserAccount.shared.observe(\.userBalance, options: [.new], changeHandler: { (account, change) in
            guard let newBalance = change.newValue else {return}
            let stringBalance = String(format: "%2.f", newBalance)
            cell.detailTextLabel?.text = "$ \(stringBalance)"
        })
        
        return cell
    }
}

extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let transVC = storyboard?.instantiateViewController(identifier: "TransactionVC") as? TransactionVC else {
            fatalError("")
        }
    
        let aUser = allUsers[indexPath.row]
        transVC.aUser = aUser
        navigationController?.pushViewController(transVC, animated: true)
    }
}
