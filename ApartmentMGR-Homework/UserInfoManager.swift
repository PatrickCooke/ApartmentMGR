//
//  UserInfoManager.swift
//  ApartmentMGR-Homework
//
//  Created by Patrick Cooke on 5/18/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {
    static let sharedInstance = UserInfoManager()
    
    let backendless = Backendless.sharedInstance()
    var currentuser = BackendlessUser()
    var userEmail :String = ""
    var userID :String = ""
    
    func setUserInfo(email :String, ownerId :String) {
        userEmail = email
        userID = ownerId
    }
    
}
