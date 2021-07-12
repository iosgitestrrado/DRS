//
//  AccountSettingsVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import PhotosUI
import Photos
import SwiftyXMLParser

class AccountSettingsVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet weak var lblChangePhoto: UILabel!
    @IBOutlet weak var lblBankTitle: UILabel!
    @IBOutlet weak var lblProfileTitle: UILabel!
    @IBOutlet weak var lblRefTitle: UILabel!
    var imagePicker = UIImagePickerController()
    var picker = UIPickerView()
    var pickerGender = UIPickerView()
    let toolBar = UIToolbar()
    let toolBarGender = UIToolbar()
    var pickerData = [String]()
    var pickerGenderData = [String]()
    var selectedCountryID:Int = Int()
    var accInfoModel: AccInfoModel?
    var countryResponse: CountryResponse?
    var genderStatus: Bool = false
    var countryID = [Int]()
    var countryName = [String]()
    var strTitle:String = String()
    @IBOutlet weak var viewMainGenInfo: UIView!
    
    @IBOutlet weak var viewMainPin: UIView!
    @IBOutlet weak var viewMainBank: UIView!
    @IBOutlet weak var txtAdderss: UITextField!
    @IBOutlet weak var txtBankAddress: UITextField!
    @IBOutlet var viewBank: UIView!
    @IBOutlet var viewReferral: UIView!
    @IBOutlet var btnUpdate: UIButton!
    var firstImgData:String = String()
    
    @IBOutlet var viewGenInfo: UIView!
    @IBOutlet var btnProfile: UIButton!
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var viewScrollBG: UIView!
    @IBOutlet var scrollAccountSettings: UIScrollView!
    
    @IBOutlet var txtAge: UITextField!
    @IBOutlet var txtFName: UITextField!
    @IBOutlet var txtSName: UITextField!
    @IBOutlet var txtIDNo: UITextField!
    @IBOutlet var txtGender: UITextField!
    
    
    @IBOutlet var txtCountry: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtPhone: UITextField!
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet var txtBankName: UITextField!
    @IBOutlet var txtBankAcNo: UITextField!
    @IBOutlet var txtBankHName: UITextField!
    
    @IBOutlet var txtBankSwiftCode: UITextField!
    let sharedData = SharedDefault()

    @IBOutlet var txtReferal: UITextField!
    var bankStatus: Bool = true
    var profileStatus: Bool = true
    var pinStatus: Bool = true
    
    var successMessageEng:String = ""
    var successMessageBur:String = ""
    
    @IBOutlet weak var bankHeight: NSLayoutConstraint!
    
    @IBOutlet weak var pinHeight: NSLayoutConstraint!
    @IBOutlet weak var profileHeight: NSLayoutConstraint!
    var messageEng = [String]()
    var messageBur = [String]()
    func getMessages() {
      
        let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            
            let xml = try! XML.parse(text)
            messageEng.removeAll()
            if let text = xml.resource.user_invalid_access_update_info.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_acc_info_update_success.text {
                messageEng.append(text)
                print(text)
                successMessageEng = text
            }
            if let text = xml.resource.user_email_already_taken.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_firstname_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_age_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_gender_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_email_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_id_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_address_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_country_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_bank_name_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_acc_holder_required_update_info.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_acc_no_required_update_info.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_swift_code_required_update_info.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_bank_address_required_update_info.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_must_6_char_update_info.text {
                messageEng.append(text)
                print(text)
            }
            
            
            if let text = xml.resource.user_lastname_required.text
            {
                messageEng.append(text)
                print(text)
            }
            
            if let text = xml.resource.user_ph_required_signup.text
            {
                messageEng.append(text)
                print(text)
            }
            
            
            if let text = xml.resource.user_Password_required.text
            {
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
            if let text = xml.resource.user_invalid_access_update_info.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_acc_info_update_success.text {
                messageBur.append(text)
                successMessageBur = text
                print(text)
            }
            if let text = xml.resource.user_email_already_taken.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_firstname_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_age_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_gender_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_email_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_id_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_address_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_country_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_bank_name_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_acc_holder_required_update_info.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_acc_no_required_update_info.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_swift_code_required_update_info.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_bank_address_required_update_info.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_pass_must_6_char_update_info.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_lastname_required.text
            {
                messageBur.append(text)
                print(text)
            }
            
            
            if let text = xml.resource.user_ph_required_signup.text
            {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_Password_required.text
            {
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
        
        print("getLanguage", sharedDefault.getLanguage())
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
               
                
                let xml = try! XML.parse(text)
                if let text = xml.resource.Setting_acc_settings.text {
                    print("Account_Setting_Update --------",text)
                     strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Account_Setting_Update.text {
                    print("Account_Setting_Update --------",text)
                     btnUpdate.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.Account_Setting_change_photo.text {
                    print("Account_Setting_change_photo --------",text)
                    lblChangePhoto.text = text
                }
                if let text = xml.resource.Account_Setting_Profile.text {
                    print("Account_Setting_Profile --------",text)
                    lblProfileTitle.text = text
                }
                if let text = xml.resource.Account_Setting_Bank.text {
                    print("Account_Setting_Bank --------",text)
                    lblBankTitle.text = text
                }
                if let text = xml.resource.Account_Setting_Ref.text {
                    print("Account_Setting_Ref --------",text)
                    lblRefTitle.text = text
                    
                }
                if let text = xml.resource.Account_Setting_first_name.text {
                    print("Account_Setting_first_name --------",text)
                    txtFName.placeholder = text
                }
                if let text = xml.resource.Account_Setting_last_name.text {
                    print("Account_Setting_Last_name --------",text)
                    txtLastName.placeholder = text
                }
                if let text = xml.resource.Account_Setting_age.text {
                               print("Account_Setting_age --------",text)
                    txtAge.placeholder = text
                           }
                if let text = xml.resource.Account_Setting_ID_No.text {
                    print("Account_Setting_ID_No --------",text)
                    txtIDNo.placeholder = text
                }
                if let text = xml.resource.Account_Setting_addrs.text {
                    print("Account_Setting_addrs --------",text)
                    txtAdderss.placeholder = text
                }
                if let text = xml.resource.Account_Setting_country.text {
                    print("Account_Setting_country --------",text)
                    txtCountry.placeholder = text
                }
                if let text = xml.resource.Account_Setting_email.text {
                               print("Account_Setting_email --------",text)
                    txtEmail.placeholder = text
                           }
                if let text = xml.resource.Account_Setting_pass.text {
                    print("Account_Setting_pass --------",text)
                    txtPassword.placeholder = text
                }
                if let text = xml.resource.Account_Setting_Ph_No.text {
                    print("Account_Setting_Ph_No --------",text)
                    txtPhone.placeholder = text
                }
               
                if let text = xml.resource.Account_Setting_bank_name.text {
                    print("Account_Setting_bank_name --------",text)
                    txtBankName.placeholder = text
                }
                
                if let text = xml.resource.Account_Setting_bank_holder_name.text {
                    print("Account_Setting_bank_holder_name --------",text)
                    txtBankHName.placeholder = text
                }
                if let text = xml.resource.Account_Setting_bank_acc_no.text {
                    print("Account_Setting_bank_acc_no --------",text)
                    txtBankAcNo.placeholder = text
                }
                if let text = xml.resource.Account_Setting_bank_swift_code.text {
                    print("Account_Setting_bank_swift_code --------",text)
                    txtBankSwiftCode.placeholder = text
                }
                if let text = xml.resource.Account_Setting_branch_address.text {
                    print("Account_Setting_branch_address --------",text)
                    txtBankAddress.placeholder = text
                }
                if let text = xml.resource.Account_Setting_ref_ID.text {
                    print("Account_Setting_ref_ID --------",text)
                     txtReferal.placeholder = text
               }
                
                 
                      
                
                
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
               
                
                
            //@IBOutlet var txtGender: UITextField!
                
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Setting_acc_settings.text {
                    print("Account_Setting_Update --------",text)
                     strTitle = text
                    self.title = strTitle
                }
               
                
                if let text = xml.resource.Account_Setting_Update.text {
                    print("Account_Setting_Update --------",text)
                     btnUpdate.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.Account_Setting_change_photo.text {
                    print("Account_Setting_change_photo --------",text)
                    lblChangePhoto.text = text
                }
                if let text = xml.resource.Account_Setting_Profile.text {
                    print("Account_Setting_Profile --------",text)
                    lblProfileTitle.text = text
                }
                if let text = xml.resource.Account_Setting_Bank.text {
                    print("Account_Setting_Bank --------",text)
                    lblBankTitle.text = text
                }
                if let text = xml.resource.Account_Setting_Ref.text {
                    print("Account_Setting_Ref --------",text)
                    lblRefTitle.text = text
                    
                }
                
                if let text = xml.resource.Account_Setting_first_name.text {
                    print("Account_Setting_first_name --------",text)
                    txtFName.placeholder = text
                }
                
                if let text = xml.resource.Account_Setting_last_name.text {
                    print("Account_Setting_Last_name --------",text)
                    txtLastName.placeholder = text
                }
                if let text = xml.resource.Account_Setting_age.text {
                               print("Account_Setting_age --------",text)
                    txtAge.placeholder = text
                           }
                if let text = xml.resource.Account_Setting_ID_No.text {
                    print("Account_Setting_ID_No --------",text)
                    txtIDNo.placeholder = text
                }
                if let text = xml.resource.Account_Setting_addrs.text {
                    print("Account_Setting_addrs --------",text)
                    txtAdderss.placeholder = text
                }
                if let text = xml.resource.Account_Setting_country.text {
                    print("Account_Setting_country --------",text)
                    txtCountry.placeholder = text
                }
                if let text = xml.resource.Account_Setting_email.text {
                               print("Account_Setting_email --------",text)
                    txtEmail.placeholder = text
                           }
                if let text = xml.resource.Account_Setting_pass.text {
                    print("Account_Setting_pass --------",text)
                    txtPassword.placeholder = text
                }
                if let text = xml.resource.Account_Setting_Ph_No.text {
                    print("Account_Setting_Ph_No --------",text)
                    txtPhone.placeholder = text
                }
               
                if let text = xml.resource.Account_Setting_bank_name.text {
                    print("Account_Setting_bank_name --------",text)
                    txtBankName.placeholder = text
                }
                
                if let text = xml.resource.Account_Setting_bank_holder_name.text {
                    print("Account_Setting_bank_holder_name --------",text)
                    txtBankHName.placeholder = text
                }
                if let text = xml.resource.Account_Setting_bank_acc_no.text {
                    print("Account_Setting_bank_acc_no --------",text)
                    txtBankAcNo.placeholder = text
                }
                if let text = xml.resource.Account_Setting_bank_swift_code.text {
                    print("Account_Setting_bank_swift_code --------",text)
                    txtBankSwiftCode.placeholder = text
                }
                if let text = xml.resource.Account_Setting_branch_address.text {
                    print("Account_Setting_branch_address --------",text)
                    txtBankAddress.placeholder = text
                }
                if let text = xml.resource.Account_Setting_ref_ID.text {
                    print("Account_Setting_ref_ID --------",text)
                     txtReferal.placeholder = text
               }
                
                 
                      
                
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    @IBAction func btnBankExpandAction(_ sender: Any) {
        
        if bankStatus == true {
            bankHeight.constant = 325.0
            viewBank.isHidden = false
            bankStatus = false
        } else{
            bankHeight.constant = 50.0
            viewBank.isHidden = true
            bankStatus = true
            
        }
    }
    @IBAction func btnPinExpandAction(_ sender: Any) {
        if pinStatus == true {
            pinHeight.constant = 105.0
            viewReferral.isHidden = false
            pinStatus = false
        } else{
            pinHeight.constant = 50.0
            viewReferral.isHidden = true
            pinStatus = true
        }
    }
    
    @IBAction func btnProfileExpandAction(_ sender: Any)
    {
        if profileStatus == true {
            profileHeight.constant = 695.0
            profileStatus = false
            viewGenInfo.isHidden = false
            
        } else{
            profileHeight.constant = 50.0
            viewGenInfo.isHidden = true
            profileStatus = true
            
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        var pickerCount:Int = 0
        
        if pickerView == pickerGender  {
            pickerCount = pickerGenderData.count
        } else {
            pickerCount = pickerData.count
        }
        
        return pickerCount
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        //var strPicker:String = String()
        
        if pickerView == pickerGender  {
            //strPicker = (pickerGenderData[row] as? String)!
            
            return pickerGenderData[row] as? String
            
        }
        else{
            return pickerData[row] as? String
        }
        
        //return pickerData[row] as? String // dropdown item
        //return strPicker // dropdown item
    }
    @objc func cancelPicker() {
        print("cancelPicker")
        
        
        txtCountry.resignFirstResponder()
        txtGender.resignFirstResponder()
    }
    @objc func donePicker() {
        //pickerStatus = 0
        picker.selectRow(0, inComponent: 0, animated: true)
        picker.reloadAllComponents();
        
        pickerGender.selectRow(0, inComponent: 0, animated: true)
        pickerGender.reloadAllComponents();
        
        txtCountry.resignFirstResponder()
        txtGender.resignFirstResponder()
        
        
        if txtCountry.text!.count <= 0 {
            selectedCountryID = self.countryID[0]
            txtCountry.text = self.countryName[0]
            
        } else if(selectedCountryID<=0){
            selectedCountryID = self.countryID[0]
            txtCountry.text = self.countryName[0]
        }
        print("txtCountry.text ----- ",txtCountry.text)
        if txtGender.text!.count<=0 {
            txtGender.text = pickerGenderData[0]
        } else {
            if  genderStatus == false {
                if txtGender.text!.count <= 0 {
                    txtGender.text = pickerGenderData[0]
                }
                
                
            } else{
                genderStatus = false
            }
        }
        
        /*
         if countryStatus == true {
         if txtBusCountry.text!.count <= 0 {
         selectedCountryID = self.countryID[0]
         txtBusCountry.text = self.countryName[0]
         
         }
         
         
         
         }
         
         countryStatus = false*/
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        //selectedCountry = pickerData[row] // selected item
        //textFiled.text = selectedCountry
        
        if pickerView == pickerGender {
            genderStatus = true
            txtGender.text = pickerGenderData[row]
        } else if pickerView == picker {
            genderStatus = true
            selectedCountryID = self.countryID[row]
            txtCountry.text = pickerData[row]
        }
        
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //delegate method
        /* if textField != txtLoginId || textField != txtPassword || textField != txtEmail || textField != txtDRSUserId || textField != txtDRSUserId
         {
         if textField == txtBusCountry{
         self.animateViewMoving(up: true, moveValue: 180)//180
         }
         else {
         self.animateViewMoving(up: true, moveValue: 205)//180
         }
         }
         */
        
        if textField == txtCountry
        {
            pickerData = self.countryName
            txtCountry.inputView = picker
            txtCountry.inputAccessoryView = toolBar
            //pickerStatus = 1
            //countryStatus = true
            if txtCountry.text!.count>0{
                for item in 0..<self.countryName.count {
                    if self.countryName[item] == txtCountry.text!  {
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        } else if textField == txtGender{
            
            txtGender.inputView = pickerGender
            txtGender.inputAccessoryView = toolBar
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
        
        let button = UIButton(type: UIButton.ButtonType.custom)
//        button.setImage(UIImage(named: "editb"), for: .normal)
        
        button.setImage(UIImage(named: "editb"), for: .normal)

        button.addTarget(self, action:#selector(btnEditAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
        
        
        
        // Change By Praveen
        
        pickerGenderData.append("Male")
        pickerGenderData.append("Female")
        
        viewMainGenInfo.layer.cornerRadius = 15
        viewMainPin.layer.cornerRadius = 15
        viewMainBank.layer.cornerRadius = 15
        
        viewMainGenInfo.clipsToBounds = true
        viewMainPin.clipsToBounds = true
        viewMainBank.clipsToBounds = true
        
        bankHeight.constant = 50.0
        viewBank.isHidden = true
        
        profileHeight.constant = 50.0
        viewGenInfo.isHidden = true
        
        pinHeight.constant = 50.0
        viewReferral.isHidden = true
        btnProfile.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        self.txtAdderss.isEnabled = false
        self.txtBankAddress.isEnabled = false
        txtAge.isEnabled = false
        txtFName.isEnabled = false
        txtLastName.isEnabled = false
        txtSName.isEnabled = false
        txtIDNo.isEnabled = false
        txtGender.isEnabled = false
        txtCountry.isEnabled = false
        txtEmail.isEnabled = false
        txtPassword.isEnabled = false
        txtPhone.isEnabled = false
        txtBankName.isEnabled = false
        txtBankAcNo.isEnabled = false
        txtBankHName.isEnabled = false
        txtBankSwiftCode.isEnabled = false
        txtReferal.isEnabled = false
        
        
        txtAge.delegate = self
        txtLastName.delegate = self
        txtFName.delegate = self
        txtSName.delegate = self
        txtIDNo.delegate = self
        txtGender.delegate = self
        txtCountry.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtPhone.delegate = self
        txtBankName.delegate = self
        txtBankAcNo.delegate = self
        txtBankHName.delegate = self
        txtBankSwiftCode.delegate = self
        txtReferal.delegate = self
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtBankAcNo.inputAccessoryView = numberToolbar

        
        self.txtAdderss.delegate = self
        self.txtBankAddress.delegate = self
        
        
        self.getCountry()
        
        self.getAccountInfo()
        
        // Do any additional setup after loading the view.
        viewGenInfo.layer.cornerRadius = 10
        btnProfile.layer.cornerRadius = btnProfile.frame.size.height/2
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2


        txtFName.backgroundColor = Constants.textBGColor
        txtFName.layer.cornerRadius = 10
        let paddingViewName = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtFName.frame.height))
        txtFName.leftView = paddingViewName
        txtFName.leftViewMode = UITextField.ViewMode.always
        
        txtLastName.backgroundColor = Constants.textBGColor
        txtLastName.layer.cornerRadius = 10
        let paddingViewName1 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLastName.frame.height))
        txtLastName.leftView = paddingViewName1
        txtLastName.leftViewMode = UITextField.ViewMode.always
        
        
        
        
        txtSName.backgroundColor = Constants.textBGColor
        txtSName.layer.cornerRadius = 10
        let paddingViewSName = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtSName.frame.height))
        txtSName.leftView = paddingViewSName
        txtSName.leftViewMode = UITextField.ViewMode.always
        
        txtAge.backgroundColor = Constants.textBGColor
        txtAge.layer.cornerRadius = 10
        let paddingViewAge = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtAge.frame.height))
        txtAge.leftView = paddingViewAge
        txtAge.leftViewMode = UITextField.ViewMode.always
        
        txtIDNo.backgroundColor = Constants.textBGColor
        txtIDNo.layer.cornerRadius = 10
        let paddingViewID = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtIDNo.frame.height))
        txtIDNo.leftView = paddingViewID
        txtIDNo.leftViewMode = UITextField.ViewMode.always
        
        txtGender.backgroundColor = Constants.textBGColor
        txtGender.layer.cornerRadius = 10
        let paddingViewG = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtGender.frame.height))
        txtGender.leftView = paddingViewG
        txtGender.leftViewMode = UITextField.ViewMode.always
        
        
        
        txtCountry.backgroundColor = Constants.textBGColor
        txtCountry.layer.cornerRadius = 10
        let paddingViewC = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtCountry.frame.height))
        txtCountry.leftView = paddingViewC
        txtCountry.leftViewMode = UITextField.ViewMode.always
        
        
        txtEmail.backgroundColor = Constants.textBGColor
        txtEmail.layer.cornerRadius = 10
        let paddingViewEmail = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtEmail.frame.height))
        txtEmail.leftView = paddingViewEmail
        txtEmail.leftViewMode = UITextField.ViewMode.always
        
        txtPhone.backgroundColor = Constants.textBGColor
        txtPhone.layer.cornerRadius = 10
        let paddingViewPhone = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtPhone.frame.height))
        txtPhone.leftView = paddingViewPhone
        txtPhone.leftViewMode = UITextField.ViewMode.always
        
        txtPassword.backgroundColor = Constants.textBGColor
        txtPassword.layer.cornerRadius = 10
        let paddingViewPwd = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtPassword.frame.height))
        txtPassword.leftView = paddingViewPwd
        txtPassword.leftViewMode = UITextField.ViewMode.always
        
        txtBankName.backgroundColor = Constants.textBGColor
        txtBankName.layer.cornerRadius = 10
        let paddingViewBankN = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtBankName.frame.height))
        txtBankName.leftView = paddingViewBankN
        txtBankName.leftViewMode = UITextField.ViewMode.always
        
        txtBankAcNo.backgroundColor = Constants.textBGColor
        txtBankAcNo.layer.cornerRadius = 10
        let paddingViewBankAc = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtBankAcNo.frame.height))
        txtBankAcNo.leftView = paddingViewBankAc
        txtBankAcNo.leftViewMode = UITextField.ViewMode.always
        
        txtBankHName.backgroundColor = Constants.textBGColor
        txtBankHName.layer.cornerRadius = 10
        let paddingViewBankH = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtBankHName.frame.height))
        txtBankHName.leftView = paddingViewBankH
        txtBankHName.leftViewMode = UITextField.ViewMode.always
        
        //txtViewBankAddress.backgroundColor = Constants.textBGColor
        //txtViewBankAddress.layer.cornerRadius = 10
        
        txtBankSwiftCode.backgroundColor = Constants.textBGColor
        txtBankSwiftCode.layer.cornerRadius = 10
        let paddingViewSwift = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtBankSwiftCode.frame.height))
        txtBankSwiftCode.leftView = paddingViewSwift
        txtBankSwiftCode.leftViewMode = UITextField.ViewMode.always
        
        txtReferal.backgroundColor = Constants.textBGColor
        txtReferal.layer.cornerRadius = 10
        let paddingViewRef = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtBankSwiftCode.frame.height))
        txtReferal.leftView = paddingViewRef
        txtReferal.leftViewMode = UITextField.ViewMode.always
        
        txtAdderss.backgroundColor = Constants.textBGColor
        txtAdderss.layer.cornerRadius = 10
        let paddingViewAddress = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtAdderss.frame.height))
        txtAdderss.leftView = paddingViewAddress
        txtAdderss.leftViewMode = UITextField.ViewMode.always
        
        txtBankAddress.backgroundColor = Constants.textBGColor
        txtBankAddress.layer.cornerRadius = 10
        let paddingViewBankAddress = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtBankAddress.frame.height))
        txtBankAddress.leftView = paddingViewBankAddress
        txtBankAddress.leftViewMode = UITextField.ViewMode.always
        
        
        viewBank.layer.cornerRadius = 10
        viewReferral.layer.cornerRadius = 10
        
        btnUpdate.layer.cornerRadius = btnUpdate.frame.size.height/2
        
        pickerGender = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        // CGReØproctMake(0, 200, view.frame.width, 300)
        pickerGender.backgroundColor = .white
        
        pickerGender.showsSelectionIndicator = true
        pickerGender.delegate = self
        pickerGender.dataSource = self
        
        
        toolBarGender.barStyle = UIBarStyle.default
        toolBarGender.isTranslucent = true
        toolBarGender.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBarGender.sizeToFit()
        
        let doneButtonG = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButtonG = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButtonG = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        
        toolBarGender.setItems([cancelButtonG, spaceButtonG, doneButtonG], animated: false)
        toolBarGender.isUserInteractionEnabled = true
        
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        // CGRectMake(0, 200, view.frame.width, 300)
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        let viewS = UIView(frame: CGRect(x: 0, y: txtCountry.frame.size.height/2, width: 12, height: 12))
        txtCountry.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 12, height: 12))
        let image = UIImage(named: "DownArrow")
        imageView.image = image
        viewS.addSubview(imageView)
        txtCountry.rightView = viewS
        
        
        txtAge.inputAccessoryView = numberToolbar

        self.changeLanguage()
        
        self.getMessages()
        
        
        
        
        
        
    }
    @objc func btnEditAction() {
        // Function body goes here
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [self] in
            self.view.activityStartAnimating()
            print("btnEditAction")
            
            let button = UIButton(type: UIButton.ButtonType.custom)
            button.setImage(UIImage(named: "EditNew"), for: .normal)
            

            button.addTarget(self, action:#selector(btnEditAction), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            let barButton = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItems = [barButton]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.txtAdderss.isEnabled = true
                self.txtBankAddress.isEnabled = true
                self.txtAge.isEnabled = true
                self.txtGender.isEnabled = true
                self.txtIDNo.isEnabled = true
                //self.txtViewAddress.isEditable = true
                self.txtCountry.isEnabled = true
                self.txtEmail.isEnabled = true
                self.txtPassword.isEnabled = true
                self.txtBankAcNo.isEnabled = true
                self.txtBankSwiftCode.isEnabled = true
                //self.txtViewBankAddress.isEditable = true
                self.txtBankHName.isEnabled = true
                self.txtBankName.isEnabled = true
                self.btnUpdate.isHidden  = false
                
                self.txtLastName.isEnabled = true
                self.txtFName.isEnabled = true
                self.txtSName.isEnabled = false
                self.txtPhone.isEnabled = false
                self.btnProfile.isEnabled = true
                self.txtReferal.isEnabled = false
                
                
                self.view.activityStopAnimating()
            }
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 1750)
        textField.resignFirstResponder()
        return true
    }
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollAccountSettings.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollAccountSettings.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollAccountSettings.contentInset = contentInset
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtBankAcNo.resignFirstResponder()
        txtAge.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtBankAcNo.resignFirstResponder()
        txtAge.resignFirstResponder()
    }
    
    func getCountry() {
        self.view.activityStartAnimating()
        
        
        let loginURL = Constants.baseURL+Constants.GetCountryURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.countryResponse = CountryResponse(response)
                    print("self.loginResponse ",self.countryResponse!)
                    print("self.loginResponse ",self.countryResponse?.httpcode!)
                    print("self.loginResponse ",self.countryResponse?.countryData?.countryList)
                    
                    let statusCode = Int((self.countryResponse?.httpcode)!)
                    if statusCode == 200{
                        self.countryID.removeAll()
                        self.countryName.removeAll()
                        for item in (self.countryResponse?.countryData?.countryList)! {
                            self.countryID.append(item.id!)
                            self.countryName.append(item.name!)
                        }
                    }
                    print("countryID ",self.countryID)
                    print("countryName ",self.countryName)
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.countryResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.countryResponse?.message)!)
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
    
    @IBAction func btnUpdateAction(_ sender: Any)
    {
        
        
        if txtFName.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[3])

            }
            else
            {
                self.showToast(message: self.messageEng[3])

            }
        }
