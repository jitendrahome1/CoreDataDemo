//
//  DetilsViewController.swift
//  CoreDataDM
//
//  Created by Jitendra on 8/2/17.
//  Copyright © 2017 Jitendra. All rights reserved.
//

import UIKit

enum eType {
    case eEdit
    case eSave
    case eNotType
    
}
class DetilsViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var viewBGBox: UIView!
    @IBOutlet weak var textName: UITextField!
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textNumber: UITextField!
    var eTypestyle:eType = .eNotType
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var textARAboutUS: UITextView!
    @IBOutlet weak var textPin: UITextField!
    var objUser:  Users!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if eTypestyle == .eEdit{
            lblTitle.text  = "Edit"
        }else if eTypestyle == .eSave{
            lblTitle.text  = "Save"
        }
        self.loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // load data
    func loadData(){
        if (self.objUser != nil) {
       self.textName.text! = self.objUser.name!
         self.textEmail.text! = self.objUser.email!
            self.textNumber.text! = String(self.objUser.phone)
            self.textPin.text! = String(self.objUser.pin)
            self.textARAboutUS.text! = self.objUser.aboutUS!
            
            self.textEmail.isUserInteractionEnabled = false
        }else{
        self.textEmail.isUserInteractionEnabled = true
        }
    }

    @IBAction func actionSave(_ sender: UIButton) {
        
        if eTypestyle == .eSave{
            let isExist = DBHelper.isAlredyEmail(_email: self.textEmail.text!)
            
            if isExist == true{
                self.showMessage(title: "Alert", bodyMessage: "Email I is alredy in  store")
            }
            else
            {
                let result = DBHelper.saveRecords(self.textName.text!, email: self.textEmail.text!, address: self.textARAboutUS.text!, phone: Int(self.textNumber.text!)!, pin: Int(self.textPin.text!)!)
                if  result == true{
                    self.showMessage(title: "Sucess", bodyMessage: "Record Save Sucessfully!")
                    
                }else{
                    self.showMessage(title: "Alert", bodyMessage: "Error!")
                    print("Error")
                }
            }
        }
        else if eTypestyle == .eEdit{
            let result = DBHelper.updateRecords(self.textName.text!, email: self.textEmail.text!, address: self.textARAboutUS.text!, phone: Int(self.textNumber.text!)!, pin: Int(self.textPin.text!)!)
            if  result == true{
                self.showMessage(title: "Sucess", bodyMessage: "Record Update Sucessfully!")
                
            }else{
                self.showMessage(title: "Alert", bodyMessage: "Error!")
                print("Error")
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
    

    @IBAction func actionBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }

}
