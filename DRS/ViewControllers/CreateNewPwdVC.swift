//
//  CreateNewPwdVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/21/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class CreateNewPwdVC: UIViewController,UITextFieldDelegate  {
    
    //MARK: - IBOutlet
    @IBOutlet var btnCreatePwd: UIButton!
    @IBOutlet var lblCreatePwdHeader2: UILabel!
    @IBOutlet var lblCreatePwdHeader1: UILabel!
    @IBOutlet var txtPwd: UITextField!
    @IBOutlet var txtRePwd: UITextField!
    
    //MARK: - Variables
    var countryCode: String = String()
    var phoneNumber: String = String()
    var otpToken: String = String()
    var messageEng = [String]()
    var messageBur = [String]()
    var strTitle:String = ""
    let sharedDefault = SharedDefault()

    var signUpModel: SignUpModel?
    func getMessages() {
          /*
         <>Your password has been reset successfully.</user_pass_reset_success_reset_pwd>
         <>Invalid credientials</user_invalid_cred_reset_pwd>
         <>The phone number field is required.</user_ph_required_required_reset_pwd>
         <>The country code field is required.</user_country_required_reset_pwd>
         */
           let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
           do {
               var text = try String(contentsOfFile: path!)
               
               let xml = try! XML.parse(text)
               messageEng.removeAll()
               if let text = xml.resource.user_pass_reset_success_reset_pwd.text {
                   messageEng.append(text)
                   print(text)
               }
               if let text = xml.resource.user_invalid_cred_reset_pwd.text {
                   messageEng.append(text)
                   print(text)
               }
               if let text = xml.resource.user_ph_required_required_reset_pwd.text {
                   messageEng.append(text)
                   print(text)
               }
               if let text = xml.resource.user_country_required_reset_pwd.text {
                   messageEng.append(text)
                   print(text)
               }
            if let text = xml.resource.user_OTP_sent_ph_no_reset_otp_title.text {
                       messageEng.append(text)
                       print(text)
                   }
                     if let text = xml.resource.user_otp_verified_success_otp.text {
                         messageEng.append(text)
                         print(text)
                     }
                     if let text = xml.resource.user_otp_enter_incorrect_otp.text {
                         messageEng.append(text)
                         print(text)
                     }
                     if let text = xml.resource.user_otp_required_otp.text {
                         messageEng.append(text)
                         print(text)
                     }
                     if let text = xml.resource.user_country_required_otp.text {
                         messageEng.append(text)
                         print(text)
                     }
                     if let text = xml.resource.user_ph_required_otp.text {
                         messageEng.append(text)
                         print(text)
                     }
                   if let text = xml.resource.user_ph_btween_7_13_otp.text {
                       messageEng.append(text)
                       print(text)
                   }
                   if let text = xml.resource.user_ph_must_no_otp.text {
                       messageEng.append(text)
                       print(text)
                   }
                   if let text = xml.resource.user_cannot_find_user_otp.text {
                       messageEng.append(text)
                       print(text)
                   }
                   if let text = xml.resource.user_otp_number.text {
                              messageEng.append(text)
                              print(text)
                          }
               
               
           }
           catch(_){print("error")}
           let path1 = Bundle.main.path(forResource: "MessageBur", ofType: "xml") // file path for file "data.txt"
           do {
               var text = try String(contentsOfFile: path1!)
               
               let xml = try! XML.parse(text)
               messageBur.removeAll()
               if let text = xml.resource.user_pass_reset_success_reset_pwd.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_invalid_cred_reset_pwd.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_ph_required_required_reset_pwd.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_country_required_reset_pwd.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_OTP_sent_ph_no_reset_otp_title.text {
                          messageBur.append(text)
                          print(text)
                      }
                        if let text = xml.resource.user_otp_verified_success_otp.text {
                            messageBur.append(text)
                            print(text)
                        }
                        if let text = xml.resource.user_otp_enter_incorrect_otp.text {
                            messageBur.append(text)
                            print(text)
                        }
                        if let text = xml.resource.user_otp_required_otp.text {
                            messageBur.append(text)
                            print(text)
                        }
                        if let text = xml.resource.user_country_required_otp.text {
                            messageBur.append(text)
                            print(text)
                        }
                        if let text = xml.resource.user_ph_required_otp.text {
                            messageBur.append(text)
                            print(text)
                        }
                      if let text = xml.resource.user_ph_btween_7_13_otp.text {
                          messageBur.append(text)
                          print(text)
                      }
                      if let text = xml.resource.user_ph_must_no_otp.text {
                          messageBur.append(text)
                          print(text)
                      }
                      if let text = xml.resource.user_cannot_find_user_otp.text {
                          messageBur.append(text)
                          print(text)
                      }
                      if let text = xml.resource.user_otp_number.text {
                          messageBur.append(text)
                          print(text)
                      }
                      
               
           }
           catch(_){print("error")}
           
           print("messageEng ----->",messageEng)
           print("messageBur ----->",messageBur)
           
       }
    func changeLanguage() {
               
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                //forgot_password_verify_code_sent_xxx
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.forgot_password_create_pass.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.forgot_password_create_pass.text {
                    lblCreatePwdHeader1.text = text
                }
                if let text = xml.resource.forgot_password_enter_pass.text {
                    lblCreatePwdHeader2.text = text
                }
                if let text = xml.resource.forgot_password_enter.text {
                    btnCreatePwd.setTitle(text, for: .normal)

                }
                if let text = xml.resource.forgot_password_enter_pass.text {
                    txtPwd.placeholder = text
                }
                if let text = xml.resource.forgot_password_re_enter_pass.text {
                    txtRePwd.placeholder = text
                }
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                //forgot_password_verify_code_sent_xxx
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.forgot_password_create_pass.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.forgot_password_create_pass.text {
                    lblCreatePwdHeader1.text = text
                }
                if let text = xml.resource.forgot_password_enter_pass.text {
                    lblCreatePwdHeader2.text = text
                }
                if let text = xml.resource.forgot_password_enter.text {
                    btnCreatePwd.setTitle(text, for: .normal)

                    
                }
                
                if let text = xml.resource.forgot_password_enter_pass.text {
                    txtPwd.placeholder = text
                }
                if let text = xml.resource.forgot_password_re_enter_pass.text {
                    txtRePwd.placeholder = text
                }
                // txtPwd.placeholder = Constants.CreatePwdPagePassword
                // txtRePwd.placeholder = Constants.CreatePwdPageRePassword
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.addBackButton()
        self.title = strTitle
        //lblCreatePwdHeader1.text = Constants.CreatePwdPageHead
        //lblCreatePwdHeader2.text = Constants.CreatePwdPageSubHeadReg
       // btnCreatePwd .setTitle(Constants.CreatePwdPageSubmit, for: .normal)
       // txtPwd.placeholder = Constants.CreatePwdPagePassword
       // txtRePwd.placeholder = Constants.CreatePwdPageRePassword
        
        txtPwd.delegate = self
        txtRePwd.delegate = self
        txtPwd.backgroundColor = UIColor.white
        txtRePwd.backgroundColor = UIColor.white
        btnCreatePwd.layer.cornerRadius = btnCreatePwd.frame.size.height/2
        txtPwd.layer.cornerRadius = 10
        txtRePwd.layer.cornerRadius = 10
        
        self.changeLanguage()
        self.getMessages()
        let sharedDefault = SharedDefault()

        
        if sharedDefault.getLanguage() == 1
        {
            btnCreatePwd.setTitle("နိပ်ပါ", for: .normal)

        }
        else
        {
            btnCreatePwd.setTitle("ENTER", for: .normal)

        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        //  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @IBAction func btnCreatePwdAction(_ sender: Any) {
        var strPwdMsg = ""
        var strCPwdMsg = ""
        var strComparePwdMsg = ""

        let sharedDefault = SharedDefault()
        if sharedDefault.getLanguage() == 0
        {
           strPwdMsg = "Enter password"
            strCPwdMsg = "Enter confirm password"
            strComparePwdMsg = "Please make sure your passwords match"
        }
        else if sharedDefault.getLanguage() == 1
        {
            strPwdMsg = "စကားဝှက်ကိုရိုက်ထည့်ပါ"
            strCPwdMsg = "အတည်ပြု password ကိုရိုက်ထည့်ပါ"
            strComparePwdMsg = "ကျေးဇူးပြု၍ သင်၏စကားဝှက်ကိုအသေအချာစစ်ဆေးပါ"
            
        }
        
        if txtPwd.text!.count<=0
        {
            showToast(message: strPwdMsg)
        }
        else if txtRePwd.text!.count<=0
        {
            showToast(message: strCPwdMsg)
        }
        else
        {
            if txtPwd.text! != txtRePwd.text!
            {
                showToast(message: strComparePwdMsg)
                return
            }
            else
            {
            if Reachability.isConnectedToNetwork()
            {
                self.createPassword()
            }
            else
            {
                showToast(message: Constants.APP_NO_NETWORK)
            }
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 1750)
        textField.resignFirstResponder()
        return true
    }
    func createPassword() {
        
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phoneNumber,
                    "country_code":countryCode,
                    "password":txtPwd.text!,
                    "otp_token":otpToken]
        
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.resetPwdURL
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
                    //7012279214
                    
                    let response = JSON(data.data!)
                    self.signUpModel = SignUpModel(response)
                    print("self.signUpModel ",self.signUpModel!)
                    print("self.signUpModel ",(self.signUpModel?.httpcode)!)
                    print("self.signUpModel ",(self.signUpModel?.signUpModelData)!)
                    
                    let statusCode = Int((self.signUpModel?.httpcode)!)
                    if statusCode == 200
                    {
                        
                        var strPwdMsg = ""

                        let sharedDefault = SharedDefault()
                        if sharedDefault.getLanguage() == 0
                        {
                           strPwdMsg = "Password has been set successfully"
                          
                        }
                        else if sharedDefault.getLanguage() == 1
                        {
                            strPwdMsg = "စကားဝှက်ကိုအောင်မြင်စွာသတ်မှတ်ပြီးဖြစ်သည်"
                           
                            
                        }
                        
                        self.showToast(message:strPwdMsg)

                        
//                        self.showToast(message: (self.signUpModel?.message)!)
                        //sharedDefault.setPhoneNumber(loginStatus: self.txtPhone.text!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                        {
                            
//                            self.navigationController?.popToRootViewController(animated: true)
                            
                            
//                                self.view.activityStopAnimating()
                                let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                              next.srtName = (self.signUpModel?.signUpModelData?.customer_name)!
                                 next.srtPhone = self.countryCode + " " +  self.phoneNumber
                                self.navigationController?.pushViewController(next, animated: true)
                            self.sharedDefault.setDialCode(dialCode: self.countryCode)
                            self.sharedDefault.setPhoneNumber(loginStatus: self.phoneNumber)
                            
                        
                            
                            
                        }
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.signUpModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                if let range3 = (self.signUpModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
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
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
