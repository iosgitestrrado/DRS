//
//  TransactionVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import SwiftyXMLParser
class TransactionVC: UIViewController {
    
    var strTitle:String = String()
    var strTotal = String()
    var strMerchantName = String()
    var strDateTime = String()
    var strTransID = String()
    var strUserID = String()
    var strRebate = String()
     var errorHead = String()
    var errorMessage = String()
    var walletErrorMessages = Bool()

    var errorStatus = Bool()
    
    @IBOutlet var viewFailure: UIView!
    
    @IBOutlet var lblFailureHead: UILabel!
    @IBOutlet var lblFailureContent: UILabel!
    
    

    @IBOutlet weak var viewSuccess: UIView!
    @IBOutlet var lblSuccesHead: UILabel!
    @IBOutlet var lblTotalData: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var lblRebateData: UILabel!
    @IBOutlet var lblRebate: UILabel!
    @IBOutlet var lblUserIDData: UILabel!
    @IBOutlet var lblUserID: UILabel!
    @IBOutlet var lblTransactionIDData: UILabel!
    @IBOutlet var lblTransactionID: UILabel!
    @IBOutlet var lblDateTimeData: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblMerchantNameData: UILabel!
    @IBOutlet var lblMerchantName: UILabel!
    /*
     
         <scan_code_payment_unsuccess>Payment Unsuccessful</scan_code_payment_unsuccess>
         <scan_code_merchant_insufficient_credit_unable_proceed>Merchant Insufﬁcient Credit, Unable to Proceed.</scan_code_merchant_insufficient_credit_unable_proceed>
         <scan_code_insufficient_wallet_credit_unable_proceed>Insufﬁcient Wallet Credit, Unable to Proceed.</scan_code_insufficient_wallet_credit_unable_proceed>
    
     */
    
    func changeLanguage() {
              let sharedDefault = SharedDefault()
              
              if sharedDefault.getLanguage() == 1 {
                  print("Bermese")
                  
                  let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
                  do {
                      var text = try String(contentsOfFile: path!)
                      //print("text",text)
                      let xml = try! XML.parse(text)
                      
                    if let text = xml.resource.scan_code_transcation_detail.text {
                        strTitle = text
                        self.title = strTitle
                    }
                    if let text = xml.resource.scan_code_payment_success.text {
                        lblSuccesHead.text = text
                    }
                    if let text = xml.resource.scan_code_total.text {
                        lblTotal.text = text
                    }
                    if let text = xml.resource.scan_code_merchant_name.text {
                        lblMerchantName.text = text
                    }
                    if let text = xml.resource.scan_code_date_time.text {
                        lblDateTime.text = text
                    }
                    if let text = xml.resource.scan_code_trans_ID.text {
                        lblTransactionID.text = text
                    }
                    if let text = xml.resource.scan_code_User_ID.text {
                        lblUserID.text = text
                    }
                      
                      if let text = xml.resource.scan_code_rebate_entitled.text
                      {
                          lblRebate.text = text
                      }
                    
                    if let text = xml.resource.scan_code_payment_unsuccess.text {
                        lblFailureHead.text = text
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
                      
                    if let text = xml.resource.scan_code_transcation_detail.text {
                        strTitle = text
                        self.title = strTitle
                    }
                    if let text = xml.resource.scan_code_payment_success.text {
                        lblSuccesHead.text = text
                    }
                    if let text = xml.resource.scan_code_total.text {
                        lblTotal.text = text
                    }
                    if let text = xml.resource.scan_code_merchant_name.text {
                        lblMerchantName.text = text
                    }
                    if let text = xml.resource.scan_code_date_time.text {
                        lblDateTime.text = text
                    }
                    if let text = xml.resource.scan_code_trans_ID.text {
                        lblTransactionID.text = text
                    }
                    if let text = xml.resource.scan_code_User_ID.text {
                        lblUserID.text = text
                    }
                      
                      if let text = xml.resource.scan_code_rebate_entitled.text {
                          lblRebate.text = text
                      }
                      
                  }
                  catch(_){print("error")}
                  
                  
              }
              
          }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.title  = strTitle
        self.addCustomBackButton()
        
        viewSuccess.layer.cornerRadius = 10
        viewFailure.layer.cornerRadius = 10
        //viewFailure.isHidden = true
        
        //lblFailureContent.text = Constants.TransactionDetPageFailMsg
        lblSuccesHead.text = Constants.TransactionDetPageSubTitle
        lblTotal.text = Constants.TransactionDetPageTotal
        lblMerchantName.text = Constants.TransactionDetPageMName
        lblDateTime.text = Constants.TransactionDetPageDate
        lblTransactionID.text = Constants.TransactionDetPageTransaction
        lblUserID.text = Constants.TransactionDetPageUser
        self.changeLanguage()
        
        let sharedDefault = SharedDefault()

        if sharedDefault.getLanguage() == 1
        {
            lblRebate.text = Constants.TransactionDetPageRebateBermese

        }
        else
        {
            lblRebate.text = Constants.TransactionDetPageRebate

        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let sharedDefault = SharedDefault()

        // Do any additional setup after loading the view.
        print("errorStatus Transaction errorHead ",errorHead)
        print("errorStatus Transaction errorMessage ",errorMessage)
        print("errorStatus Transaction ",errorStatus)
        if errorStatus == true
        {
            viewSuccess.isHidden = true
            viewFailure.isHidden = false
            
            if  walletErrorMessages
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    lblFailureContent.text = Constants.inSufficientAmountWalletBUR

                }
                else if sharedDefault.getLanguage() == 0
                {
                    lblFailureContent.text = Constants.inSufficientAmountWalletENG
                }
            }
            else
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    lblFailureContent.text = Constants.inSufficientAmountCreditBUR

                }
                else if sharedDefault.getLanguage() == 0
                {
                    lblFailureContent.text = Constants.inSufficientAmountCreditENG
                }
            }
            lblFailureHead.text = errorHead
            //lblFailureContent.text = errorMessage
            
        }
        else
        {
            viewSuccess.isHidden = false
            viewFailure.isHidden = true
            lblTotalData.text = strTotal
            lblMerchantNameData.text = strMerchantName
            lblDateTimeData.text = strDateTime
            lblTransactionIDData.text = strTransID
            if strUserID.count == 0 {
                lblUserIDData.text = "."
            } else {
                lblUserIDData.text = strUserID
            }
            
            lblRebateData.text = strRebate
            
        }
    }
    
    
   func addCustomBackButton() {
        let btnLeftMenu: UIButton = UIButton()
        let image = UIImage(named: "BackNav");
        btnLeftMenu.setImage(image, for: .normal)
        btnLeftMenu.setTitle("", for: .normal);
        btnLeftMenu.sizeToFit()
        btnLeftMenu.addTarget(self, action: #selector (backButtonsClick(sender:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
    }

    @objc func backButtonsClick(sender : UIButton) {
     let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC

       let customViewControllersArray : NSArray = [newViewController]
       self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
         self.navigationController?.popToRootViewController(animated: true)
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
