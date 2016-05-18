//
//  ReqAddViewController.swift
//  ApartmentMGR-Homework
//
//  Created by Patrick Cooke on 5/18/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

import UIKit

class ReqAddViewController: UIViewController {

    let backendless = Backendless.sharedInstance()
    var currentuser = BackendlessUser()
    var loginManager = LoginManager.sharedInstance
    var userInfoManager = UserInfoManager.sharedInstance
    var requestArray = [FixitObjects]()
    @IBOutlet private var reqTextField        :UITextField!
    @IBOutlet private var submitButton        :UIButton!
    
    //MARK: - Interactivity Methods
    
    @IBAction func saveReq(button: UIButton) {
        let newFixit = FixitObjects()
        if let ReqText = reqTextField.text {
            newFixit.fixitDescription = ReqText
        }
        newFixit.fixitDate = NSDate()
        newFixit.fixitComplete = false
        if let userID = currentuser.objectId{
            newFixit.fixitUserId = userID
        }
        
        let dataStore = backendless.data.of(FixitObjects.ofClass())
        dataStore.save(newFixit, response: { (result) in
            print("Req Saved")
        }) { (fault) in
            print("server reported error: \(fault)")
        }
        
        self.navigationController!.popViewControllerAnimated(true)

    }
    
    
    //MARK: -  Basic validation
    
    @IBAction private func textFieldChanged() {
        submitButton.enabled = false
        guard let req = reqTextField.text else {
            return
        }
        if isValidLogin(req) {
            submitButton.enabled = true
        }
    }
    
    private func isValidLogin (req: String) -> Bool {
        return req.characters.count > 5
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
