//
//  CreatePasswordVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/22/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class CreatePasswordVC: UIViewController,UITextFieldDelegate {
    var regSuccess: String = ""
    var regFail: String = ""
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var scrollPage: UIScrollView!
    @IBOutlet var btnCreatePwd: UIButton!
    @IBOutlet var lblCreatePwdHeader2: UILabel!
    @IBOutlet var lblCreatePwdHeader1: UILabel!
    
    @IBOutlet var txtPwd: UITextField!
    @IBOutlet var txtRePwd: UITextField!
    @IBOutlet var txtReferal: UITextField!
    var strTitle: String = ""
    var countryCode: String = String()
    var phoneNumber: String = String()
    var messageEng = [String]()
    var messageBur = [String]()
    
    var signUpModel: SignUpModel?
    func getMessages() {
       /*
         <!--  Sign Up -->
         <>Registration Successful.Please signin your account</user_reg_success_signup>
         <>The phone number field is required</user_ph_required_signup>
         <>The country code field is required</user_country_required_signup>
         <>The customer name field is required.</user_cust_name_required_signup>
         <>The password field is required</user_pass_required_signup>
         <>The password must be at least 6 characters</user_pass_must_6_char_signup>
         <>The phone number must be between 7 and 12 digits</user_ph_btween_7_12_signup>
         <>The referral id must be valid</user_ref_id_must_valid_signup>
         */
        let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            
            let xml = try! XML.parse(text)
            messageEng.removeAll()
            if let text = xml.resource.user_reg_success_signup.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_required_signup.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_country_required_signup.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_cust_name_required_signup.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_required_signup.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_must_6_char_signup.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_btween_7_12_signup.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ref_id_must_valid_signup.text {
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
            if let text = xml.resource.user_reg_success_signup.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_required_signup.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_country_required_signup.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_cust_name_required_signup.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_required_signup.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_must_6_char_signup.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_btween_7_12_signup.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_ref_id_must_valid_signup.text {
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
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                
                   if let text = xml.resource.forgot_password_create_pass_title.text {
                      strTitle = text
                       self.title = strTitle
                       
                   }
                   if let text = xml.resource.forgot_password_create_pass.text {
                    lblCreatePwdHeader1.text = text
                   }
                   if let text = xml.resource.forgot_password_create_pass_6_no_safe_ur_drs.text {
                      lblCreatePwdHeader2.text = text
                       
                   }
                   
                   if let text = xml.resource.forgot_password_enter_name.text {
                        txtName.placeholder = text
                       
                   }
                   
                   if let text = xml.resource.forgot_password_enter_pass.text {
                       
                       txtPwd.placeholder = text
                   }
                   
                   if let text = xml.resource.forgot_password_re_enter_pass.text {
                      txtRePwd.placeholder = text
                   }
                if let text = xml.resource.forgot_password_create_referral.text {
                   txtReferal.placeholder = text
                }
                if let text = xml.resource.forgot_password_enter.text {
                   btnCreatePwd.setTitle(text, for: .normal)
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
                
                if let text = xml.resource.forgot_password_create_pass_title.text {
                   strTitle = text
                    self.title = strTitle
                    
                }
                
                   if let text = xml.resource.forgot_password_create_pass.text {
                    lblCreatePwdHeader1.text = text
                   }
                   if let text = xml.resource.forgot_password_create_pass_6_no_safe_ur_drs.text {
                      lblCreatePwdHeader2.text = text
                       
                   }
                   
                   if let text = xml.resource.forgot_password_enter_name.text {
                        txtName.placeholder = text
                       
                   }
                   
                   if let text = xml.resource.forgot_password_enter_pass.text {
                       
                       txtPwd.placeholder = text
                   }
                   
                   if let text = xml.resource.forgot_password_re_enter_pass.text {
                      txtRePwd.placeholder = text
                   }
                if let text = xml.resource.forgot_password_create_referral.text {
                   txtReferal.placeholder = text
                }
                if let text = xml.resource.forgot_password_enter.text {
                   btnCreatePwd.setTitle(text, for: .normal)
                }
                
                
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        self.addBackButton()
        self.title = strTitle
        
        //lblCreatePwdHeader1.text = Constants.CreatePwdPageHead
        //lblCreatePwdHeader2.text = Constants.CreatePwdPageSubHead
        btnCreatePwd .setTitle(Constants.CreatePwdPageSubmit, for: .normal)
        //txtName.placeholder = Constants.CreatePwdName
        //txtPwd.placeholder = Constants.CreatePwdPagePassword
        //txtRePwd.placeholder = Constants.CreatePwdPageRePassword
        //txtReferal.placeholder =  Constants.CreatePwdPageReferal
        
        txtPwd.delegate = self
        txtRePwd.delegate = self
        txtReferal.delegate = self
        txtName.delegate = self
        
        txtPwd.backgroundColor = UIColor.white
        txtRePwd.backgroundColor = UIColor.white
        txtReferal.backgroundColor = UIColor.white
        btnCreatePwd.layer.cornerRadius = btnCreatePwd.frame.size.height/2
        txtPwd.layer.cornerRadius = 10
        txtRePwd.layer.cornerRadius = 10
        txtReferal.layer.cornerRadius = 10
        txtName.layer.cornerRadius = 10
        self.changeLanguage()
        self.getMessages()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollPage.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollPage.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollPage.contentInset = contentInset
    }
    
    @IBAction func btnCreatePwdAction(_ sender: Any)
    {
        // Changes by Praveen 
        var strPwdMsg = ""
        var strCPwdMsg = ""
        var strComparePwdMsg = ""
        var strName = ""

        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 0
        {
            strPwdMsg = "Enter your name"

           strPwdMsg = "Enter password"
            strCPwdMsg = "Enter confirm password"
            strComparePwdMsg = "Please make sure your passwords match"
            strName = "Enter your name"

        }
        else if sharedDefault.getLanguage() == 1
        {
            strPwdMsg = "စကားဝှက်ကိုရိုက်ထည့်ပါ"
            strCPwdMsg = "အတည်ပြု password ကိုရိုက်ထည့်ပါ"
            strComparePwdMsg = "ကျေးဇူးပြု၍ သင်၏စကားဝှက်ကိုအသေအချာစစ်ဆေးပါ"
            strName = "သင့်နာမည်ထည့်ပါ"

            
        }
        
        if txtPwd.text!.count<=0
        {
            showToast(message: strPwdMsg)
        }
        else if txtRePwd.text!.count<=0
        {
            showToast(message: strCPwdMsg)
        }
        else if txtName.text!.count<=0
        {
            showToast(message: strName)

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
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":sharedData.getPhoneNumber() as! String,
                    "country_code":countryCode,
                    "customer_name":txtName.text!,
                    "password":txtPwd.text!,
                    "password_confirmation":txtRePwd.text!,
                    "referral_id":txtReferal.text!
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.signupURL
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
                    print("self.signUpModel ",self.signUpModel?.httpcode!)
                    print("self.signUpModel ",self.signUpModel?.signUpModelData)
                    let sharedDefault = SharedDefault()
                    let statusCode = Int((self.signUpModel?.httpcode)!)
                    if statusCode == 200
                    {
                        if sharedData.getLanguage() == 0
                        {
                            self.showToast(message: self.messageEng[0])
                        }
                        else if sharedData.getLanguage() == 1
                        {
                            self.showToast(message: self.messageBur[0])
                        }
                        
                        //sharedDefault.setPhoneNumber(loginStatus: self.txtPhone.text!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            next.srtName = self.txtName.text!
                            next.srtPhone = sharedData.getPhoneNumber()
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                    }
                    if statusCode == 400{
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
