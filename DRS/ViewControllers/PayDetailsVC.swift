//
//  PayDetailsVC.swift
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
import Foundation

class PayDetailsVC: UIViewController,UITextFieldDelegate {
    let sharedDefault = SharedDefault()
    
    var strTitle:String = String()
    var paymentType = String()
    var paymentModel: PaymentModel?
    var btnCashStatus:Bool = false
    var btnWalletStatus:Bool = false
     var maxVal:Int?
    var merchantQRModel:MerchantQRModel?
    var testInc:Int = 0
    @IBOutlet var scrollPaymentDetail: UIScrollView!
    var stringQR = String()
    @IBOutlet var lblShopName: UILabel!
    @IBOutlet var lblSelectPayment: UILabel!
    @IBOutlet var btnWallet: UIButton!
    @IBOutlet var btnCash: UIButton!
    @IBOutlet var viewPayment: UIView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var contentScrollview: UIView!
    @IBOutlet var viewShopName: UIView!
    @IBOutlet var lblAmountValue: UILabel!
    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblRebate: UILabel!
    @IBOutlet var lblRebateValue: UILabel!
    @IBOutlet var lblSlideText: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var viewSlide: UIView!
    @IBOutlet var viewColor: UIView!
    @IBOutlet var lblVoucherPtData: UILabel!
    @IBOutlet var lblVoucher: UILabel!
    @IBOutlet var lblPoins: UILabel!
    
    @IBOutlet var txtAmount: UITextField!
    @IBOutlet var lblPointAvailData: UILabel!
    
    var messageEng = [String]()
    var messageBur = [String]()
    
