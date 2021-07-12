//
//  WithdrawalVC.swift
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

class WithdrawalVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var lblAcc: UILabel!
    @IBOutlet weak var lblWithDraw: UILabel!
    @IBOutlet weak var lblWithdrawWallet: UILabel!
    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblThree: UILabel!
    @IBOutlet weak var lblThreeReq: UILabel!
    // Changes By Praveen
    @IBOutlet weak var lblMyDRSWalletName: UILabel!
    
    @IBOutlet weak var viewTC3: UIView!
    @IBOutlet weak var viewTC2: UIView!
    let sharedDefault = SharedDefault()
    
    @IBOutlet var lblBankName: UILabel!
    @IBOutlet var lblMinAmount: UILabel!
     @IBOutlet var lblProcessingCharge: UILabel!
    var strMinWithdrawal: String = "Minimum withdrawal amount of "
    var strMinWithdrawal2: String = "Minimum withdrawal amount is "

     var strProcessingCharge: String = ""
    
    var withdrawalModel: WithdrawalModel?
     var withdrawPageLoadModel: WithdrawPageLoadModel?
 var withDrawType =  String()
    var strTitle =  String()
    @IBOutlet var lblAmtData: UILabel!
    @IBOutlet var txtAmount: UITextField!
    var btnBankStatus:Bool = false
    var btnWalletStatus:Bool = false
    
    @IBOutlet var btnWallet: UIButton!
    @IBOutlet var btnBank: UIButton!
    
    @IBOutlet weak var viewWallet: UIView!
    @IBOutlet weak var viewBank: UIView!
    @IBOutlet weak var viewAmount: UIView!
    @IBOutlet var viewRadioWallet: UIView!
    @IBOutlet var viewRadioBank: UIView!
    @IBOutlet var btnWHistory: UIButton!
    @IBOutlet var btnConfirmWithdraw: UIButton!
    var messageEng = [String]()
    var messageBur = [String]()
    var withdrawSuccess:String = ""
    var withdrawFail:String = ""
    
    func getMessages() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 0
        {
           let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
           do {
               var text = try String(contentsOfFile: path!)
               
               let xml = try! XML.parse(text)
               messageEng.removeAll()
               if let text = xml.resource.user_invalid_access_withdrawal.text {
                   messageEng.append(text)
                   print(text)
               }
               if let text = xml.resource.user_withdrawal_req_submit.text {
                   messageEng.append(text)
                   print(text)
                withdrawSuccess = text
               }
               if let text = xml.resource.user_ref_failed_amt_more_bal.text {
                   messageEng.append(text)
                   print(text)
                withdrawFail  = text
               }
               if let text = xml.resource.user_amount_required_withdrawal.text {
                   messageEng.append(text)
                   print(text)
               }
               if let text = xml.resource.user_withdrawal_required.text {
                   messageEng.append(text)
                   print(text)
               }
               
           }
        
           catch(_){print("error")}
        }
        else if sharedDefault.getLanguage() == 1
        {
           let path1 = Bundle.main.path(forResource: "MessageBur", ofType: "xml") // file path for file "data.txt"
           do {
               var text = try String(contentsOfFile: path1!)
               
               let xml = try! XML.parse(text)
               messageBur.removeAll()
               if let text = xml.resource.user_invalid_access_withdrawal.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_withdrawal_req_submit.text {
                   messageBur.append(text)
                   print(text)
                withdrawSuccess = text
               }
               if let text = xml.resource.user_ref_failed_amt_more_bal.text {
                   messageBur.append(text)
                   print(text)
                withdrawFail  = text
               }
               if let text = xml.resource.user_amount_required_withdrawal.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_withdrawal_required.text {
                   messageBur.append(text)
                   print(text)
               }
               
           }
           catch(_){print("error")}
        }
           print("messageEng ----->",messageEng)
           print("messageBur ----->",messageBur)
           
       }
    
    @IBAction func btnBankAction(_ sender: UIButton) {
        if btnBankStatus == true {
            viewRadioBank.backgroundColor =  UIColor(red: 124.0/255.0, green: 143.0/255.0, blue: 169.0/255.0, alpha: 1.0)
            btnBankStatus = false
             withDrawType = ""
        } else {
            viewRadioBank.backgroundColor =  UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            btnBankStatus = true
             withDrawType = "bank"
        }
        viewRadioWallet.backgroundColor =   UIColor(red: 124.0/255.0, green: 143.0/255.0, blue: 169.0/255.0, alpha: 1.0)
        btnWalletStatus = false
       
    }
    
    @IBAction func btnWalletAction(_ sender: UIButton) {
        if btnWalletStatus == true {
            viewRadioWallet.backgroundColor =   UIColor(red: 124.0/255.0, green: 143.0/255.0, blue: 169.0/255.0, alpha: 1.0)
            btnWalletStatus = false
             withDrawType = ""
        } else {
            viewRadioWallet.backgroundColor =  UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            btnWalletStatus = true
             withDrawType = "wallet"
        }
        viewRadioBank.backgroundColor =   UIColor(red: 124.0/255.0, green: 143.0/255.0, blue: 169.0/255.0, alpha: 1.0)
         btnBankStatus = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
    self.title = strTitle
        self.addBackButton()
        
    }
    
    func changeLanguage() {
          let sharedDefault = SharedDefault()
          if sharedDefault.getLanguage() == 1 {
              print("changeLanguage")
              
              let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
              do {
                  var text = try String(contentsOfFile: path!)
                  //print("text",text)
                  let xml = try! XML.parse(text)
               
                  if let text = xml.resource.Withdrawal.text {
                      strTitle = text
                      self.title = strTitle
                  }
                  if let text = xml.resource.Withdrawal_Acc_Bal.text {
                      self.lblAcc.text = text
                  }
                  if let text = xml.resource.Withdrawal_Enter_amount.text {
                      self.txtAmount.placeholder = text
                  }
                  if let text = xml.resource.Withdrawal_Withdraw_to_link_bank.text {
                      self.lblWithDraw.text = text
                  }
                if let text = xml.resource.Withdrawal_withdraw_wallet.text {
                    self.lblWithdrawWallet.text = text
                }
                
                
                
                  if let text = xml.resource.Withdrawal_CONFIRM.text {
                      btnConfirmWithdraw.setTitle(text, for: .normal)
                  }
                  if let text = xml.resource.Withdrawal_WITHDRAWAL_HISTORY.text {
                       //print("text",text)
                      btnWHistory.setTitle(text, for: .normal)
                      let attributedString = NSMutableAttributedString(string: text)
                      
                      attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attributedString.length))
                      btnWHistory.titleLabel?.attributedText = attributedString
                      
                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions.text {
                      self.lblTerms.text = text
                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions1.text {
                      self.lblOne.text = text
                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions11.text {
                      //self.lblMinAmount.text = text
                      strMinWithdrawal = text + " "
                    
                    strMinWithdrawal2 = text + ""
                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions2.text {
                      self.lblTwo.text = text
                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions22.text {
                      //self.lblTwoData.text = text
                    strProcessingCharge = text
                  }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions3.text {
                    self.lblThree.text = text
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions33.text {
                    //self.lblTwoData.text = text
                    lblThreeReq.text = text
                }
                if let text = xml.resource.Withdrawal_To_Wallet.text
                {
                    self.lblMyDRSWalletName.text = text
                }
                  
              }
              catch(_){print("error")}
          }
          else if sharedDefault.getLanguage() == 0 {
              var strHead:String = ""
              
              let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
              do {
                  var text = try String(contentsOfFile: path!)
                  //print("text",text)
                  let xml = try! XML.parse(text)
                  
                  
                  if let text = xml.resource.Withdrawal.text {
                      strTitle = text
                      self.title = strTitle
                  }
                  if let text = xml.resource.Withdrawal_Acc_Bal.text {
                      self.lblAcc.text = text
                  }
                  if let text = xml.resource.Withdrawal_Enter_amount.text {
                      self.txtAmount.placeholder = text
                  }
                  if let text = xml.resource.Withdrawal_Withdraw_to_link_bank.text {
                      //self.lbllink.text = text
                  }
                  if let text = xml.resource.Withdrawal_CONFIRM.text {
                      btnConfirmWithdraw.setTitle(text, for: .normal)
                  }
                  if let text = xml.resource.Withdrawal_WITHDRAWAL_HISTORY.text {
                     //print("text",text)
                      let attributedString = NSMutableAttributedString(string: text)
                      
                      attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attributedString.length))
                      btnWHistory.titleLabel?.attributedText = attributedString
                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions.text {
                      //self.lblTerm.text = text
                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions1.text {
                      self.lblOne.text = text
                  }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions22.text {
                    //self.lblTwoData.text = text
                  strProcessingCharge = text
                }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions11.text {
                      //self.lblMinAmount.text = text
                      strMinWithdrawal = text + " "
                    strMinWithdrawal2 = text + ""

                  }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions2.text {
                      self.lblTwo.text = text
                  }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions33.text {
                    //self.lblTwoData.text = text
                    lblThreeReq.text = text
                }
                  if let text = xml.resource.Withdrawal_Terms_and_Conditions22.text {
                      //self.lblTwoData.text = text
                  }
                if let text = xml.resource.Withdrawal_To_Wallet.text
                {
                    self.lblMyDRSWalletName.text = text
                }
                 
              }
              catch(_){print("error")}
              
              
          }
          
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        txtAmount.delegate = self
        
        viewWallet.layer.cornerRadius = 10
        viewBank.layer.cornerRadius = 10
        viewAmount.layer.cornerRadius = 10
        
        
        btnConfirmWithdraw.layer.cornerRadius = btnConfirmWithdraw.frame.size.height/2
        viewRadioWallet.layer.cornerRadius = viewRadioWallet.frame.size.height/2
        viewRadioBank.layer.cornerRadius = viewRadioBank.frame.size.height/2
        let attributedString = NSMutableAttributedString(string: "WITHDRAWAL HISTORY")
        
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attributedString.length))
        btnWHistory.titleLabel?.attributedText = attributedString
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtAmount.inputAccessoryView = numberToolbar
        
        self.withdrawPageLoad()
        
        
        self.changeLanguage()
        self.getMessages()
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtAmount.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtAmount.resignFirstResponder()
    }
    @objc func dismissKeyboard()
       {
           txtAmount.resignFirstResponder()
       }
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
          print("textFieldShouldReturn")
          textField.resignFirstResponder()
          return true
      }
    @IBAction func btnConfirmWithdrawAction(_ sender: UIButton)
    {
        if txtAmount.text!.count > 0
        {
            let minValue = (self.withdrawPageLoadModel!.withdrawPageLoadModeldata?.minTopupAmount)!
            let enterValue = Int(txtAmount.text!)!
            if minValue > enterValue
            {
                
                strMinWithdrawal = ""
                strMinWithdrawal = strMinWithdrawal2 + String(minValue)
                
                self.showToast(message: strMinWithdrawal )
                return
            }
        }
        if txtAmount.text!.count <= 0
        {
            if sharedDefault.getLanguage() == 0
            {
                self.showToast(message: "Enter withdrawal amount")
            } else if sharedDefault.getLanguage() == 1 {
                self.showToast(message: "ထုတ်ယူငွေပမာဏကိုရိုက်ထည့်ပါ")
            }
            
        }
        
        else {
            if btnWalletStatus == true
            {
                
               
                if Reachability.isConnectedToNetwork()
                {
                    self.withdrawRequest()
                }
                else
                {
                    showToast(message: Constants.APP_NO_NETWORK)
                }
                
                
            }
            
            else if  btnBankStatus == true
                {
                    
                    if lblBankName.text!.count > 0
                    {
                    
                    if Reachability.isConnectedToNetwork()
                    {
                        self.withdrawRequest()
                    }
                    else
                    {
                        showToast(message: Constants.APP_NO_NETWORK)
                    }
                    }
                    else
                    {
                        if sharedDefault.getLanguage() == 0
                        {
                            self.showToast(message: "Bank name is empty")
                        } else if sharedDefault.getLanguage() == 1 {
                            self.showToast(message: "ဘဏ်နာမည်အလွတ်")
                        }
                        
                    }
                    
                }
            
            else
            {
                  
                if sharedDefault.getLanguage() == 0
                {
                    self.showToast(message: "Select withdrawal type")
                } else if sharedDefault.getLanguage() == 1
                {
                    self.showToast(message: "ထုတ်ယူခြင်းအမျိုးအစားကိုရွေးချယ်ပါ")
                }
            }
        }
        
        
    }
    @IBAction func btnWHistoryAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalHistoryVC") as! WithdrawalHistoryVC
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    func withdrawRequest() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
     postDict = ["access_token":sharedData.getAccessToken(),
                 "amount":txtAmount.text!,
                 "withdraw_type":withDrawType
                    
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.WithdrawPaymentURL
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
                    self.withdrawalModel = WithdrawalModel(response)
                    print("self.withdrawalModel ",self.withdrawalModel!)
                    print("self.withdrawalModel ",self.withdrawalModel?.httpcode!)
                  
                
                    let statusCode = Int((self.withdrawalModel?.httpcode)!)
                    if statusCode == 200{
                      //let a:Double = (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!
                      //self.lblAmtData.text =  (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!
             
                        /**var strTransID = String()
                        var strDateTime = String()
                        var strAmount = String()*/
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                           let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalDetailVC") as! WithdrawalDetailVC
                            next.strTransID = (self.withdrawalModel?.withdrawalModeldata?.referalWithdrawalData?.transactionId)!
                             next.strDateTime = (self.withdrawalModel?.withdrawalModeldata?.referalWithdrawalData?.dateTime)!
                             next.strAmount = (self.withdrawalModel?.withdrawalModeldata?.referalWithdrawalData?.amount)!
                            if let range3 = (self.withdrawalModel?.message)!!.range(of: "Failed", options: .caseInsensitive)
                            {
                                next.strFail = self.withdrawFail
                                print("(self.withdrawalModel?.message)!",(self.withdrawalModel?.message)!)
                            }
                            else
                            {
                                next.strFail = ""
                            }
                            
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.withdrawPageLoadModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            
                        } else {
                            let sharedDefault = SharedDefault()
                            for index in 0..<self.messageEng.count {
                                if let range3 = (self.withdrawPageLoadModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
                                    if sharedDefault.getLanguage() == 0 {
                                        self.showAlert(title: Constants.APP_NAME, message: self.messageEng[index])
                                    } else if sharedDefault.getLanguage() == 1 {
                                        self.showAlert(title: Constants.APP_NAME_BUR, message: self.messageBur[index])
                                    }
                                    
                                }
                            }
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
    
    func withdrawPageLoad() {
              let sharedData = SharedDefault()
              self.view.activityStartAnimating()
              var postDict = Dictionary<String,String>()
           postDict = ["access_token":sharedData.getAccessToken()
                          
              ]
              
              print("PostData: ",postDict)
              let loginURL = Constants.baseURL+Constants.WithdrawPageURL
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
                          self.withdrawPageLoadModel = WithdrawPageLoadModel(response)
                          print("self.withdrawPageLoadModel ",self.withdrawPageLoadModel!)
                          print("self.withdrawPageLoadModel ",self.withdrawPageLoadModel?.httpcode!)
                        
                        print("withdrawPageLoadModel",self.withdrawPageLoadModel!)
                          let statusCode = Int((self.withdrawPageLoadModel?.httpcode)!)
                          if statusCode == 200{
                            //let a:Double = (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!
//                            self.lblAmtData.text =  (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!
                            self.lblAmtData.text =  ((self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!) + " MMK"

                            
                            self.lblMinAmount.text =  self.strMinWithdrawal + String( (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.minTopupAmount!)!) + " MMK"
                            self.lblProcessingCharge .text = String( (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.processingFee!)!) + self.strProcessingCharge
                            
                            self.lblBankName.text = (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.drsBankDataWithdraw?.bankName!)!
                              DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                  let next = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                                
                                  //self.navigationController?.pushViewController(next, animated: true)
                              }
                              
                              
                          }
                        if statusCode == 400{
                            
                            
                            self.view.activityStopAnimating()
                            if let range3 = (self.withdrawPageLoadModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                
                            } else {
                                self.showAlert(title: Constants.APP_NAME, message: (self.withdrawPageLoadModel?.message)!)
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
