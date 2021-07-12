//
//  PaymentDetailOTPVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser
class PaymentDetailOTPVC: UIViewController,UITextFieldDelegate{
     let sharedDefault = SharedDefault()
     var paymentModel: PaymentModel?
    var strTitle:String = ""
    var strShopName = String()
    var strMerchantID = String()
    var strPaymentPin = String()
    var strPaymentMode = String()
    var strAmt = String()
    var strUsedVP = String()
    var strProfitShare = String()
    var errorStatus = Bool()
    
    @IBOutlet weak var viewShopName: UIView!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblPageContentTitle: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblPageSubtitle: UILabel!
    
    @IBOutlet weak var viewTextfield: UIView!
    
    @IBOutlet weak var txtFirst: UITextField!
  /**
     <>Verify Merchant Pin</scan_code_done_title>
        <>Veriﬁcation codes</scan_code_verify_code>
        <>Please ask Merchant to Key In Payment Pin Code</scan_code_ask_merchant_key_in_payment_pin_code>
        <>DONE</scan_code_done>
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
            
            if let text = xml.resource.scan_code_done_title.text {
                strTitle = text
                self.title = strTitle
                 print("strTitle",text)
            }
            if let text = xml.resource.scan_code_verify_code.text {
                lblPageContentTitle.text = text
                 print("scan_code_verify_code",text)
            }
            if let text = xml.resource.scan_code_ask_merchant_key_in_payment_pin_code.text {
                lblPageSubtitle.text = text
                 print("scan_code_ask_merchant_key_in_payment_pin_code",text)
            }
            if let text = xml.resource.scan_code_done.text {
                btnDone.setTitle(text, for: .normal)
                 print("scan_code_done",text)
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
               
               if let text = xml.resource.scan_code_done_title.text {
                   strTitle = text
                   self.title = strTitle
               }
               if let text = xml.resource.scan_code_verify_code.text {
                   lblPageContentTitle.text = text
               }
               if let text = xml.resource.scan_code_ask_merchant_key_in_payment_pin_code.text {
                   lblPageSubtitle.text = text
               }
               if let text = xml.resource.scan_code_done.text {
                   btnDone.setTitle(text, for: .normal)
               }
               
               
           }
           catch(_){print("error")}
           
           
       }
       
   }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        //btnDone.setTitle(Constants.PaymentDetailsDone, for: .normal)
        //lblPageContentTitle.text = Constants.PaymentDetailsPageMainTitle
        //lblPageSubtitle.text = Constants.PaymentDetailsPageSubTitle
        
        self.title = strTitle
         self.addBackButton()
        //self.addCustomBackButton()
        self.changeLanguage()
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtFirst.inputAccessoryView = numberToolbar
        
        
        
    }
    @objc func cancelNumberPad() {
           //Cancel with number pad
        txtFirst.resignFirstResponder()
       }
       @objc func doneWithNumberPad() {
           //Done with number pad
        txtFirst.resignFirstResponder()
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        lblShopName.text = strShopName
        txtFirst.delegate = self
       
        
        viewTextfield.layer.cornerRadius = 10
        btnDone.layer.cornerRadius = btnDone.frame.size.height/2
        
        txtFirst.attributedPlaceholder = NSAttributedString(string: "--------", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
               tap.cancelsTouchesInView = false
               self.view.addGestureRecognizer(tap)
              
        
    }
    @objc func dismissKeyboard()
       {
           txtFirst.resignFirstResponder()
       }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtFirst {
            txtFirst.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtFirst {
            if txtFirst.text!.count<=0 {
                txtFirst.attributedPlaceholder = NSAttributedString(string: "-----", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
            }
        }
            
        
        
    }
    @IBAction func btnDoneAction(_ sender: Any) {
       // let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
        //    self.navigationController?.pushViewController(next, animated: true)
        if txtFirst.text?.count == 0
        {
            let sharedDefault = SharedDefault()
            if sharedDefault.getLanguage() == 1
            {
                self.showToast(message:"ငွေပေးချေမှု pin ကွက်လပ်လိုအပ်သည်")
            }
            else  if sharedDefault.getLanguage() == 0
            {
                self.showToast(message:"The payment pin field is required." )
            }
            
        }
        else
        {
            self.initiatePayment()

        }
    }
    
    func initiatePayment() {
           let sharedData = SharedDefault()
           self.view.activityStartAnimating()
           var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                       "merchant_id":strMerchantID,
                       "payment_pin":txtFirst.text!,
                       "amount":strAmt,
                       "payment_mode":strPaymentMode,
                       "used_vp":strUsedVP,
                       "profit_share":strProfitShare
           ]
           
           print("PostData: ",postDict)
           let loginURL = Constants.baseURL+Constants.PaymentURL
           print("loginURL",loginURL)
           
           AF.request(loginURL, method: .post, parameters: postDict, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
               print("Response:***:",data.description)
               
               switch (data.result) {
               case .failure(let error) :
                                   self.view.activityStopAnimating()
                   let sharedDefault = SharedDefault()
                   if error._code == NSURLErrorTimedOut {
                       if sharedDefault.getLanguage() == 1 {
                           self.showToast(message: Constants.ReqTimedOutBur)
                       }else if sharedDefault.getLanguage() == 0 {
                           self.showToast(message: Constants.ReqTimedOutEng)
                       }
                       
                   }
                   else if error._code == 4 {
                       if sharedDefault.getLanguage() == 1 {
                           self.showToast(message: Constants.IntServerErrorBur)
                       }else if sharedDefault.getLanguage() == 0 {
                           self.showToast(message: Constants.IntServerErrorEng)
                       }
                       //self.showToast(message: "Internal server error! Please try again!")
                   }

               case .success :
                   do {
                       
                       let response = JSON(data.data!)
                       self.paymentModel = PaymentModel(response)
                    print("self.paymentModel ",self.paymentModel!)
                    print("self.paymentModel ",(self.paymentModel?.httpcode!)!)
                    print("self.paymentModel ",(self.paymentModel?.message!)!)
                    print("self.paymentModel ",(self.paymentModel?.paymentModelData?.failedReason!)!)
                       let statusCode = Int((self.paymentModel?.httpcode)!)
                    if statusCode == 200{
                        
                        
                        //self.showToast(message: (self.paymentModel?.paymentModelData?.failedReason)!)
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
                        if (self.paymentModel?.paymentModelData?.failedReason)!.count != 0 {
                            next.errorStatus = true
                            next.errorHead = (self.paymentModel?.message)!
                            next.errorMessage = (self.paymentModel?.paymentModelData?.failedReason)!
                            next.walletErrorMessages = false

                        }
                        else {
                            next.errorStatus = false
                        }
                        print("self.message 22 ",(self.paymentModel?.message)!)
                         print("self.httpcode 22 ",(self.paymentModel?.httpcode)!)
                       print("self.status 22 ",(self.paymentModel?.status)!)
                        //print("self.errorStatus ",self.errorStatus)
                        //print("self.paymentModel ",(self.paymentModel?.paymentModelData?.failedReason)!.count)
                        //print("self.paymentModel ",(self.paymentModel?.paymentModelData?.transactionData?.rebate)!)
                        next.strTotal = (self.paymentModel?.paymentModelData?.transactionData?.amount)!
                        next.strMerchantName = (self.paymentModel?.paymentModelData?.transactionData?.merchantName)!
                        next.strDateTime = (self.paymentModel?.paymentModelData?.transactionData?.date)!
                        next.strTransID = (self.paymentModel?.paymentModelData?.transactionData?.tranId)!
                        next.strUserID = (self.paymentModel?.paymentModelData?.transactionData?.userId)!
                        next.strRebate = (self.paymentModel?.paymentModelData?.transactionData?.rebate)!
                        self.navigationController?.pushViewController(next, animated: true)
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                            //=se`lf.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        
                    }
                       if statusCode == 400{
                        
                        if let range3 = (self.paymentModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if sharedDefault.getLanguage() == 0 {
                                self.showToast(message:Constants.InvalidAccessEng )
                            }
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                let sharedDefault = SharedDefault()
                                sharedDefault .clearAccessToken()
                                sharedDefault .setLoginStatus(loginStatus: false)
                                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                let customViewControllersArray : NSArray = [newViewController]
                                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            
                        }
                        
                         if let range3 = (self.paymentModel?.message)!.range(of: "Payment Pin Code mismatch", options: .caseInsensitive)
                        {
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1
                            {
                                self.showAlert(title: Constants.APP_NAME, message: "ငွေပေးချေမှုကုဒ်မကိုက်ညီ")
                            }
                            else  if sharedDefault.getLanguage() == 0
                            {
                                
                                self.showAlert(title: Constants.APP_NAME, message: "Payment code mismatch")

                                
                            }
                            
                            
                           
                        }
                        
                        
                        
                        else
                        
                        {
                            self.showAlert(title: Constants.APP_NAME, message: (self.paymentModel?.message)!)
                        }
                        
                        
                       }
                       
                       self.view.activityStopAnimating()
                       
                   }
                   catch let err {
                       print("Error::",err.localizedDescription)
                   }
               }
           }
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
