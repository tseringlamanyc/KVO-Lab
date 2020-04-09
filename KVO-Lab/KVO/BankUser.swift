//
//  BankUser.swift
//  KVO-Lab
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

@objc
class UserAccount: NSObject {
    static var shared = UserAccount()
    var userName: String = "no name"
    @objc dynamic var userBalance: Double = 0.0

}

@objc
class AllUsers: NSObject {
    static var shared = AllUsers()
    @objc dynamic var allUsers = [UserAccount]()
    private override init() {
        allUsers = []
    }
}
