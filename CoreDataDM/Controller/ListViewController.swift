//
//  ListViewController.swift
//  CoreDataDM
//
//  Created by Jitendra on 8/2/17.
//  Copyright © 2017 Jitendra. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var btnAddRecord: UIButton!
    var arrRecords = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        
        
        
    
        
    }
    
// MArk:- Fetch Record from database
    func loadData(){
        self.arrRecords.removeAll()
       arrRecords =   DBHelper.JAFetchAllRecords()
        if arrRecords.count > 0 {
            self.tblList.reloadData()
            self.tblList.isHidden = false
        }else{
            self.tblList.isHidden = true
        }
        
    }
    @IBAction func actionAddRecords(_ sender: UIButton) {
        let userRegistrationVC = self.storyboard?.instantiateViewController(withIdentifier: "DetilsViewController") as! DetilsViewController
        userRegistrationVC.eTypestyle = .eSave
        self.navigationController?.pushViewController(userRegistrationVC, animated: true)
        
  
    
    }
   
    // MARK: UITableViewDataSource methods
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRecords.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self)) as! ListTableViewCell
        let userObjct = self.arrRecords[indexPath.row] as! Users
        print("data\(userObjct.email!)")
        
        cell.lblEmail.text! = userObjct.email!
        cell.lblAddress.text! = userObjct.aboutUS!
        
     
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let userObjct = self.arrRecords[indexPath.row] as! Users
        
        let userRegistrationVC = self.storyboard?.instantiateViewController(withIdentifier: "DetilsViewController") as! DetilsViewController
        userRegistrationVC.objUser = userObjct
        userRegistrationVC.eTypestyle = .eEdit
        self.navigationController?.pushViewController(userRegistrationVC, animated: true)
      
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let userObjct = self.arrRecords[indexPath.row] as! Users
  
         let isDelete = DBHelper.deleteRecord(userObjct.email!)
            
            if isDelete == true{
             self.showMessage(title: "Sucess", bodyMessage: "Delete Sucessfuly")
                self.loadData()
            }else{
            self.showMessage(title: "Alert", bodyMessage: "Error!")
            }
            
            
        }
    }

    func showMessage(title:NSString, bodyMessage:NSString)
    {
        let actionSheetController: UIAlertController = UIAlertController(title:title as String, message:bodyMessage as NSString as String, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        actionSheetController.addAction(defaultAction)
        
        present(actionSheetController, animated: true, completion: nil);
    }
}
