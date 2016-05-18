//
//  AdminViewController.swift
//  ApartmentMGR-Homework
//
//  Created by Patrick Cooke on 5/18/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
            print("requests: \(requestArray.count)")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! FixitTableViewCell
        let selectedReq = requestArray[indexPath.row]
        cell.cellTitle.text = selectedReq.fixitDescription
        cell.cellSwitch.setOn(selectedReq.fixitComplete, animated: true)
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


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        requestsTable.reloadData()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