    func getMessages() {
       /*
         <!--  Payment -->
         <>Invalid access token</user_invalid_access_payment>
         <>success_transcation</user_success_trans>
         <>The merchant id must be a number</user_merch_id_must_no_payment>
         <>The amount field is required.</user_amount_required_payment>
         <>The payment mode field is required</user_pay_code_required>
         <>The payment pin field is required</user_payment_pin_required>
         <>Payment Pin Code mismatch</user_pay_pin_code_mismatch>
         <>failed_transcation</user_file_trans>
         <>Merchant Insufficient Credit</user_merch_insufficient_credit>
         <>Sorry,some thing went wrong.please try again</user_try_later>
         
         */
        let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            
            let xml = try! XML.parse(text)
            messageEng.removeAll()
            if let text = xml.resource.user_invalid_access_payment.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_success_trans.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_merch_id_must_no_payment.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_amount_required_payment.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_pay_code_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_payment_pin_required.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_pay_pin_code_mismatch.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_file_trans.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_merch_insufficient_credit.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_try_later.text {
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
            if let text = xml.resource.user_invalid_access_payment.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_success_trans.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_merch_id_must_no_payment.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_amount_required_payment.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_pay_code_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_payment_pin_required.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_pay_pin_code_mismatch.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_file_trans.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_merch_insufficient_credit.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_try_later.text {
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
                
                if let text = xml.resource.scan_code_payment_detail.text {
                    strTitle = text
                 self.title = strTitle
                    print("strTitle",text)
                }
                if let text = xml.resource.scan_code_select_payment.text {
                    lblSelectPayment.text = text
                    print("text",text)
                }
                if let text = xml.resource.scan_code_cash.text {
                   btnCash.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.scan_code_wallet.text {
                    btnWallet.setTitle(text, for: .normal)
                   print("text",text)
                }
                if let text = xml.resource.scan_code_amount.text {
                   print("text",text)
                    lblAmount.text = text
                }
                if let text = xml.resource.scan_code_rebate_entitled.text {
                   print("text",text)
                    lblRebate.text = text
                }
                if let text = xml.resource.scan_code_slide_rebate_more.text {
                   print("text",text)
                    lblSlideText.text = text
                }
                if let text = xml.resource.scan_code_ur_voucher_pts.text {
                       print("text",text)
                    lblVoucher.text = text
                               }
                if let text = xml.resource.scan_code_pts_avaliable.text {
                   print("scan_code_pts_avaliable",text)
                    lblPoins.text = text
                }
                if let text = xml.resource.scan_code_pts_avaliable.text {
                    print("scan_code_pts_avaliable --------",text)
                }
                if let text = xml.resource.scan_code_submit.text {
                   btnSubmit.setTitle(text, for: .normal)
                }
                
                
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.scan_code_payment_detail.text {
                    strTitle = text
                 self.title = strTitle
                    print("strTitle",text)
                }
                if let text = xml.resource.scan_code_select_payment.text {
                    lblSelectPayment.text = text
                    print("text",text)
                }
                if let text = xml.resource.scan_code_cash.text {
                   btnCash.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.scan_code_wallet.text {
                    btnWallet.setTitle(text, for: .normal)
                   print("text",text)
                }
                if let text = xml.resource.scan_code_amount.text {
                   print("text",text)
                    lblAmount.text = text
                }
                if let text = xml.resource.scan_code_rebate_entitled.text
                {
                   print("text",text)
                    lblRebate.text = text
                }
                if let text = xml.resource.scan_code_slide_rebate_more.text {
                   print("text",text)
                    lblSlideText.text = text
                }
                if let text = xml.resource.scan_code_ur_voucher_pts.text {
                       print("text",text)
                    lblVoucher.text = text
                               }
                if let text = xml.resource.scan_code_pts_avaliable.text {
                   print("text",text)
                    lblPoins.text = text
                }
                if let text = xml.resource.scan_code_submit.text {
                   btnSubmit.setTitle(text, for: .normal)
                }
                
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    //max Length
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 7
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing",textField.text!)
        if textField.text!.count > 0 {
            let myString1 = textField.text!
            let myString11 = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.profitShare)!
            let amtEntered = Float(myString1)
            
            
            let iProfiShare = Float(myString11)!  * 0.01
            
            
            
            let test = amtEntered!*iProfiShare
            print("textFieldDidEndEditing ----- ",test)
            //lblRebateValue.text = String(test) + " " + "MMK"
            
            
            let myString111 = (self.merchantQRModel!.merchantQRModelData?.drsCommission?.cashBack2?.value)!
//
            
            let iValue = Float(myString111)!  * 0.01

            
            let test1 = test * iValue

//            let test1 = test * Int(myString111)!/100
//
//            slider.maximumValue = Float(test1)
            slider.minimumValue = 0
//            //lblVoucherPtData.text = String(test1)
            print("textFieldDidEndEditing ----- ",test)
//
            var iround = Double(test1)

            let remainder1 = iround.truncatingRemainder(dividingBy: 1)
            
            if remainder1 < 0.5
            {
                print("less than 0.5")
            }
           else
            {
                print("more than 0.5")
                
                iround = iround + 1

            }
            maxVal = Int(iround)
            slider.maximumValue = Float(iround)

            lblRebateValue.text = String(Int(iround))
            
            
            
            
        } else {
            slider.maximumValue = 0
            slider.minimumValue = 0
             lblRebateValue.text = "0"
            lblVoucherPtData.text = "0"
              self.lblPointAvailData.text = String((self.merchantQRModel!.merchantQRModelData?.customerQrdata?.vPoints)!)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("stringQR --->", stringQR)
        lblAmountValue.text = ""
        self.changeLanguage()
        self.getMessages()
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        
        
        self.addBackButton()
        
        
        if sharedDefault.getLanguage() == 1
        {
            //print("Bermese")
            lblRebate.text = "ပြန်ရငွေ"
        }
        else if sharedDefault.getLanguage() == 0
        {
            //print("Bermese")
            lblRebate.text = "Rebate Entitled"

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtAmount.delegate = self
        
        txtAmount.layer.cornerRadius = 10
        txtAmount.layer.borderWidth = 1.0
        txtAmount.layer.borderColor = UIColor(red:91.0/255, green:59.0/255, blue:27/255, alpha: 1).cgColor
        
        let paddingViewEmail = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtAmount.frame.height))
        txtAmount.leftView = paddingViewEmail
        txtAmount.leftViewMode = UITextField.ViewMode.always
        
        let paddingViewE = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtAmount.frame.height))
        txtAmount.rightView = paddingViewE
        txtAmount.rightViewMode = UITextField.ViewMode.always
        
        
        self.getPaymentDetails()
        // Do any additional setup after loading the view.
        
        btnWallet.layer.cornerRadius = 15
        btnCash.layer.cornerRadius = 15
        viewPayment.layer.cornerRadius = 25
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        slider.setThumbImage(UIImage(named: "Slide"), for: UIControl.State.normal)
        
        let bgColor = UIColor(red:91.0/255, green:59.0/255, blue:27/255, alpha: 1).cgColor
        lblPointAvailData.layer.borderWidth = 2
        lblPointAvailData.layer.borderColor = bgColor
        
        let bgViewColor = UIColor(red:244.0/255, green:210.0/255, blue:82.0/255, alpha: 1).cgColor
        viewColor.layer.borderWidth = 2
        viewColor.layer.borderColor = bgViewColor
        //(UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0) as! CGColor)
        
        lblVoucherPtData.layer.borderWidth = 1
        lblVoucherPtData.layer.borderColor = bgViewColor
        
        viewSlide.layer.cornerRadius = 25
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        slider.isContinuous = true
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtAmount.inputAccessoryView = numberToolbar

        
        txtAmount.delegate = self
        
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
         txtAmount.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        if txtAmount.text!.count <= 0{
            if sharedDefault.getLanguage() == 0 {
                self.showToast(message: "Enter payment amount")
            } else if sharedDefault.getLanguage() == 1 {
                self.showToast(message: "ငွေပေးချေမှုပမာဏကိုထည့်ပါ")
            }
            
        }
         txtAmount.resignFirstResponder()
    }
    @objc func dismissKeyboard()
    {
        txtAmount.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollPaymentDetail.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollPaymentDetail.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollPaymentDetail.contentInset = contentInset
    }
    
    @IBAction func btnCashAction(_ sender: UIButton) {
        print("btnCashAction")
        paymentType = "cash"
        if btnCashStatus == true {
            btnCash.backgroundColor =  UIColor(red: 69.0/255.0, green: 194.0/255.0, blue: 140.0/255.0, alpha: 1.0)
            btnCashStatus = false
        } else {
            btnCash.backgroundColor =  Constants.textColor
            btnCashStatus = true
        }
         btnWallet.backgroundColor =   UIColor(red: 69.0/255.0, green: 194.0/255.0, blue: 140.0/255.0, alpha: 1.0)
         btnWalletStatus = false
    }
    
    @IBAction func btnWalletAction(_ sender: UIButton) {
        print("btnWalletAction")
        paymentType = "wallet"
        if btnWalletStatus == true {
            btnWallet.backgroundColor =   UIColor(red: 69.0/255.0, green: 194.0/255.0, blue: 140.0/255.0, alpha: 1.0)
            btnWalletStatus = false
        } else {
            btnWallet.backgroundColor =  Constants.textColor
            btnWalletStatus = true
        }
        btnCash.backgroundColor =   UIColor(red: 69.0/255.0, green: 194.0/255.0, blue: 140.0/255.0, alpha: 1.0)
        btnCashStatus = false
        
    }
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        print("btnSubmitAction",paymentType.count)
        
        if paymentType.count<=0 {
             
            if sharedDefault.getLanguage() == 0 {
                showToast(message: "Select payment")
            } else if sharedDefault.getLanguage() == 1 {
                self.showToast(message: "ငွေပေးချေမှုကိုရွေးချယ်ပါ")
            }
            return
        } else if paymentType == "cash" {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailOTPVC") as! PaymentDetailOTPVC
            
            next.strShopName = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.businessName)!
            next.strAmt = txtAmount.text!
            next.strMerchantID = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.merchantId)!
            next.strPaymentMode = paymentType
            next.strUsedVP = lblVoucherPtData.text!
            next.strProfitShare = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.profitShare)!
            
            self.navigationController?.pushViewController(next, animated: true)
        } else if paymentType == "wallet" {
            self.initiatePayment()
            
        }
        
        
        
        //
    }
    @IBAction func slideValueChangedAction(_ sender: UISlider) {
        let strvPoint = (self.merchantQRModel!.merchantQRModelData?.customerQrdata?.vPoints)!
        let point = Int(strvPoint)
        
       
//        if point > 0 {
            if txtAmount.text!.count>0
            {
                // print("slideValueChangedAction ----- ", Int(slider.value))
                 
                 var a:Int? = Int(txtAmount.text!)
                 var b:Double? = Double(lblRebateValue.text!)
                 if a! > 0 && b! == 0
                 {
                     txtAmount.resignFirstResponder()
                     if txtAmount.text!.count > 0
                     {
                         let myString1 = txtAmount.text!
                         let myString11 = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.profitShare)!
                         let amtEntered = Float(myString1)
//                         let test = amtEntered!*Int(myString11)!/100
                        
                        
                        let iProfiShare = Float(myString11)!  * 0.01
                        let test = amtEntered!*iProfiShare

                         print("Slider Value Changed ----- ",test)
                        
                         let myString111 = (self.merchantQRModel!.merchantQRModelData?.drsCommission?.cashBack2?.value)!
                         
                        let iValue = Float(myString111)!  * 0.01

                        let test1 = test * iValue

//                         let test1 = test * Int(myString111)!/100
                         
                         
                         
                         print("Slider Value Changed ----- ",test1)
                        print("textFieldDidEndEditing ----- ",test)
                        
                        var iround = Double(test1)

                        let remainder1 = iround.truncatingRemainder(dividingBy: 1)
                        
                        if remainder1 < 0.5
                        {
                            print("less than 0.5")
                        }
                       else
                        {
                            print("more than 0.5")
                            
                            iround = iround + 1

                        }
                        slider.maximumValue = Float(iround)
                        slider.minimumValue = 0
                        
                        lblRebateValue.text = String(Int(iround))
                        
                     }
                     
                     
                     else
                     {
                         slider.maximumValue = 0
                         slider.minimumValue = 0
                          lblRebateValue.text = "0"
                         lblVoucherPtData.text = "0"
                           self.lblPointAvailData.text = String((self.merchantQRModel!.merchantQRModelData?.customerQrdata?.vPoints)!)
                     }
                 }
                 lblVoucherPtData.text = String(Int(slider.value))
                 
                 if testInc > Int(slider.value)
                 {
                     print(">  less  ")
                     print("slideValueChangedAction 22----- ", Int(slider.value))
                    
                     let temp = Int(lblPointAvailData.text!)
                     let tempV = temp! + Int( (self.merchantQRModel!.merchantQRModelData?.drsCommission?.ratePerVoucherPoint?.value)!)!
                     lblPointAvailData.text = String(tempV)
                     print("tempV -- ",tempV)
                     let rebat = Int(lblRebateValue.text!)
                     //rebat + Int(slider.value)
                     lblRebateValue.text = String(rebat! - Int( (self.merchantQRModel!.merchantQRModelData?.drsCommission?.ratePerVoucherPoint?.value)!)!)
                     if Int(slider.value) == 0
                     {
                         let myString1 = txtAmount.text!
                          let myString11 = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.profitShare)!
                          let amtEntered = Float(myString1)
                        
                        let iProfiShare = Float(myString11)!  * 0.01

                        
//                          let test = amtEntered!*Int(myString11)!/100
                        
                        let test = amtEntered!*iProfiShare

                          print("slideValueChangedAction 22----- ",test)
                         
                          let myString111 = (self.merchantQRModel!.merchantQRModelData?.drsCommission?.cashBack2?.value)!
                          
                        let iValue = Float(myString111)!  * 0.01

                        let test1 = test * iValue

//                          let test1 = test * Int(myString111)!/100
                          
//                          slider.maximumValue = Float(test1)
                          slider.minimumValue = 0
//                         lblRebateValue.text = String(Int(test1))
                        
                        
                        print("textFieldDidEndEditing ----- ",test)
            //
                        var iround = Double(test1)

                        let remainder1 = iround.truncatingRemainder(dividingBy: 1)
                        
                        if remainder1 < 0.5
                        {
                            print("less than 0.5")
                        }
                       else
                        {
                            print("more than 0.5")
                            
                            iround = iround + 1

                        }
                        
                        slider.maximumValue = Float(iround)

                        lblRebateValue.text = String(Int(iround))
                        
                        
                        
                         self.lblPointAvailData.text = String((self.merchantQRModel!.merchantQRModelData?.customerQrdata?.vPoints)!)
                     }
                     
                 }
                 else if testInc < Int(slider.value)
                 {
                      print("slideValueChangedAction 22----- ", Int(slider.value))
                     print("  greater  ")
                     let temp = Int(lblPointAvailData.text!)
                     let tempV = temp! - Int( (self.merchantQRModel!.merchantQRModelData?.drsCommission?.ratePerVoucherPoint?.value)!)!
                     lblPointAvailData.text = String(tempV)
                     print("tempV ++ ",tempV)
                     
                     let rebat = Int(lblRebateValue.text!)
                     //rebat + Int(slider.value)
                     lblRebateValue.text = String(rebat! + Int( (self.merchantQRModel!.merchantQRModelData?.drsCommission?.ratePerVoucherPoint?.value)!)!)
                     if Int(slider.value) == maxVal
                     {
                         let myString1 = txtAmount.text!
                          let myString11 = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.profitShare)!
//                          let amtEntered = Int(myString1)
                        
                        let amtEntered = Float(myString1)

                        let iProfiShare = Float(myString11)!  * 0.01

                        
                        
                        let test = amtEntered!*iProfiShare
                          print("textFieldDidEndEditing ----- ",test)
                         
                          let myString111 = (self.merchantQRModel!.merchantQRModelData?.drsCommission?.cashBack2?.value)!
                        let iValue = Float(myString111)!  * 0.01

//                          let test1 = test * Int(myString111)!/100
                        
                        let test1 = test * iValue

                          
//                          slider.maximumValue = Float(test1)
                          slider.minimumValue = 0
                        
                        var iround = Double(test1)

                        let remainder1 = iround.truncatingRemainder(dividingBy: 1)
                        
                        if remainder1 < 0.5
                        {
                            print("less than 0.5")
                        }
                       else
                        {
                            print("more than 0.5")
                            
                            iround = iround + 1

                        }
                        slider.maximumValue = Float(iround)

                          lblRebateValue.text = String(Int(iround+Double(maxVal!)))
                         self.lblPointAvailData.text = String(((self.merchantQRModel!.merchantQRModelData?.customerQrdata?.vPoints)! - maxVal!))
                     }
                 }
                 
                 let temp = Double(lblRebateValue.text!)! + Double(slider.value)
                 
                 
                 testInc = Int(slider.value)
             } else {
                slider.value = 0
            }
