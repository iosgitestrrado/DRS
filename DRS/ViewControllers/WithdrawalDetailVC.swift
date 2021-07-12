//
//  WithdrawalDetailVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/27/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import SwiftyXMLParser
class WithdrawalDetailVC: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var lblAmt: UILabel!
    @IBOutlet weak var lblTransID: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    var strTransID = String()
    var strDateTime = String()
    var strAmount = String()
    var strHead = String()
       var strFail = String()
    var strTitle:String = String()
    @IBOutlet weak var viewFail: UIView!
    @IBOutlet weak var lblFail: UILabel!
    //MARK: - IBOutlet
    @IBOutlet var lblTransIDData: UILabel!
    @IBOutlet var lblDateTimeData: UILabel!
    @IBOutlet var lblAmountData: UILabel!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var viewWithDrawalBG: UIView!
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1
        {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Withdrawal_Details_Title.text {
                    strTitle = text
                 self.title = strTitle
                }
                if let text = xml.resource.Withdrawal_Details_withdraw_req_submit.text {
                    lblHeader.text =  text
                }
                if let text = xml.resource.Withdrawal_Details_amount.text {
                    lblAmt.text = text
                }
                if let text = xml.resource.Withdrawal_Details_date_time.text {
                   lblDateTime.text = text
                }
                if let text = xml.resource.Withdrawal_Details_trans_ID.text {
                   lblTransID.text = text
                }
         
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
               if let text = xml.resource.Withdrawal_Details_Title.text {
                    strTitle = text
                 self.title = strTitle
                }
                if let text = xml.resource.Withdrawal_Details_withdraw_req_submit.text {
                    lblHeader.text =  text
                }
                if let text = xml.resource.Withdrawal_Details_amount.text {
                    lblAmt.text = text
                }
                if let text = xml.resource.Withdrawal_Details_date_time.text {
                   lblDateTime.text = text
                }
                if let text = xml.resource.Withdrawal_Details_trans_ID.text {
                   lblTransID.text = text
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.changeLanguage()
        self.title = strTitle
        self.addBackButton()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewFail.layer.cornerRadius = 15
        viewWithDrawalBG.layer.cornerRadius = 15
        lblTransIDData.text!  = strTransID
        lblDateTimeData.text!  = strDateTime
        lblAmountData.text!  = strAmount
        if strFail.count>0 {
            viewFail.isHidden = false
            viewWithDrawalBG.isHidden = true
        } else{
            viewFail.isHidden = true
            viewWithDrawalBG.isHidden = false
        }
        lblFail.text = strFail
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
