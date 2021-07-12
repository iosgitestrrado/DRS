//
//  TopUpWalletVC.swift
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

class TopUpWalletVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var lblMinAmt: UILabel!
    var strLblText:String = ""
    var strTitle:String = String()
    @IBOutlet weak var lblOkDollar: UILabel!
    @IBOutlet var lblBankName: UILabel!
     var strMinAmt:String = ""
    @IBOutlet var lblAccount: UILabel!
    var btnOKDollarStatus:Bool = false
    var btnVisaStatus:Bool = false
    var btnKBZStatus:Bool = false
    var btnOneStatus:Bool = false
    var btnDrsStatus:Bool = false
    @IBOutlet var btnRadionOkDollar: UIButton!
    @IBOutlet var btnRadioVisa: UIButton!
    @IBOutlet var btnRadioKBZPay: UIButton!
    @IBOutlet var btnRadioOnePAy: UIButton!
    @IBOutlet var btnRadioDrsPay: UIButton!
    
    @IBOutlet weak var lblUploadReciept: UILabel!
    @IBOutlet weak var lblOffLine: UILabel!
    @IBOutlet weak var lblSelectPaymentM: UILabel!
    
    var firstImgData:String = String()
    var paymentType:String = String()
    @IBOutlet var txtAmount: UITextField!
    var topupModel: TopupModel?
    var topupPaymentModel: TopupPaymentModel?
    var oKDollarModel: OKDollarModel?
    
    
    let sharedData = SharedDefault()
    @IBOutlet weak var leadingCollection: NSLayoutConstraint!
    @IBOutlet weak var trailingCollection: NSLayoutConstraint!
    @IBOutlet var viewDRSPay: UIView!
    @IBOutlet var viewOnePay: UIView!
    @IBOutlet var viewKZPay: UIView!
    @IBOutlet var viewOkRadio: UIView!
    @IBOutlet var viewVisaRadio: UIView!
    @IBOutlet var collectionHeight: NSLayoutConstraint!
    @IBOutlet var btnCheckOfflineTop: UIButton!
    @IBOutlet var btnCheckOffline: UIButton!
    @IBOutlet var viewCheckOffline: UIView!
    @IBOutlet weak var btnWalletHistory: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var viewBankDetail: UIView!
    @IBOutlet weak var viewOfflineTrans: UIView!
    @IBOutlet weak var viewUpload: UIView!
    @IBOutlet weak var viewAcNo: UIView!
    @IBOutlet weak var viewBank: UIView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var collectionTopUP: UICollectionView!
    var messageEng = [String]()
    var messageBur = [String]()
    var rechargeSuccessEng:String = ""
    var rechargeSuccessBur:String = ""
    var offlineBankTransStatus:Bool = false
    
    let reuseIdentifier = "TopUpCollectionCell"
    var itemAmount:[WalletAmounts] = []
    var items = ["5,000 MMK", "10,000 MMK", "20,000 MMK","50,000 MMK", "100,000 MMK", "200,000 MMK"]
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.itemAmount.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionTopUP {
            let topupCell = collectionTopUP.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TopUpCollectionCell
            topupCell.lblAmt.text = self.itemAmount[indexPath.row].title
            topupCell.viewCollectionBG.layer.cornerRadius = 10
            topupCell.viewCollectionBG.clipsToBounds = true
            if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
                topupCell.cellWidth.constant = 110
                
                
            }
            cell = topupCell
            
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if collectionView == collectionTopUP {
            let amount:Int = self.itemAmount[indexPath.item].amount!
            
            txtAmount.text =  String(amount)
            
            
        }
    }
    func getMessages() {
        
        
        /*
         <!-- Wallet Topup Payment -->
         <>Invalid access token</user_invalid_access_wallet>
         <>Wallet topup success , amount will be added after verification.</user_topup_success>
         <>please finish payment with okdollar</user_finish_payment_ok_dollar>
         <>The bank receipt field is required</user_bank_receipt_required_wallet>
         <>The amount field is required</user_amount_required_wallet>
         <>The payment type field is required.</user_payment_required>
         
         */
       
        let path = Bundle.main.path(forResource: "MessageEng", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            
            let xml = try! XML.parse(text)
            messageEng.removeAll()
            if let text = xml.resource.user_invalid_access_wallet.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_topup_success.text {
                messageEng.append(text)
                print(text)
                rechargeSuccessEng = text
            }
            if let text = xml.resource.user_finish_payment_ok_dollar.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_bank_receipt_required_wallet.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_amount_required_wallet.text {
                messageEng.append(text)
                print(text)
            }
            if let text = xml.resource.user_payment_required.text {
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
            if let text = xml.resource.user_invalid_access_wallet.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_topup_success.text {
                messageBur.append(text)
                rechargeSuccessBur = text
                print(text)
            }
            if let text = xml.resource.user_finish_payment_ok_dollar.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_bank_receipt_required_wallet.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_amount_required_wallet.text {
                messageBur.append(text)
                print(text)
            }
            if let text = xml.resource.user_payment_required.text {
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
           strLblText = ""
           if sharedDefault.getLanguage() == 1 {
               print("Bermese")
               
               let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Top_Up_Wallet_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
//                if let text = xml.resource.Top_Up_Wallet_enter_ur_pre_amt.text
//                {
//                    txtAmount.placeholder = "သင်နှစ်သက်သောငွေပမာဏကိုထည့်ပါ"
//                }
                
                txtAmount.placeholder = "သင်နှစ်သက်သောငွေပမာဏကိုထည့်ပါ"

                if let text = xml.resource.Top_Up_Wallet_min_top_amt.text {
                    strLblText = text
                }
                
                if let text = xml.resource.Top_Up_Wallet_select_payment.text {
                    lblSelectPaymentM.text = text
                }
                
                if let text = xml.resource.Top_Up_Wallet_ok_dollar.text {
                    lblOkDollar.text = text
                }
                if let text = xml.resource.Top_Up_Wallet_offline_bank_transfer.text {
                    lblOffLine.text = text
                }
                if let text = xml.resource.Top_Up_Wallet_submit.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Top_Up_Wallet_upload.text {
                    btnUpload.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.Top_Up_Wallet_upload_receipt.text {

                    lblUploadReciept.text = text

                }
                if let text = xml.resource.Top_Up_Wallet_wallet.text {
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnWalletHistory.setAttributedTitle(buttonTitleStr, for: .normal)
                    
                    //print("text",text)
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
                   if let text = xml.resource.Top_Up_Wallet_Title.text {
                       strTitle = text
                       self.title = strTitle
                   }
//                   if let text = xml.resource.Top_Up_Wallet_enter_ur_pre_amt.text {
//                    txtAmount.placeholder = "Enter your preferred amount"
//                   }
                txtAmount.placeholder = "Enter your preferred amount"

                   if let text = xml.resource.Top_Up_Wallet_min_top_amt.text {
                       strLblText = text
                   }
                   
                   if let text = xml.resource.Top_Up_Wallet_select_payment.text {
                       lblSelectPaymentM.text = text
                   }
                   
                   if let text = xml.resource.Top_Up_Wallet_ok_dollar.text {
                       lblOkDollar.text = text
                   }
                   if let text = xml.resource.Top_Up_Wallet_offline_bank_transfer.text {
                       lblOffLine.text = text
                   }
                if let text = xml.resource.Top_Up_Wallet_submit.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.Top_Up_Wallet_upload.text {
                    btnUpload.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Top_Up_Wallet_upload_receipt.text {

                    lblUploadReciept.text = text

                }
                if let text = xml.resource.Top_Up_Wallet_wallet.text {
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnWalletHistory.setAttributedTitle(buttonTitleStr, for: .normal)
                    
                    print("text",text)
                }
                
                
                   
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Top Up Wallet"
        self.addBackButton()
        viewOkRadio.layer.cornerRadius = viewOkRadio.frame.size.height/2
        viewVisaRadio.layer.cornerRadius = viewVisaRadio.frame.size.height/2
        viewOkRadio.clipsToBounds = true
        viewVisaRadio.clipsToBounds = true
        viewCheckOffline.layer.cornerRadius = viewCheckOffline.frame.size.height/2
        viewCheckOffline.clipsToBounds = true
        viewCheckOffline.layer.borderWidth = 2
        viewCheckOffline.layer.borderColor = UIColor.white.cgColor
        
        viewDRSPay.layer.cornerRadius = viewDRSPay.frame.size.height/2
        viewDRSPay.clipsToBounds = true
        viewOnePay.layer.cornerRadius = viewOnePay.frame.size.height/2
        viewOnePay.clipsToBounds = true
        viewKZPay.layer.cornerRadius = viewKZPay.frame.size.height/2
        viewKZPay.clipsToBounds = true
        
        
        
        viewAcNo.layer.cornerRadius = viewAcNo.frame.size.height/2
        viewUpload.layer.cornerRadius = viewUpload.frame.size.height/2
        viewBank.layer.cornerRadius = viewBank.frame.size.height/2
        btnUpload.layer.cornerRadius = 5
        viewOfflineTrans.layer.cornerRadius = 15
        viewBankDetail.layer.cornerRadius = 15
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        txtAmount.delegate = self
        txtAmount.backgroundColor = UIColor.white
        self.changeLanguage()
        self.getMessages()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let layout = collectionTopUP.collectionViewLayout as? UICollectionViewFlowLayout
        if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
            layout?.minimumLineSpacing = 5
            layout?.minimumInteritemSpacing = -8
            leadingCollection.constant = 5
            trailingCollection.constant = 5
            
        }
        if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
           layout?.minimumLineSpacing = 5
            layout?.minimumInteritemSpacing = 5
            leadingCollection.constant = 15
            trailingCollection.constant = 15
            
            
        }
       
        
        self.getTopAmount()
        
        /*
        paymentType = "bank_transfer"
        offlineBankTransStatus = true
        btnCheckOffline.backgroundColor = UIColor.white
        
        btnRadioKBZPay.backgroundColor = Constants.textColor
        btnRadionOkDollar.backgroundColor = Constants.textColor
        btnRadioVisa.backgroundColor = Constants.textColor
        
        btnRadioOnePAy.backgroundColor = Constants.textColor
        btnRadioDrsPay.backgroundColor = Constants.textColor
        
        btnOKDollarStatus = false
        btnVisaStatus = false
        btnKBZStatus = false
        btnOneStatus = false
        btnDrsStatus = false
        */
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
            tap.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tap)
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtAmount.inputAccessoryView = numberToolbar

            
        }
    
    @objc func cancelNumberPad() {
        //Cancel with number pad
        self.txtAmount.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
         self.txtAmount.resignFirstResponder()
    }
        @objc func dismissKeyboard()
        {
             self.txtAmount.resignFirstResponder()
        }
    
    
    // MARK: - Textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    @IBAction func btnChkOfflineTopAction(_ sender: Any) {
        paymentType = "bank_transfer"
        if offlineBankTransStatus == false {
            offlineBankTransStatus = true
            btnCheckOffline.backgroundColor = UIColor.white
            
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
            
            btnOKDollarStatus = false
            btnVisaStatus = false
            btnKBZStatus = false
            btnOneStatus = false
            btnDrsStatus = false
        } else if offlineBankTransStatus == true
        {
            offlineBankTransStatus = false
            btnCheckOffline.backgroundColor = .clear
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
            
            btnOKDollarStatus = false
            btnVisaStatus = false
            btnKBZStatus = false
            btnOneStatus = false
            btnDrsStatus = false
        }
        
        
    }
    @IBAction func btnWalletHistoryAction(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletHistoryVC") as! WalletHistoryVC
        self.navigationController?.pushViewController(next, animated: true)
        
        
        
    }
    @IBAction func btnUploadAction(_ sender: UIButton) {
        print("btnUploadAction")
        txtAmount.resignFirstResponder()
        self.showAlert()
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork() {
            if txtAmount.text!.count>0 {
            
                 if paymentType == "bank_transfer" {
                    
                    let txtAmountEntered = Int(txtAmount.text!)
                    let txtMinAmt = Int(strMinAmt)
                    
                    if txtAmountEntered! < txtMinAmt!  {
                        if sharedData.getLanguage() == 0 {
                            showToast(message: "Enter amount greater than minimum amount")
                        } else if sharedData.getLanguage() == 1 {
                            showToast(message: "အနည်းဆုံးငွေပမာဏထက်သာ။ ကြီးမြတ်ပမာဏကိုရိုက်ထည့်ပါ")
                        }
                        
                        return
                    }
                    
                    if firstImgData.count<=0{
                        
                        if sharedData.getLanguage() == 0 {
                            showToast(message: "Upload bank receipt")
                        } else if sharedData.getLanguage() == 1 {
                            showToast(message: "ဘဏ်ငွေလက်ခံဖြတ်ပိုင်း")
                        }
                    } else{
                        self.offlineTransfer(amount: txtAmount.text!,paymentType: paymentType)
                        firstImgData = ""
                        offlineBankTransStatus = false
                    }
                    
                 } else if paymentType == "ok_dollar" {
                    self.okDollarPayment(amount: txtAmount.text!,paymentType: paymentType)
                 } else {
                    if sharedData.getLanguage() == 0 {
                        showToast(message: "Please select payment option")
                    } else if sharedData.getLanguage() == 1 {
                        showToast(message: "ကျေးဇူးပြု၍ ငွေပေးချေမှုကိုရွေးပါ")
                    }
                }
                 
                
            } else {
                if sharedData.getLanguage() == 0 {
                    showToast(message: "Enter recharge amount")
                } else if sharedData.getLanguage() == 1 {
                    showToast(message: "အားသွင်းငွေပမာဏကိုရိုက်ထည့်ပါ")
                }
                
            }
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
    }
    
    @IBAction func btnKBZPayAction(_ sender: Any) {
        paymentType = "kbz_pay"
        offlineBankTransStatus = false
        
        if btnKBZStatus == false {
            btnKBZStatus = true
            btnRadioKBZPay.backgroundColor = UIColor.white
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
        } else if btnKBZStatus == true
        {
            
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
            
            btnOKDollarStatus = false
            btnVisaStatus = false
            btnKBZStatus = false
            btnOneStatus = false
            btnDrsStatus = false
        }
    }
    @IBAction func btnVisaAction(_ sender: Any) {
        paymentType = "card"
        offlineBankTransStatus = false
        if btnVisaStatus == false {
            btnVisaStatus = true
            btnRadioVisa.backgroundColor = UIColor.white
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
        } else if btnVisaStatus == true
        {
            
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
            
            btnOKDollarStatus = false
            btnVisaStatus = false
            btnKBZStatus = false
            btnOneStatus = false
            btnDrsStatus = false
        }
    }
    
    @IBAction func btnOnePayAction(_ sender: Any) {
        paymentType = "one_pay"
        offlineBankTransStatus = false
        if btnOneStatus == false {
            btnOneStatus = true
            btnRadioOnePAy.backgroundColor = UIColor.white
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioVisa.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
        } else if btnOneStatus == true
        {
            
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
            
            btnOKDollarStatus = false
            btnVisaStatus = false
            btnKBZStatus = false
            btnOneStatus = false
            btnDrsStatus = false
        }
    }
    
    @IBAction func btnDrsPayAction(_ sender: Any) {
        paymentType = "drs_pay"
        offlineBankTransStatus = false
        if btnDrsStatus == false {
            btnDrsStatus = true
            btnRadioDrsPay  .backgroundColor = UIColor.white
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioVisa.backgroundColor = Constants.textColor
            btnRadioOnePAy.backgroundColor = Constants.textColor
        } else if btnDrsStatus == true
        {
            
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
            
            btnOKDollarStatus = false
            btnVisaStatus = false
            btnKBZStatus = false
            btnOneStatus = false
            btnDrsStatus = false
        }
    }
    @IBAction func btnOkDoller(_ sender: Any) {
        paymentType = "ok_dollar"
        offlineBankTransStatus = false
        
        if btnOKDollarStatus == false {
            btnOKDollarStatus = true
            btnRadionOkDollar .backgroundColor = UIColor.white
            btnRadioDrsPay.backgroundColor = Constants.textColor
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioVisa.backgroundColor = Constants.textColor
            btnRadioOnePAy.backgroundColor = Constants.textColor
        } else if btnOKDollarStatus == true
        {
            
            btnRadioKBZPay.backgroundColor = Constants.textColor
            btnRadionOkDollar.backgroundColor = Constants.textColor
            btnRadioVisa.backgroundColor = Constants.textColor
            btnCheckOffline.backgroundColor = .clear
            btnRadioOnePAy.backgroundColor = Constants.textColor
            btnRadioDrsPay.backgroundColor = Constants.textColor
            
            btnOKDollarStatus = false
            btnVisaStatus = false
            btnKBZStatus = false
            btnOneStatus = false
            btnDrsStatus = false
        }
    }
    
    func getTopAmount() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken()]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.WalletTopUPAmtURL
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
                    self.topupModel = TopupModel(response)
                    print("self.topupModel ",self.topupModel!)
                    //print("self.topupModel ",self.topupModel?.httpcode!)
                    //print("self.topupModel ",self.topupModel?.topupModelData?.walletAmounts!)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.topupModel?.httpcode)!)
                    if statusCode == 200{
                        self.itemAmount = (self.topupModel?.topupModelData?.walletAmounts)!
                        //print("itemamount",self.itemAmount[0].title!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            self.strMinAmt = (self.topupModel?.topupModelData?.minTopupAmount)!
                            
                            self.lblMinAmt.text = self.strLblText + (self.topupModel?.topupModelData?.minTopupAmount)! + " " + (self.topupModel?.topupModelData?.currency)!
                            self.collectionTopUP.reloadData()
                            self.lblBankName.text = (self.topupModel?.topupModelData?.drsBankDat?.bankName)!
                            self.lblAccount.text = (self.topupModel?.topupModelData?.drsBankDat?.accountNumber)!
                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                            //self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.topupModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.topupModel?.message)!)
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
            print(asset?.value(forKey: "filename") as Any)
        }
        let pImage = info[UIImagePickerController.InfoKey.originalImage]
        let timage:UIImage = (pImage as? UIImage)!
        firstImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.5)!)!)
        
        
        
        // btnProfilePic.setImage(pImage as? UIImage, for: .normal)
        //updateDetails["avatar"] = convertImageToBase64(image: ((pImage as? UIImage)!))
        dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
         self.view.activityStartAnimating()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.view.activityStopAnimating()
        }
    }
    func okDollarPayment(amount: String,paymentType:String) {
        print("okDollarPayment")
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "amount":amount,
                    "payment_type":paymentType,
                    "bank_receipt":firstImgData
        ]
        
        // print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.TopupPaymentURL
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
                    self.oKDollarModel = OKDollarModel(response)
                    //print("self.oKDollarModel ",self.oKDollarModel!)
                    //print("self.oKDollarModel ",self.oKDollarModel?.httpcode!)
                    // print("self.topupPaymentModel ",self.validateMobileModelResponse?.validateMobileModelData)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.oKDollarModel?.httpcode)!)
                    if statusCode == 200{
                        //self.showToast(message: (self.oKDollarModel?.message)!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                           
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "OKDollarVC") as! OKDollarVC
                            next.urlString = (self.oKDollarModel!.oKDollarModelData?.okdollarData?.postUrl)!
                            next.dataToSend = (self.oKDollarModel!.oKDollarModelData?.okdollarData?.requestToJson)!
                             self.navigationController?.pushViewController(next, animated: true)
                        }
                    }
                    if statusCode == 400{
                       
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.oKDollarModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                if let range3 = (self.oKDollarModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
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
    
    func offlineTransfer(amount: String,paymentType:String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "amount":amount,
                    "payment_type":paymentType,
                    "bank_receipt":firstImgData
        ]
        
        // print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.TopupPaymentURL
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
                    self.topupPaymentModel = TopupPaymentModel(response)
                    //print("self.topupPaymentModel ",self.topupPaymentModel!)
                    //print("self.topupPaymentModel ",self.topupPaymentModel?.httpcode!)
                    // print("self.topupPaymentModel ",self.validateMobileModelResponse?.validateMobileModelData)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.topupPaymentModel?.httpcode)!)
                    if statusCode == 200{
                        let sharedDefault = SharedDefault()
                        if sharedDefault.getLanguage() == 0 {
                            self.showToast(message: self.rechargeSuccessEng)
                        } else if sharedDefault.getLanguage() == 1 {
                            self.showToast(message: self.rechargeSuccessBur)
                        }
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            //self.navigationController?.popViewController(animated: true)
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "WalletHistoryVC") as! WalletHistoryVC
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.topupPaymentModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                if let range3 = (self.topupPaymentModel?.message)!.range(of: self.messageEng[index], options: .caseInsensitive){
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