//        else
//        if txtLastName.text!.count == 0
//        {
//            if sharedData.getLanguage() == 1
//            {
//                self.showToast(message: self.messageBur[16])
//
//            }
//            else
//            {
//                self.showToast(message: self.messageEng[16])
//
//            }
//        }
        else
        if txtAge.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[4])

            }
            else
            {
                self.showToast(message: self.messageEng[4])

            }
        }
        else
        if txtGender.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[5])

            }
            else
            {
                self.showToast(message: self.messageEng[5])

            }
        }
        else
        if txtIDNo.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[7])

            }
            else
            {
                self.showToast(message: self.messageEng[7])

            }
        }
        else
        if txtAdderss.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[8])

            }
            else
            {
                self.showToast(message: self.messageEng[8])

            }
        }
        else
        if txtCountry.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[9])

            }
            else
            {
                self.showToast(message: self.messageEng[9])

            }
        }
        else
        if txtEmail.text!.count == 0
        {
            
            
            
            
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[6])

            }
            else
            {
                self.showToast(message: self.messageEng[6])

            }
            
        }
        
        else
        if !(txtEmail.text?.isValidEmail())!
        {
            
            
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: "မမှန်ကန်သောအီးမေးလ်လိပ်စာ")

            }
            else
            {
                self.showToast(message: "Invalid email address")

            }
            
        }
        
        else
        if txtPhone.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: self.messageBur[17])

            }
            else
            {
                self.showToast(message: self.messageEng[17])

            }
        }
