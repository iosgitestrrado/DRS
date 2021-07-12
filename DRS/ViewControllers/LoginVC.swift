//
//  LoginVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/22/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class LoginVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var btnChangePhoneNum: UIButton!
    let sharedDefault = SharedDefault()
    var srtPhone = String ()
    var srtName = String ()
    var signModel: SignModel?
    @IBOutlet var lblWelcome: UILabel!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var btnSignin: UIButton!
    @IBOutlet var btnForgotPwd: UIButton!
    var attributedString = NSMutableAttributedString(string:"")
     var attributedStr = NSMutableAttributedString(string:"")
    @IBOutlet var txtPassword: UITextField!
    
    var messageEng = [String]()//Eng
    var messageBur = [String]()//Bur
    
    func getMessages() {
       /*
         <>Login successfull</user_login_success_signin>
         <>Your account not activated yet.Please contact admin for activation</user_ur_acc_not_active_signin>
         <>Invalid credientials</user_invalid_cred_signin>
         <>The country code field is required</user_country_required_signin>
         <>The password field is required</user_pass_required_signin>
         <>The phone number field is required</user_ph_required_signin>
         <>The password must be at least 6 characters</user_pass_must_6_char_signin>
         */
        let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            
            let xml = try! XML.parse(text)
            messageEng.removeAll()
            if let text = xml.resource.user_login_success_signin.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ur_acc_not_active_signin.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_invalid_cred_signin.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_country_required_signin.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_required_signin.text {
                messageEng.append(text)
                print(text)
            }
            
            if let text = xml.resource.user_ph_required_signin.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_must_6_char_signin.text {
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
            if let text = xml.resource.user_login_success_signin.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_ur_acc_not_active_signin.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_invalid_cred_signin.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_country_required_signin.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_required_signin.text {
                messageEng.append(text)
                print(text)
            }
            
            if let text = xml.resource.user_ph_required_signin.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_must_6_char_signin.text {
                messageBur.append(text)
                print(text)
            }
            
        }
        catch(_){print("error")}
        
        print("messageEng ----->",messageEng)
        print("messageBur ----->",messageBur)
        
    }
   // cust_login_welcome
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.cust_login_welcome.text {
                    lblWelcome.text  = text
                }
                if let text = xml.resource.cust_login_change_ph_no.text {
                     let attrs = [
                     NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                     NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStrc = NSMutableAttributedString(string:text, attributes:attrs)
                    attributedStr.append(buttonTitleStrc)
                    btnChangePhoneNum.setAttributedTitle(attributedStr, for: .normal)
                    
                }
                if let text = xml.resource.cust_login_sign_in.text {
                     btnSignin.setTitle(text, for: .normal)
                }
                if let text = xml.resource.forgot_password_enter_pass.text {
                     btnSignin.setTitle(text, for: .normal)
                }
                if let text = xml.resource.cust_login_enter_pass.text {
                    txtPassword.placeholder = text
                }
                if let text = xml.resource.cust_login_forgot_password.text {
                     let attrs1 = [
                     NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                     NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStrc = NSMutableAttributedString(string:text, attributes:attrs1)
                    attributedStr = NSMutableAttributedString(string:"")
                    attributedStr.append(buttonTitleStrc)
                    btnForgotPwd.setAttributedTitle(attributedStr, for: .normal)
                    
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
                
                if let text = xml.resource.cust_login_welcome.text {
                    lblWelcome.text  = text
                }
                if let text = xml.resource.cust_login_change_ph_no.text {
                     let attrs = [
                     NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                     NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStrc = NSMutableAttributedString(string:text, attributes:attrs)
                    attributedStr.append(buttonTitleStrc)
                    btnChangePhoneNum.setAttributedTitle(attributedStr, for: .normal)
                    
                }
                if let text = xml.resource.cust_login_enter_pass.text {
                    txtPassword.placeholder = text
                }
                if let text = xml.resource.cust_login_forgot_password.text {
                     let attrs1 = [
                     NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                     NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStrc = NSMutableAttributedString(string:text, attributes:attrs1)
                    attributedStr = NSMutableAttributedString(string:"")
                    attributedStr.append(buttonTitleStrc)
                    btnForgotPwd.setAttributedTitle(attributedStr, for: .normal)
                    
                }
            }
            catch(_){print("error")}
            
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtPassword.delegate = self
        //lblWelcome.text = Constants.LoginPageHead
        lblName.text = srtName
        lblPhone.text = srtPhone
        let attrs = [
            NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        
        var buttonTitleStr = NSMutableAttributedString(string:Constants.BtnForgotPwd, attributes:attrs)
        attributedString.append(buttonTitleStr)
        btnForgotPwd.setAttributedTitle(attributedString, for: .normal)
        
        //var buttonTitleStrc = NSMutableAttributedString(string:"Change Phone Number", attributes:attrs)
        //attributedStr.append(buttonTitleStrc)
        //btnChangePhoneNum.setAttributedTitle(attributedStr, for: .normal)
        
        //btnSignin .setTitle(Constants.LoginSignBtn, for: .normal)
        btnSignin.layer.cornerRadius = btnSignin.frame.size.height/2
        
        txtPassword.layer.cornerRadius = 10
        //txtPassword.placeholder =  Constants.TxtPwdPlaceholder
        txtPassword.backgroundColor = UIColor.white
        
        self.changeLanguage()
        self.getMessages()
        
    }
     // MARK: - Textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
     // MARK: - Button signin method
    @IBAction func btnSigninAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            if txtPassword.text!.count<=0
            {
                
                if self.sharedDefault.getLanguage() == 0
                {
                    self.showAlert(title: Constants.APP_NAME, message: Constants.LOGIN_VALIDATION_MSG)
                }
                else if self.sharedDefault.getLanguage() == 1
                {
                    self.showAlert(title: Constants.APP_NAME_BUR, message: "သုံးစွဲသူအမည်နှင့်စကားဝှက်ကိုအချည်းနှီးမထားနိုင်ပါ")
                }
                
                
            }
            else
            {
                self.signin()
            }
            
        } else
        {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
    }
    @IBAction func btnChangePhoneAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
     // MARK: - Forgot password method
    @IBAction func btnForgotPwdAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    // MARK: - Signin method
    func signin() {
        let sharedData = SharedDefault()
        var tokenStr = String()
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: "fcm_token"){
            print("savedValue fcm_token ----- ",savedValue)
           
            tokenStr = sharedDefault.getFcmToken()
        } else {
             sharedDefault.setFcmToken(token: sharedDefault.getNewFcmToken())
            tokenStr = sharedDefault.getNewFcmToken()
        }
        
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["country_code":sharedData.getDialCode() as String,
                    "phone_number":sharedData.getPhoneNumber() as! String,
                    "password":txtPassword.text!,
                    "device_token":tokenStr,
                    "os":"ios"
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.signinURL
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
                    self.signModel = SignModel(response)
                    print("self.signModel ",self.signModel!)
                    print("self.signModel ",self.signModel?.httpcode!)
                    print("self.signModel ",self.signModel?.signModelData?.accessToken!)
                    let sharedDefault = SharedDefault()
                    let statusCode = Int((self.signModel?.httpcode)!)
                    if statusCode == 200{
                        sharedDefault .setAccessToken(token: (self.signModel?.signModelData?.accessToken)!)
                        sharedDefault .setLoginStatus(loginStatus: true)
                        print("self.signModel ",sharedDefault.getLoginStatus())
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                             self.view.activityStopAnimating()
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        
                    }
                    if statusCode == 400{
                         self.view.activityStopAnimating()
                        if let range3 = (self.signModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                if let range3 = (self.signModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
                                    if sharedDefault.getLanguage() == 0 {
                                        self.showAlert(title: Constants.APP_NAME, message: self.messageEng[index])
                                    } else if sharedDefault.getLanguage() == 1 {
                                        self.showAlert(title: Constants.APP_NAME_BUR, message: self.messageBur[index])
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    
                   
                    
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