//        } else {
//            slider.value = 0
//
//            if sharedDefault.getLanguage() == 0 {
//                self.showToast(message: "Please buy voucher points")
//            } else if sharedDefault.getLanguage() == 1 {
//                self.showToast(message: "ကျေးဇူးပြု၍ ဘောက်ချာကိုဝယ်ပါ")
//            }
//
//        }
   
        
    }
    
    func getPaymentDetails() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "qr_code":stringQR
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.MerchantQRDetailURL
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
                    //96TAQul3YG
                    let response = JSON(data.data!)
                    self.merchantQRModel = MerchantQRModel(response)
                    print("self.merchantQRModel ",self.merchantQRModel!)
                    print("self.merchantQRModel ",self.merchantQRModel?.httpcode!)
                    
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.merchantQRModel?.httpcode)!)
                    if statusCode == 200{
                        //print("self.merchantQRModel ",self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.businessName)
                        self.lblShopName.text = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.businessName)!
                        self.lblPointAvailData.text = String((self.merchantQRModel!.merchantQRModelData?.customerQrdata?.vPoints)!)
                        //self.lblPointAvailData.text = "0"
                        self.lblVoucherPtData.text = "0"
                        
                        
                    }
                    if statusCode == 400{
                        
                        if let range3 = (self.merchantQRModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            
                        } else
                        {
//                            self.showAlert(title: Constants.APP_NAME, message: (self.merchantQRModel?.message)!)
                            
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1
                            {
                                self.showToast(message:Constants.InvalidPaymentCodeBur )
                            }
                            else  if sharedDefault.getLanguage() == 0
                            {
                                self.showToast(message:Constants.InvalidPaymentCodeEng )
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
    
    func initiatePayment() {
        /*
         next.strShopName = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.businessName)!
         next.strAmt = txtAmount.text!
         next.strMerchantID = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.merchantId)!
         next.strPaymentMode = paymentType
         next.strUsedVP = lblVoucherPtData.text!
         lblVoucherPtData.text!
         next.strProfitShare = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.profitShare)!
         */
           let sharedData = SharedDefault()
           self.view.activityStartAnimating()
           var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                       "merchant_id":(self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.merchantId)!,
                       "payment_pin":"",
                       "amount":txtAmount.text!,
                       "payment_mode":paymentType,
                       "used_vp":lblVoucherPtData.text!,
                       "profit_share":(self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.profitShare)!
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
                       print("self.paymentModel ",self.paymentModel?.httpcode!)
                     
                    print("self.action ",String((self.paymentModel?.paymentModelData?.action!)!))
                      
                       let statusCode = Int((self.paymentModel?.httpcode)!)
                       if statusCode == 200{
                       
                        if self.paymentModel!.paymentModelData?.action == "failed_transcation"
                        {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
                            next.errorHead = (self.paymentModel!.message)!
                            next.errorMessage = "Unable to proceed, " + (self.paymentModel!.paymentModelData?.failedReason)!
                             print("self.errorMessage ",(self.paymentModel!.paymentModelData?.failedReason)!)
                            next.errorStatus = true
                            next.walletErrorMessages = true
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        else if self.paymentModel!.paymentModelData?.action == "success_transcation" {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                                let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
                                
                                next.strTotal = String((self.paymentModel!.paymentModelData?.transactionData?.amount!)!)
                                next.strDateTime = String((self.paymentModel!.paymentModelData?.transactionData?.date!)!)
                                next.strTransID = String((self.paymentModel!.paymentModelData?.transactionData?.tranId!)!)
                                next.strUserID = String((self.paymentModel!.paymentModelData?.transactionData?.userId!)!)
                                next.strRebate = String((self.paymentModel!.paymentModelData?.transactionData?.rebate!)!)
                                next.strMerchantName = (self.merchantQRModel!.merchantQRModelData?.merchantQrdata?.businessName)!
                                next.errorStatus = false
                                self.navigationController?.pushViewController(next, animated: true)
                            }
                        }
                        //self.navigationController?.popToRootViewController(animated: true)
                           
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
                            
                        } else {
                            let sharedDefault = SharedDefault()
                            for index in 0..<self.messageEng.count {
                                if let range3 = (self.paymentModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
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
extension Double {
    /// Convert `Double` to `Decimal`, rounding it to `scale` decimal places.
    ///
    /// - Parameters:
    ///   - scale: How many decimal places to round to. Defaults to `0`.
    ///   - mode:  The preferred rounding mode. Defaults to `.plain`.
    /// - Returns: The rounded `Decimal` value.

    func roundedDecimal(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var decimalValue = Decimal(self)
        var result = Decimal()
        NSDecimalRound(&result, &decimalValue, scale, mode)
        return result
    }
}


extension Decimal {
    var formattedAmount: String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self as NSDecimalNumber)
    }
}

extension Formatter {
    static let stringFormatters: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
}
extension Decimal {
    var formattedString: String {
        return Formatter.stringFormatters.string(for: self) ?? ""
    }
}