//        else
//        if txtPhone.text!.count < 6 || txtPhone.text!.count > 12
//        {
//            if sharedData.getLanguage() == 1
//            {
//                self.showToast(message: "ဖုန်းနံပါတ်သည်ဂဏန်း ၇ လုံးမှ ၁၂ လုံးအကြားရှိရမည်")
//
//            }
//            else
//            {
//                self.showToast(message: "The phone number must be between 7 and 12 digits")
//
//            }
//
//        }
//        else
//        if txtPassword.text!.count == 0
//        {
//            if sharedData.getLanguage() == 1
//            {
//                self.showToast(message: self.messageBur[18])
//
//            }
//            else
//            {
//                self.showToast(message: self.messageEng[18])
//
//            }
//            
//        }
//        else
//        if txtPassword.text!.count < 6
//        {
//            if sharedData.getLanguage() == 1
//            {
//                self.showToast(message: self.messageBur[15])
//
//            }
//            else
//            {
//                self.showToast(message: self.messageEng[15])
//
//            }
//
//        }
        else
        if txtReferal.text!.count == 0
        {
            if sharedData.getLanguage() == 1
            {
                self.showToast(message: "လွှဲပြောင်းအိုင်ဒီတရားဝင်ဖြစ်ရမည်")

            }
            else
            {
                self.showToast(message:"The referral id must be valid")

            }
        }
        else
        {
            self.updateAccountInfo()

        }
        
    }
    @IBAction func btnProfileAction(_ sender: Any)
    {
        self.showAlert()
    }
    
    //Show alert to selected the media source type.
    func showAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Info ------->",info as Any)
        if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
           
            
        }
        let pImage = info[UIImagePickerController.InfoKey.originalImage]
        let timage:UIImage = (pImage as? UIImage)!
        firstImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
        
        imgProfile.image = pImage as? UIImage
        
        // btnProfilePic.setImage(pImage as? UIImage, for: .normal)
        //updateDetails["avatar"] = convertImageToBase64(image: ((pImage as? UIImage)!))
        dismiss(animated: true, completion: nil)
        
        self.updateProfilePic()
    }
    func updateProfilePic() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            let sharedData = SharedDefault()
            self.view.activityStartAnimating()
            var postDict = Dictionary<String,String>()
            postDict = ["access_token":sharedData.getAccessToken() as String,
                        "profile_pic":self.firstImgData
                
            ]
            
            print("PostData: ",postDict)
            let loginURL = Constants.baseURL+Constants.UploadProfilePicURL
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
                        self.accInfoModel = AccInfoModel(response)
                        print("self.accInfoModel ",self.accInfoModel!)
                        print("self.accInfoModel ",self.accInfoModel?.httpcode!)
                        //print("self.accInfoModel ",self.settingsModel?.settingsModelData)
                        //let sharedDefault = SharedDefault()
                        let statusCode = Int((self.accInfoModel?.httpcode)!)
                        if statusCode == 200{
                            self.showToast(message: (self.accInfoModel?.accInfoModelData?.message)!)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                                self.firstImgData = ""
                                
                                
                                //let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                                //next.srtName = self.validateMobileModelResponse?.validateMobileModelData?.customerName as! String
                                //next.srtPhone = self.validateMobileModelResponse?.validateMobileModelData?.phoneNumber as! String
                                // self.navigationController?.pushViewController(next, animated: true)
                                //self.tableViewBal.reloadData()
                            }
                            
                            /*
                             let url = URL(string: (self.settingsModel?.settingsModelData?.customerData?.profilePic)!)
                             if url != nil{
                             self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                             }else {
                             self.imgProfile.image = UIImage(named: "SplashImage")
                             }
                             */
                            /*
                             DispatchQueue.global().async {
                             if url != nil{
                             
                             let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                             DispatchQueue.main.async {
                             if data!.count>0{
                             //self.imgCompany.layer.cornerRadius = 10
                             self.imgProfile.image = UIImage(data: data!)
                             //self.imgCompany.setImage(UIImage(data: data!), for: .normal)
                             
                             }
                             
                             }
                             
                             }
                             }
                             */
                            
                            
                            
                        }
                        if statusCode == 400{
                            
                            
                            self.view.activityStopAnimating()
                            if let range3 = (self.accInfoModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                self.showAlert(title: Constants.APP_NAME, message: (self.accInfoModel?.message)!)
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
    
    func updateAccountInfo() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken() as String,
                    "first_name":txtFName.text!,
                    "last_name":txtLastName.text!,
                    "password":"123456",
                    "age":txtAge.text!,
                    "gender":txtGender.text!,
                    "email":txtEmail.text!,
                    "id_no":txtIDNo.text!,
                    "address":txtAdderss.text!,
                    "country":String(selectedCountryID),
                    "bank_name":txtBankName.text!,
                    "account_holder":txtBankHName.text!,
                    "account_number":txtBankAcNo.text!,
                    "swift_code":txtBankSwiftCode.text!,
                    "bank_address":txtBankAddress.text!,
                    "bank_book":""
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.UpdateAccountURL
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
                    self.accInfoModel = AccInfoModel(response)
                    print("self.accInfoModel ",self.accInfoModel!)
                    print("self.accInfoModel ",self.accInfoModel?.httpcode!)
                    //print("self.accInfoModel ",self.settingsModel?.settingsModelData)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.accInfoModel?.httpcode)!)
                    if statusCode == 200{
                        
                        let sharedDefault = SharedDefault()
                        if sharedDefault.getLanguage() == 0 {
                            self.showToast(message: self.successMessageEng)
                        } else if sharedDefault.getLanguage() == 1 {
                            self.showToast(message: self.successMessageBur)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            print("btnEditAction")
                            self.txtAge.isEnabled = false
                            self.txtGender.isEnabled = false
                            self.txtIDNo.isEnabled = false
                            
                            self.txtCountry.isEnabled = false
                            self.txtEmail.isEnabled = false
                            self.txtPassword.isEnabled = false
                            self.txtBankAcNo.isEnabled = false
                            self.txtBankSwiftCode.isEnabled = false
                            //self.txtViewBankAddress.isEditable = false
                            self.txtBankHName.isEnabled = false
                            self.txtBankName.isEnabled = false
                            self.txtReferal.isEnabled = false
                            self.btnUpdate.isHidden  = true
                            self.txtAdderss.isEnabled = false
                            self.txtBankAddress.isEnabled = false
                        }
                    }
                    if statusCode == 400{
                        
                        
                        
                        
                        // Changes by Praveen
                        
                        if let range3 = (self.accInfoModel?.message)!.range(of: "The email has already been taken.", options: .caseInsensitive){
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1
                            {
                                    self.showAlert(title: "DRS", message: "အီးမေးလ်ကိုယူထားပြီးဖြစ်သည်")
                            }
                            else  if sharedDefault.getLanguage() == 0
                            {
                                self.showAlert(title: "DRS", message: "The email has already been taken.")
                            }
                        }
                        
                        
                        if let range3 = (self.accInfoModel?.message)!.range(of: "The login id has already been taken.", options: .caseInsensitive){
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1
                            {
                                    self.showAlert(title: "DRS", message: "Login IDကိုယူထားပြီးဖြစ်သည်")
                            }
                            else  if sharedDefault.getLanguage() == 0
                            {
                                self.showAlert(title: "DRS", message: "The login id has already been taken.")
                            }
                        }
                        
                        
                        
                        
                            if let range3 = (self.accInfoModel?.message)!.range(of: "The business contact number has already been taken.", options: .caseInsensitive){
                                let sharedDefault = SharedDefault()
                                if sharedDefault.getLanguage() == 1
                                {
                                        self.showAlert(title: "DRS", message: "စီးပွားရေးအဆက်အသွယ်ဖုန်းနံပါတ်ကိုယူထားပြီးဖြစ်သည်")
                                }
                                else  if sharedDefault.getLanguage() == 0
                                {
                                    self.showAlert(title: "DRS", message: "The business contact number has already been taken.")
                                }
                            }
                               
                        if let range3 = (self.accInfoModel?.message)!.range(of: "The referral id must be valid.", options: .caseInsensitive){
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1
                            {
                                    self.showAlert(title: "DRS", message: "လွှဲပြောင်းသူIDတရားဝင်ဖြစ်ရမည်")
                            }
                            else  if sharedDefault.getLanguage() == 0
                            {
                                self.showAlert(title: "DRS", message: "The referral id must be valid.")
                            }
                        }
                        // Changes by Praveen

                        
                        
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.accInfoModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                if let range3 = (self.accInfoModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
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
    func getAccountInfo() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken() as String
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.AccountInfoURL
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
                    self.accInfoModel = AccInfoModel(response)
                    print("self.accInfoModel ",self.accInfoModel!)
                    print("self.accInfoModel ",self.accInfoModel?.httpcode!)
                    //print("self.accInfoModel ",self.settingsModel?.settingsModelData)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.accInfoModel?.httpcode)!)
                    if statusCode == 200{
                        // self.showToast(message: (self.settingsModel?.message)!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            let url = URL(string: (self.accInfoModel?.accInfoModelData?.generalInfo?.profilePic)!)
                            if url != nil{
                                self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                            }else {
                                //self.imgProfile.image = UIImage(named: "SplashImage")
                            }
                            self.txtFName.text = self.accInfoModel?.accInfoModelData?.generalInfo?.firstName
                            self.txtLastName.text = self.accInfoModel?.accInfoModelData?.generalInfo?.lastName

                            self.txtSName.text = self.accInfoModel?.accInfoModelData?.generalInfo?.lastName
                            self.txtAge.text = self.accInfoModel?.accInfoModelData?.generalInfo?.age
                            self.txtGender.text = self.accInfoModel?.accInfoModelData?.generalInfo?.gender
                            self.txtIDNo.text = self.accInfoModel?.accInfoModelData?.generalInfo?.idNo
                            
                            
                            self.txtCountry.text = self.accInfoModel?.accInfoModelData?.generalInfo?.countryName
                            self.txtEmail.text = self.accInfoModel?.accInfoModelData?.generalInfo?.email
                            self.txtPhone.text = (self.accInfoModel?.accInfoModelData?.generalInfo?.countryCode)! + "-" + (self.accInfoModel?.accInfoModelData?.generalInfo?.phoneNumber)!
                            let myString1 = self.accInfoModel?.accInfoModelData?.generalInfo?.countryCode
                            if myString1!.count>0{
                                let myInt1 = Int(myString1!)
                                self.selectedCountryID = myInt1!
                            }
                            self.txtAdderss.text = self.accInfoModel?.accInfoModelData?.generalInfo?.address
                            
                            
                            self.txtBankAddress.text = self.accInfoModel?.accInfoModelData?.bankInfo?.branchAddress
                            self.txtBankHName.text = self.accInfoModel?.accInfoModelData?.bankInfo?.accountHolder
                            self.txtBankName.text = self.accInfoModel?.accInfoModelData?.bankInfo?.bankName
                            self.txtBankAcNo.text = self.accInfoModel?.accInfoModelData?.bankInfo?.accountNumber
                            self.txtBankSwiftCode.text = self.accInfoModel?.accInfoModelData?.bankInfo?.swiftCode
                            //self.txtViewBankAddress.text = self.accInfoModel?.accInfoModelData?.bankInfo?.branchAddress
                            self.txtReferal.text = self.accInfoModel?.accInfoModelData?.generalInfo?.referalId
                            
                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            //next.srtName = self.validateMobileModelResponse?.validateMobileModelData?.customerName as! String
                            //next.srtPhone = self.validateMobileModelResponse?.validateMobileModelData?.phoneNumber as! String
                            // self.navigationController?.pushViewController(next, animated: true)
                            //self.tableViewBal.reloadData()
                        }
                       
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.accInfoModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.accInfoModel?.message)!)
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
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
