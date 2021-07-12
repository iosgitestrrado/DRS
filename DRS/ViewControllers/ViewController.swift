//
//  ViewController.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/21/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import ADCountryPicker
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class ViewController: UIViewController,UITextViewDelegate , ADCountryPickerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var viewCountryTable: UIView!
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var viewLanguageTable: UIView!
    
    @IBOutlet weak var tableLanguage: UITableView!
    var languageItem = [String]()//Burmese
    var languageCode = [0,1]
    
    var messageEng = [String]()//Eng
    var messageBur = [String]()//Bur
    
    var itemsImages = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsNames = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsCode = ["+95","+91", "+86" ,"+60"]
    @IBOutlet weak var tableCountry: UITableView!
    var validateMobileModelResponse: ValidateMobileModel?
    let picker = ADCountryPicker()
    @IBOutlet var imgFlag: UIImageView!
    @IBOutlet var txtDialCode: UITextField!
    @IBOutlet var txtPhone: UITextField!
    var checkBoxStatus : Bool? = false
    @IBOutlet var txtTerms: UITextView!
    @IBOutlet var lblHeader2: UILabel!
    @IBOutlet var lblHeader1: UILabel!
    @IBOutlet var viewCountry: UIView!
    @IBOutlet var btnSignup: UIButton!
    @IBOutlet var cb1: CheckBox!
    var attributedString = NSMutableAttributedString(string:"")
    @IBOutlet weak var btnForgotPwd: UIButton!
    @IBOutlet weak var viewCountryBg: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    let sharedDefault = SharedDefault()
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableCount:Int = 0
        if tableView == tableLanguage {
            tableCount = languageItem.count
        }
        else if tableView == tableCountry {
            tableCount = itemsImages.count
            
        }
        return tableCount
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
        } else if tableView == tableLanguage {
            let cellBal = tableLanguage.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
            cellBal.backgroundColor = UIColor.white
            cellBal.selectionStyle = .none
            cellBal.lblLanguage.text = languageItem[indexPath.row]
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableCountry {
            txtDialCode.text = itemsCode[indexPath.row]
            imgFlag.image = UIImage(named: itemsImages[indexPath.row])
            viewCountryBg.isHidden = true
        } else if tableView == tableLanguage{
            sharedDefault.setLanguage(language: languageCode[indexPath.row])
            print("languageCode",languageCode[indexPath.row])
            self.changeLanguage()
            
             btnLanguage.setTitle(languageItem[indexPath.row], for: .normal)
        }
        
        
    }
    
    
    @IBAction func btnForgotPwdAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func testAction(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "NewMsgVC") as! NewMsgVC
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    // MARK: - uiviewcontroller
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = true
        tableLanguage.delegate = self
        tableLanguage.dataSource = self
        
        
        let attrs = [
            NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        var buttonTitleStr = NSMutableAttributedString(string:"Forgot Password", attributes:attrs)
        attributedString.append(buttonTitleStr)
        btnForgotPwd.setAttributedTitle(attributedString, for: .normal)
        
        
        txtDialCode.text =  itemsCode[0]
        imgFlag.image = UIImage(named: itemsImages[0])
        txtDialCode.isUserInteractionEnabled = false
        tableCountry.delegate = self
        tableCountry.dataSource = self
        topConstraint.constant = viewCountry.frame.origin.y - 25.0
        imgFlag.layer.cornerRadius = imgFlag.frame.size.height/2
        imgFlag.clipsToBounds = true
        print("viewDidLoad ViewController")
        cb1.isChecked = true
        checkBoxStatus = true
        txtPhone.delegate = self
        viewCountry.layer.cornerRadius = 10
        btnSignup.layer.cornerRadius = btnSignup.frame.size.height/2
        cb1.style = .tick
        cb1.borderStyle = .roundedSquare(radius: 3)
        cb1.addTarget(self, action: #selector(onCheckBoxValueChange(_:)), for: .valueChanged)
        
        //  let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        
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
        
        let font = UIFont.systemFont(ofSize: 16)
                       let attributedString = NSMutableAttributedString(string: "I have read and agree Terms and Conditions, and Agreement.")
                       //let attributedString = NSMutableAttributedString(string: text)
                       let linkAttributes: [NSAttributedString.Key : Any] = [
                           NSAttributedString.Key.foregroundColor:  UIColor.red,
                           NSAttributedString.Key.underlineColor: UIColor.red,
                           NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                       ]
                       
                       attributedString.addAttribute(.link, value: "https://www.ibm.com", range: NSRange(location: 22, length: 21))
                       attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 48, length: 9))
                       attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: 57))
                       
                       attributedString.addAttributes(linkAttributes, range: NSRange(location: 22, length: 21))
                       
                       txtTerms.linkTextAttributes = linkAttributes
                       txtTerms.isEditable = false
                       txtTerms.delegate=self
                       txtTerms.attributedText = attributedString
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtPhone.inputAccessoryView = numberToolbar
        
        self.changeLanguage()
        self.getMessages()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
        
        
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtPhone.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtPhone.resignFirstResponder()
    }
    // MARK: - Textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 1750)
        textField.resignFirstResponder()
        return true
    }
    // MARK: - countryPicker delegate
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
        self.dismiss(animated: true, completion: nil)
        
        var dialcode:String = String()
        dialcode = dialCode
        let flagImage =  picker.getFlag(countryCode: code)
        // let countryName =  picker.getCountryName(countryCode: code)
        let dialingCode =  picker.getDialCode(countryCode: code)
        if dialingCode != nil {
            txtDialCode.text = dialingCode!
        }
        
        imgFlag.image = picker.getFlag(countryCode: code)
        if dialCode.count>0{
            txtDialCode.text = dialCode
        }
        
    }
    // MARK: - checkbox selection method
    @objc func onCheckBoxValueChange(_ sender: CheckBox) {
        
        print(sender.isChecked)
        checkBoxStatus = sender.isChecked
    }
    // MARK: - textView delegate
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
    func getMessages() {
       
        let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            
            let xml = try! XML.parse(text)
            messageEng.removeAll()
            if let text = xml.resource.user_enter_ur_pass.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_contry_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_btween_7_13.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_must_no.text {
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
            if let text = xml.resource.user_enter_ur_pass.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_contry_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_btween_7_13.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_ph_must_no.text {
                messageBur.append(text)
                print(text)
            }
            
        }
        catch(_){print("error")}
        
       
        
    }
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        languageItem.removeAll()
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            btnLanguage.setTitle("ဗမာ", for: .normal)
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.cust_login_Enter_ur_phone_number.text {
                    lblHeader1.text = text
                }
                if let text = xml.resource.cust_login_Use_Ph_No_Regist_log_drs.text {
                    lblHeader2.text = text
                    
                }
                
                if let text = xml.resource.cust_login_sign_in.text {
                    btnSignup.setTitle(text, for: .normal)
                    
                }
                
                if let text = xml.resource.cust_login_forgot_password.text {
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnForgotPwd.setAttributedTitle(buttonTitleStr, for: .normal)
                    print("text",text)
                    
                    
                }
                
                if let text = xml.resource.cust_login_read_agree_terms_cond.text {
                 let font = UIFont.systemFont(ofSize: 16)
                // let attributedString = NSMutableAttributedString(string: "I have read and agree Terms and Conditions, and Agreement.")
                 let attributedString = NSMutableAttributedString(string: text)
                    let style = NSMutableParagraphStyle()
                    style.lineSpacing = 50.5
                    
                 let linkAttributes: [NSAttributedString.Key : Any] = [
                     NSAttributedString.Key.foregroundColor:  UIColor.red,
                     NSAttributedString.Key.underlineColor: UIColor.red,
                     NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                     NSAttributedString.Key.paragraphStyle : style
                 ]
                 
                 attributedString.addAttribute(.link, value: "https://www.ibm.com", range: NSRange(location: 22, length: 21))
                 attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 54, length: 15))//9
                    attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: text.count))
                    
                 let mutableParagraphStyle = NSMutableParagraphStyle()
                                // Customize the line spacing for paragraph.
                 mutableParagraphStyle.lineSpacing = CGFloat(15.0)
                 attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, attributedString.length))
                 
                 attributedString.addAttributes(linkAttributes, range: NSRange(location: 22, length: 21))
                 
                 txtTerms.linkTextAttributes = linkAttributes
                 txtTerms.isEditable = false
                 txtTerms.delegate=self
                 txtTerms.attributedText = attributedString
                 }
                if let text = xml.resource.Setting_language.text {
                    btnLanguage.setTitle(text, for: .normal)
                    print("text",text)
                }
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            btnLanguage.setTitle("English", for: .normal)
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                
                let xml = try! XML.parse(text)
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.cust_login_Enter_ur_phone_number.text {
                    lblHeader1.text = text
                    print("text",text)
                }
                if let text = xml.resource.cust_login_Use_Ph_No_Regist_log_drs.text {
                    lblHeader2.text = text
                    print("text",text)
                }
                
                if let text = xml.resource.cust_login_sign_in.text {
                    btnSignup.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Setting_language.text {
                    btnLanguage.setTitle(text, for: .normal)
                    print("text",text)
                }
                
                
                
                if let text = xml.resource.cust_login_forgot_password.text {
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnForgotPwd.setAttributedTitle(buttonTitleStr, for: .normal)
                    
                    
                }
                
                if let text = xml.resource.cust_login_read_agree_terms_cond.text {
                let font = UIFont.systemFont(ofSize: 16)
               // let attributedString = NSMutableAttributedString(string: "I have read and agree Terms and Conditions, and Agreement.")
                let attributedString = NSMutableAttributedString(string: text)
                let linkAttributes: [NSAttributedString.Key : Any] = [
                    NSAttributedString.Key.foregroundColor:  UIColor.red,
                    NSAttributedString.Key.underlineColor: UIColor.red,
                    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                
                attributedString.addAttribute(.link, value: "https://www.ibm.com", range: NSRange(location: 22, length: 21))
                attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 48, length: 9))
                attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: 57))
                
                attributedString.addAttributes(linkAttributes, range: NSRange(location: 22, length: 21))
                
                txtTerms.linkTextAttributes = linkAttributes
                txtTerms.isEditable = false
                txtTerms.delegate=self
                txtTerms.attributedText = attributedString
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        let mutableAttrStr = NSMutableAttributedString(string: textView.text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 27
        mutableAttrStr.addAttributes([NSAttributedString.Key.paragraphStyle:style], range: NSMakeRange(0, mutableAttrStr.length))
        textView.attributedText = mutableAttrStr
    }


    @IBAction func btnLanguageAction(_ sender: UIButton) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.viewCountryBg.addGestureRecognizer(tap)
        self.viewCountryBg.isHidden = false
        self.viewLanguageTable.isHidden = false
        self.viewCountryTable.isHidden = true
        viewLanguageTable.layer.cornerRadius = 15
        
    }
    // MARK: - country selection method
    @IBAction func btnSelectCountryAction(_ sender: Any) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.viewCountryBg.addGestureRecognizer(tap)
        self.viewCountryBg.isHidden = false
        
        self.viewLanguageTable.isHidden = true
        self.viewCountryTable.isHidden = false
        
    }
    @objc func dismissKeyboard()
    {
        txtPhone.resignFirstResponder()
        txtDialCode.resignFirstResponder()
        self.viewCountryBg.isHidden = true
    }
    // MARK: - signup action
    @IBAction func btnSignupAction(_ sender: Any)
    {
        let sharedDefault = SharedDefault()
        var countryStr = String()
        var phoneStr = String()
        var termsStr = String()
        
        if sharedDefault.getLanguage() == 1 {
            countryStr = Constants.selectCountryBur
            phoneStr = Constants.enterPhoneBur
            termsStr = Constants.slectTermsBur
        } else if sharedDefault.getLanguage() == 0 {
            countryStr = Constants.selectCountryEng
            phoneStr = Constants.enterPhoneEng
            termsStr = Constants.slectTermsEng
        }
        txtPhone.resignFirstResponder()
        txtDialCode.resignFirstResponder()
        if txtDialCode.text!.count <= 0{
            self.showToast(message: countryStr)
        } else if txtPhone.text!.count <= 0{
            self.showToast(message: phoneStr)
        } else if (checkBoxStatus == false){
            self.showToast(message: termsStr)
        }
        else {
            if Reachability.isConnectedToNetwork() {
                self.validatePhone(phoneNumber: txtPhone.text!)
            } else {
                showToast(message: Constants.APP_NO_NETWORK)
            }
        }
        /*
         let next = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPRegVC") as! VerifyOTPRegVC
         self.navigationController?.pushViewController(next, animated: true)
         */
    }
    
    // MARK: - signup method
    func validatePhone(phoneNumber: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phoneNumber,
                    "country_code":txtDialCode.text!
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.validateMobileURL
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
                    self.validateMobileModelResponse = ValidateMobileModel(response)
                    //print("self.validateMobileModelResponse ",self.validateMobileModelResponse!)
                    //print("self.validateMobileModelResponse ",self.validateMobileModelResponse?.httpcode!)
                    //print("self.validateMobileModelResponse ",self.validateMobileModelResponse?.validateMobileModelData)
                    
                    let statusCode = Int((self.validateMobileModelResponse?.httpcode)!)
                    if statusCode == 200{
                        //self.showToast(message: (self.validateMobileModelResponse?.message)!)
                        self.sharedDefault.setDialCode(dialCode: self.txtDialCode.text!)
                        self.sharedDefault.setPhoneNumber(loginStatus: self.txtPhone.text!)
                        if self.validateMobileModelResponse?.validateMobileModelData?.action == "signin"
                        {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.view.activityStopAnimating()
                                let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                                next.srtName = self.validateMobileModelResponse?.validateMobileModelData?.customerName as! String
                                next.srtPhone = self.validateMobileModelResponse?.validateMobileModelData?.phoneNumber as! String
                                self.navigationController?.pushViewController(next, animated: true)
                            }
                        }
                        else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.view.activityStopAnimating()
                                let next = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPRegVC") as! VerifyOTPRegVC
                                next.countryCode = self.txtDialCode.text!
                                self.navigationController?.pushViewController(next, animated: true)
                            }
                        }
                        
                        
                    }
                    if statusCode == 400{
                        if let range3 = (self.validateMobileModelResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if sharedDefault.getLanguage() == 0 {
                                self.showToast(message:Constants.InvalidAccessEng )
                            }
                            //self.showToast(message:(self.validateMobileModelResponse?.message!)! )
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.view.activityStopAnimating()
                                let sharedDefault = SharedDefault()
                                sharedDefault .clearAccessToken()
                                sharedDefault .setLoginStatus(loginStatus: false)
                                
                                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                let customViewControllersArray : NSArray = [newViewController]
                                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            
                        } else {
                            self.view.activityStopAnimating()
                            let sharedDefault = SharedDefault()
                            for index in 0..<self.messageEng.count {
                                if let range3 = (self.validateMobileModelResponse?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
                                    if sharedDefault.getLanguage() == 0 {
                                        self.showAlert(title: Constants.APP_NAME, message: self.messageEng[index])
                                    } else if sharedDefault.getLanguage() == 1 {
                                        self.showAlert(title: Constants.APP_NAME_BUR, message: self.messageBur[index])
                                    }
                                    
                                }
                            }
                            //self.showAlert(title: Constants.APP_NAME, message: (self.validateMobileModelResponse?.message)!)
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
    
}

