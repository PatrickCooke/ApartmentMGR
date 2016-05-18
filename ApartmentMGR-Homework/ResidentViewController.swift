//
//  ResidentViewController.swift
//  ApartmentMGR-Homework
//
//  Created by Patrick Cooke on 5/18/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

import UIKit

class ResidentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let backendless = Backendless.sharedInstance()
    var currentuser = BackendlessUser()
    var loginManager = LoginManager.sharedInstance
    var userInfoManager = UserInfoManager.sharedInstance
    var requestArray = [FixitObjects]()
    @IBOutlet private weak var requestsTable  :UITableView!


    
    //MARK: - FetchData
    
    private func fetchData() {
        let dataQuery = BackendlessDataQuery()
        var error: Fault?
        let bc = backendless.data.of(FixitObjects.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            requestArray = bc.getCurrentPage() as! [FixitObjects]
        } else {
            print("server error \(error)")
            requestArray = [FixitObjects]()
        }
    }
    
    
    //MARK: - table Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let selectedReq = requestArray[indexPath.row]
        cell.textLabel?.text = selectedReq.fixitDescription
        if selectedReq.fixitComplete{
            cell.backgroundColor = UIColor.lightGrayColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }
    
    //MARK: - Save Function
    
    private func saveFixitReg(newFixit: FixitObjects) {
        let dataStore = backendless.data.of(FixitObjects.ofClass())
        dataStore.save(newFixit, response: { (result) in
            print("Req Saved")
            }) { (fault) in
                print("server reported error: \(fault)")
        }
    }
    
    
    //MARK: - tempAddRecord
    
    private func tempAddRecords() {
        let newItem = FixitObjects()
        newItem.fixitDescription = "new Fix-it Request"
        newItem.fixitDate = NSDate()
        newItem.fixitComplete = false
        if let userID = currentuser.objectId{
                 newItem.fixitUserId = userID
        }
        saveFixitReg(newItem)
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tempAddRecords()
        fetchData()
        requestsTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
