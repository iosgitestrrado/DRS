//
//  ForgotVCViewController.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/21/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import ADCountryPicker
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class ForgotPasswordVC: UIViewController,UITextViewDelegate , ADCountryPickerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{
    var itemsImages = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsNames = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsCode = ["+95","+91", "+86" ,"+60"]
    var messageEng = [String]()
    var messageBur = [String]()
    var emptyMsg = String()
    var forgotPwdModel: ForgotPwdModel?
    let picker = ADCountryPicker()
    @IBOutlet var imgFlag: UIImageView!
    @IBOutlet var txtDialCode: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet weak var tableCountry: UITableView!
    
    @IBOutlet weak var viewForgotPwdCountryBg: UIView!
    @IBOutlet var txtTerms: UITextView!
    @IBOutlet var lblHeader2: UILabel!
    @IBOutlet var lblHeader1: UILabel!
    @IBOutlet var viewCountry: UIView!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var cb1: CheckBox!
    var strTitle:String = ""
    
    func getMessages() {
          
           let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
           do {
               var text = try String(contentsOfFile: path!)
               
            let xml = try! XML.parse(text)
            messageEng.removeAll()
            if let text = xml.resource.user_OTP_sent_ph_no_reset_otp.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_country_required_reset_otp.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_required_reset_otp.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_btween_7_13_reset_otp.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_must_no.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_must_no_reset_otp.text {
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
               if let text = xml.resource.user_OTP_sent_ph_no_reset_otp.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_country_required_reset_otp.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_ph_required_reset_otp.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_ph_btween_7_13_reset_otp.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_ph_must_no.text {
                   messageBur.append(text)
                   print(text)
               }
               if let text = xml.resource.user_ph_must_no_reset_otp.text {
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
                if messageBur.count>0 {
                    emptyMsg = messageBur[2]
                }
                
                if let text = xml.resource.cust_login_forgot_password.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.forgot_password_forgot_ur_pass.text {
                    lblHeader1.text = text
                }
                if let text = xml.resource.forgot_password_let_us_help_u.text {
                    lblHeader2.text = text
                    
                }
                
                if let text = xml.resource.forgot_password_enter.text {
                    btnSignup.setTitle(text, for: .normal)
                    btnSignup.titleLabel?.text = text

                }
                
                
                
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                
                let xml = try! XML.parse(text)
                if messageEng.count>0 {
                    emptyMsg = messageBur[2]
                }
                if let text = xml.resource.cust_login_forgot_password.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.forgot_password_forgot_ur_pass.text {
                    lblHeader1.text = text
                }
                if let text = xml.resource.forgot_password_let_us_help_u.text {
                    lblHeader2.text = text
                    
                }
                
                if let text = xml.resource.forgot_password_enter.text {
                    btnSignup.setTitle(text, for: .normal)
                    print("forgot_password_enter",text)
                    btnSignup.titleLabel?.text = text

                }
                
                
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return itemsImages.count
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableCountry {
            let cellBal = tableCountry.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
            cellBal.backgroundColor = UIColor.white
            
            cellBal.selectionStyle = .none
            cellBal.imageView?.image = UIImage(named: itemsImages[indexPath.row])
            cellBal.viewImg.layer.cornerRadius =  (cellBal.viewImg?.frame.size.height)!/2
            cellBal.imageView?.layer.cornerRadius = (cellBal.imageView?.frame.size.height)!/2
            cellBal.viewImg.clipsToBounds = true
            //promotionCell.imgviewCollection.sd_setImage(with: URL(string: self.promotionArray[indexPath.row].image!), placeholderImage: nil)
            
            cellBal.lblDialCode.text = itemsCode[indexPath.row]
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableNotification ",indexPath.row)
        print("tableNotification section ",indexPath.section)
        txtDialCode.text = itemsCode[indexPath.row]
        imgFlag.image = UIImage(named: itemsImages[indexPath.row])
        viewForgotPwdCountryBg.isHidden = true
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.addBackButton()
        self.title = strTitle
        
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 0
        {
            btnSignup.setTitle("ENTER", for: .normal)

          

        }
        else if sharedDefault.getLanguage() == 1
        {
            btnSignup.setTitle("နိပ်ပါ", for: .normal)


            
        }
        self.getMessages()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtDialCode.text = itemsCode[0]
        imgFlag.image = UIImage(named: itemsImages[0])
        
        print("viewDidLoad ViewController")
        tableCountry.delegate = self
        tableCountry.dataSource = self
        
        txtPhone.delegate = self
        viewCountry.layer.cornerRadius = 10
        btnSignup.layer.cornerRadius = btnSignup.frame.size.height/2
        cb1.style = .tick
        cb1.borderStyle = .roundedSquare(radius: 3)
        cb1.addTarget(self, action: #selector(onCheckBoxValueChange(_:)), for: .valueChanged)
        
        //  let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let font = UIFont.systemFont(ofSize: 16)
        let attributedString = NSMutableAttributedString(string: "I have read and agree Terms and Conditions, and Agreement.")
        
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 22, length: 21))
        
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 48, length: 9))
        attributedString.addAttribute(.link, value: "https://www.ibm.com", range: NSRange(location: 21, length: 21))
        attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 48, length: 9))
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: 57))
        
        txtTerms.isEditable = false
        txtTerms.delegate=self
        txtTerms.attributedText = attributedString
        //imgFlag.layer.cornerRadius =  imgFlag.frame.size.height/2
        
        
        // Do any additional setup after loading the view.
        picker.delegate = self
        
        /// Optionally, set this to display the country calling codes after the names
        picker.showCallingCodes = true
        
        /// Flag to indicate whether country flags should be shown on the picker. Defaults to true
        picker.showFlags = true
        
        /// The nav bar title to show on picker view
        picker.pickerTitle = "Select a Country"
        
        /// The default current location, if region cannot be determined. Defaults to US
        picker.defaultCountryCode = "US"
        
        /// Flag to indicate whether the defaultCountryCode should be used even if region can be deteremined. Defaults to false
        picker.forceDefaultCountryCode = false
        
        
        /// The text color of the alphabet scrollbar. Defaults to black
        picker.alphabetScrollBarTintColor = UIColor.black
        
        /// The background color of the alphabet scrollar. Default to clear color
        picker.alphabetScrollBarBackgroundColor = UIColor.clear
        
        /// The tint color of the close icon in presented pickers. Defaults to black
        picker.closeButtonTintColor = UIColor.black
        
        /// The font of the country name list
        picker.font = UIFont(name: "Helvetica Neue", size: 15)
        
        /// The height of the flags shown. Default to 40px
        picker.flagHeight = 30
        
        /// Flag to indicate if the navigation bar should be hidden when search becomes active. Defaults to true
        picker.hidesNavigationBarWhenPresentingSearch = true
        
        /// The background color of the searchbar. Defaults to lightGray
        picker.searchBarBackgroundColor = UIColor.lightGray
        
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtPhone.inputAccessoryView = numberToolbar

        self.changeLanguage()
        
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtPhone.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtPhone.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 1750)
        textField.resignFirstResponder()
        return true
    }
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String) {
        print(code)
        //let dialingCode =  picker.getDialCode(countryCode: code)
        if code != nil {
            txtDialCode.text = code
        }
        imgFlag.image = picker.getFlag(countryCode: code)
    }
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        print("dialCode ---",dialCode)
        print("code------",code)
        print("name----",name)
        
        
        // let countryName =  picker.getCountryName(countryCode: code)
        let dialingCode =  picker.getDialCode(countryCode: code)
        if dialingCode != nil {
            txtDialCode.text = dialingCode!
        }
        
        imgFlag.image = picker.getFlag(countryCode: code)
        if dialCode.count>0{
            txtDialCode.text = dialCode
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func onCheckBoxValueChange(_ sender: CheckBox) {
        
        print(sender.isChecked)
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("textView")
        if URL.absoluteString == "https://www.ibm.com" {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
            self.navigationController?.pushViewController(next, animated: true)
        } else if URL.absoluteString == "https://www.google.com" {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "AgreementVC") as! AgreementVC
            self.navigationController?.pushViewController(next, animated: true)
        }
        //UIApplication.shared.open(URL)
        return false
    }
    @IBAction func btnSelectCountryAction(_ sender: Any) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        viewForgotPwdCountryBg.isHidden = false
        
        txtPhone.resignFirstResponder()
        txtDialCode.resignFirstResponder()
    }
    @objc func dismissKeyboard()
    {
        txtPhone.resignFirstResponder()
        txtDialCode.resignFirstResponder()
        self.viewForgotPwdCountryBg.isHidden = true
    }
    @IBAction func btnSignupAction(_ sender: Any) {
        if txtDialCode.text!.count <= 0{
            self.showToast(message: "Select country")
        } else if txtPhone.text!.count <= 0{
            let sharedDefault = SharedDefault()
            
            if sharedDefault.getLanguage() == 0 {
                emptyMsg = messageEng[2]
            } else if sharedDefault.getLanguage() == 1 {
                emptyMsg = messageBur[2]
            }
            if messageBur.count>0 {
                
            }
            self.showToast(message: emptyMsg)
        }
        else {
            if Reachability.isConnectedToNetwork() {
                self.validatePhone(phoneNumber: txtPhone.text!)
            } else {
                showToast(message: Constants.APP_NO_NETWORK)
            }
        }
        
    }
    func validatePhone(phoneNumber: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phoneNumber,
                    "country_code":txtDialCode.text!
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.forgotPwdURL
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
                    self.forgotPwdModel = ForgotPwdModel(response)
                    print("self.validateMobileModelResponse ",self.forgotPwdModel!)
                    print("self.validateMobileModelResponse ",(self.forgotPwdModel?.httpcode)!)
                    print("self.validateMobileModelResponse ",(self.forgotPwdModel?.forgotPwdModelData)!)
                    
                    let statusCode = Int((self.forgotPwdModel?.httpcode)!)
                    if statusCode == 200{
                        //self.showToast(message: (self.forgotPwdModel?.message)!)
                         let sharedDefault = SharedDefault()
                        sharedDefault.setPhoneNumber(loginStatus: self.txtPhone.text!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPwdOTPVC") as! ForgotPwdOTPVC
                            next.countryCode = self.txtDialCode.text!
                            next.phonenumber = self.txtPhone.text!
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.forgotPwdModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            
                        } else { let sharedDefault = SharedDefault()
                            for index in 0..<self.messageEng.count {
                                if let range3 = (self.forgotPwdModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
                                    if sharedDefault.getLanguage() == 0 {
                                        self.showAlert(title: Constants.APP_NAME, message: self.messageEng[index])
                                    } else if sharedDefault.getLanguage() == 1 {
                                        self.showAlert(title: Constants.APP_NAME_BUR, message: self.messageBur[index])
                                    }
                                    
                                }
                            }
                            //self.showAlert(title: Constants.APP_NAME, message: (self.forgotPwdModel?.message)!)
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
