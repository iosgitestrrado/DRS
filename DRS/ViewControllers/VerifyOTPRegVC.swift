//
//  VerifyOTPRegVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/22/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class VerifyOTPRegVC: UIViewController,UITextFieldDelegate {
    var countryCode = String()
    var srtPhone = String()
    var gameTimer: Timer?
    var time:Int = 59
    var timer: Timer?
    var strTitle:String = ""
    @IBOutlet weak var btnRegOTP: UIButton!
    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var btnChangePhone: UIButton!
    @IBOutlet var btnOTP: UIButton!
    @IBOutlet var viewTextField: UIView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var lblOTPHeader2: UILabel!
    @IBOutlet var lblOTPHeader1: UILabel!
    
    @IBOutlet var txtFirst: UITextField!
    @IBOutlet var txtSecond: UITextField!
    @IBOutlet var txtThird: UITextField!
    @IBOutlet var txtFourth: UITextField!
    @IBOutlet var txtFifth: UITextField!
    @IBOutlet var txtSixth: UITextField!
    
    @IBOutlet weak var lblTime: UILabel!
    var oTPVerification: OTPVerification?
    var resentOTPModel: ResentOTPModel?
    //ResentOTPModel
    
    var attributedString = NSMutableAttributedString(string:"")
    
    @IBOutlet weak var btnRegOtpAction: UIButton!
    var messageEng  = [String]()
      var messageBur = [String]()
      
    func getMessages() {
       
        let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            
            let xml = try! XML.parse(text)
            messageEng.removeAll()
         
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
        
        print("messageEng verifyreg otp ----->",messageEng)
        print("messageBur verifyreg otp ----->",messageBur)
        print("messageEng.count ----->",messageEng.count)
        print("messageBur.count ----->",messageBur.count)
        
    }
    func changeLanguage() {
        let attrs = [
                   NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                   NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
               
        let sharedDefault = SharedDefault()
        srtPhone = ""
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                //forgot_password_verify_code_sent_xxx
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.forgot_password_verify_code_otp_title.text {
                    strTitle = text
                    self.title = strTitle
                }
                
                if let text = xml.resource.forgot_password_verify_code_otp.text {
                    lblOTPHeader1.text = text
                }
                if let text = xml.resource.forgot_password_verify_code_sent_xxx.text {
                   let strOSName = sharedDefault.getPhoneNumber()
                   
                   srtPhone = text
                   lblOTPHeader2.text = srtPhone + strOSName.suffix(4)
                   
                    
                }
                
                if let text = xml.resource.forgot_password_next.text {
                    btnNext.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.forgot_password_send_again_otp.text {
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    attributedString.append(buttonTitleStr)
                    btnRegOTP.setAttributedTitle(attributedString, for: .normal)
                    
                    
                }
                if let text = xml.resource.forgot_password_change_ph_no.text {
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    
                    
                    attributedString = NSMutableAttributedString(string:"")
                    var btnChangePhoneTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    attributedString.append(btnChangePhoneTitleStr)
                    btnChangePhone.setAttributedTitle(attributedString, for: .normal)
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
                if let text = xml.resource.forgot_password_verify_code_otp_title.text {
                    strTitle = text
                    self.title = strTitle
                }
                
                if let text = xml.resource.forgot_password_verify_code_otp.text {
                    lblOTPHeader1.text = text
                }
                if let text = xml.resource.forgot_password_verify_code_sent_xxx.text {
                   let strOSName = sharedDefault.getPhoneNumber()
                   
                   srtPhone = text
                   lblOTPHeader2.text = srtPhone + strOSName.suffix(4)
                   
                    
                }
                
                if let text = xml.resource.forgot_password_next.text {
                    btnNext.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.forgot_password_send_again_otp.text {
                    btnOTP.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.forgot_password_change_ph_no.text {
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    
                    
                    attributedString = NSMutableAttributedString(string:"")
                    var btnChangePhoneTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    attributedString.append(btnChangePhoneTitleStr)
                    btnChangePhone.setAttributedTitle(attributedString, for: .normal)
                    
                }
                
                
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.addBackButton()
        self.title = strTitle
    }
    @objc func timerMethod()  {
        
        
        print("Timer fired!")
        if self.time<=0{
            timer!.invalidate()
            self.btnRegOTP.isSelected = false
            DispatchQueue.main.async {
                self.lblTime.text =  "(59)"
            }
            self.time = 59
        } else {
            self.time = self.time  - 1
            DispatchQueue.main.async {
                self.lblTime.text =  "(" + String(self.time) + ")"
            }
        }
        
    }
    @IBAction func btnRegOTPAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let sharedDefault = SharedDefault()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerMethod), userInfo: nil, repeats: true)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerMethod), userInfo: nil, repeats: true)
            self.resentOPTReg(phoneNumber:sharedDefault.getPhoneNumber() as! String ,coutryCode: countryCode)
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTimer.isHidden = true
        // Do any additional setup after loading the view.
        
        let sharedData = SharedDefault()
        
        let strOSName = sharedData.getPhoneNumber()
        
        
        //lblOTPHeader2.text = "A Verification code has been sent to XXXXXX" + strOSName.suffix(4)
        
        
        viewTextField.layer.cornerRadius = 10
        btnNext.layer.cornerRadius = btnNext.frame.size.height/2
       
        
        txtFirst.delegate = self
        
        txtFirst.attributedPlaceholder = NSAttributedString(string: "- - - - - - -", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerMethod), userInfo: nil, repeats: true)
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtFirst.inputAccessoryView = numberToolbar
        
        self.changeLanguage()
        self.getMessages()
        
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtFirst.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtFirst.resignFirstResponder()
    }
    @objc func dismissKeyboard()
    {
        // txtAmount.resignFirstResponder()
    }
    
    /*
     // Use this if you have a UITextField
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     // get the current text, or use an empty string if that failed
     let currentText = textField.text ?? ""
     
     // attempt to read the range they are trying to change, or exit if we can't
     guard let stringRange = Range(range, in: currentText) else { return false }
     
     // add their new text to the existing text
     let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
     // make sure the result is under 16 characters
     if textField == txtFirst {
     txtSecond.becomeFirstResponder()
     }
     else if textField == txtSecond {
     txtThird.becomeFirstResponder()
     }
     else if textField == txtThird {
     txtFourth.becomeFirstResponder()
     }
     else if textField == txtFourth {
     txtFifth.becomeFirstResponder()
     }
     else if textField == txtFifth {
     txtSixth.becomeFirstResponder()
     }
     else if textField == txtSixth {
     
     }
     
     
     return updatedText.count <= 1
     }
     
     // Use this if you have a UITextView
     func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     // get the current text, or use an empty string if that failed
     let currentText = textView.text ?? ""
     
     // attempt to read the range they are trying to change, or exit if we can't
     guard let stringRange = Range(range, in: currentText) else { return false }
     
     // add their new text to the existing text
     let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
     
     // make sure the result is under 16 characters
     return updatedText.count <= 1
     }
     */
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtFirst {
            txtFirst.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 1750)
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtFirst {
            if txtFirst.text!.count<=0 {
                txtFirst.attributedPlaceholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
            }
        }
        
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            let sharedDefault = SharedDefault()
            self.validatePhone(phoneNumber:sharedDefault.getPhoneNumber() as! String , OTP: txtFirst.text!,coutryCode: countryCode)
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
        /*
         */
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
        print("viewWillDisappear votp")
    }
    
    @IBAction func btnOTPAction(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork() {
            let sharedDefault = SharedDefault()
            self.resentOPTReg(phoneNumber:sharedDefault.getPhoneNumber() as! String ,coutryCode: countryCode)
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
        /*
         // self.perform(#selector(self.printTimer), with: nil, afterDelay: 1.0)
         var time:Int = 59
         let seconds = 0.0
         
         for _ in 0...59 {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
         self.lblTimer.text = "(" + String(time) + ")"
         print("(" + String(time) + ")","\n")
         time = time - 1
         sleep(1)
         }
         }
         time = 59
         */
    }
    @objc func printTimer() {
        var time:Int = 59
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            for _ in 0...59 {
                self.lblTimer.text = "(" + String(time) + ")"
                print(String(time),"\n")
                time = time - 1
            }
        }
    }
    @IBAction func btnChangePwdAction(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    func validatePhone(phoneNumber: String,OTP: String,coutryCode: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phoneNumber,
                    "otp":OTP,
                    "otp_type":"sign_up",
                    "country_code":coutryCode
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.validateOTPURL
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
                    self.oTPVerification = OTPVerification(response)
                    print("self.resentOTPModel ",self.oTPVerification!)
                    print("self.resentOTPModel ",self.oTPVerification?.httpcode!)
                    print("self.resentOTPModel ",self.oTPVerification?.oTPVerificationData)
                    let sharedDefault = SharedDefault()
                    let statusCode = Int((self.oTPVerification?.httpcode)!)
                    if statusCode == 200{
                        if sharedDefault.getLanguage() == 0 {
                            self.showToast(message: "OTP Verified Successully")
                        } else  if sharedDefault.getLanguage() == 1 {
                            self.showToast(message: "OTP အောင်မြင်စွာစစ်ဆေးပြီး")
                        }
                        
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "CreatePasswordVC") as! CreatePasswordVC
                            next.countryCode = coutryCode
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                    }
                    if statusCode == 400{
                        
                        if let range3 = (self.oTPVerification?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                           // self.showAlert(title: Constants.APP_NAME, message: (self.oTPVerification?.message)!)
                            let sharedDefault = SharedDefault()
                            for index in 0..<self.messageEng.count {
                                if let range3 = (self.oTPVerification?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
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
    func resentOPTReg(phoneNumber: String,coutryCode: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phoneNumber,
                    "otp_type":"sign_up",
                    "country_code":coutryCode
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.validateOTPURL
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
                    self.resentOTPModel = ResentOTPModel(response)
                    print("self.resentOTPModel ",self.resentOTPModel!)
                    print("self.resentOTPModel ",self.resentOTPModel?.httpcode!)
                    print("self.resentOTPModel ",self.resentOTPModel?.desentOTPModelData)
                    let sharedDefault = SharedDefault()
                    let statusCode = Int((self.resentOTPModel?.httpcode)!)
                    if statusCode == 200{
                        
                        
                        self.showToast(message: (self.resentOTPModel?.message)!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            
                        }
                    }
                    if statusCode == 400{
                        if let range3 = (self.resentOTPModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            //self.showAlert(title: Constants.APP_NAME, message: (self.resentOTPModel?.message)!)
                            let sharedDefault = SharedDefault()
                            for index in 0..<self.messageEng.count {
                                if let range3 = (self.resentOTPModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
                                    if sharedDefault.getLanguage() == 0 {
                                        self.showAlert(title: Constants.APP_NAME, message: self.messageEng[index])
                                    } else if sharedDefault.getLanguage() == 1 {
                                        self.showAlert(title: Constants.APP_NAME_BUR, message: self.messageBur[index])
                                    }
                                    
                                }
                            }
                        }
                        
                        //self.showAlert(title: Constants.APP_NAME, message: (self.validateMobileModelResponse?.message)!)
                    }
                    /*
                     if Int(self.loginResponse?.httpcode)   == 200 {
                     
                     sharedDefault .setLoginStatus(loginStatus: true)
                     
                     } else if Int(self.loginResponse?.httpcode)   == 400 {
                     sharedDefault .setLoginStatus(loginStatus: false)
                     }
                     */
                    
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
