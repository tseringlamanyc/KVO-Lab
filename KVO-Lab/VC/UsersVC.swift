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
    
    private var allUsers: NSKeyValueObservation?
    
    private var allTheUsers = [UserAccount]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        configureUsersObservation()
    }
    
    private func configureUsersObservation() {
        allUsers = AllUsers.shared.observe(\.allUsers, options: [.old, .new], changeHandler: { [weak self](allusers, change) in
            guard let newUsers = change.newValue else {return}
            self?.allTheUsers = newUsers
        })
    }
    
    private func loadAllUsers() {
        allTheUsers = AllUsers.shared.allUsers
    }
    
    deinit {
        allUsers?.invalidate()
    }
}

extension UsersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTheUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let aUser = allTheUsers[indexPath.row]
        cell.textLabel?.text = aUser.userName
        cell.detailTextLabel?.text = "$ \(aUser.userBalance.description)"
        return cell
    }
}
