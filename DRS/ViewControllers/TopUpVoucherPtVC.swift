//
//  TopUpVoucherPtVC.swift
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
class TopUpVoucherPtVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var lblSelectP: UILabel!
    @IBOutlet weak var lblOffBank: UILabel!
    @IBOutlet weak var lblDollar: UILabel!
    var oKDollarModel: OKDollarModel?
    var strTitle:String = ""
    @IBOutlet var viewT: UIView!
    @IBOutlet var viewS: UIView!
    @IBOutlet var viewf: UIView!
    var selectedIndexPath: IndexPath?
    var boolSelected: Bool = false
    let sharedDefault = SharedDefault()
    
    var signUpModel: SignUpModel?
    var topupPaymentModel: TopupPaymentModel?
    
    @IBOutlet weak var lblUploadReciept: UILabel!
    @IBOutlet var imgWidthConstatnt: NSLayoutConstraint!
    var offlineBankTransStatus:Bool = false
    var btnOKDollarStatus:Bool = false
    var btnVisaStatus:Bool = false
    var btnKBZStatus:Bool = false
    var btnOneStatus:Bool = false
    var btnDrsStatus:Bool = false
    @IBOutlet var btnRadionOkDollar: UIButton!
    @IBOutlet var btnRadioVisa: UIButton!
    @IBOutlet var btnRadioKBZPay: UIButton!
    @IBOutlet var btnRadioOnePAy: UIButton!
    @IBOutlet var btnCheckOffline: UIButton!
    @IBOutlet var btnRadioDrsPay: UIButton!
    
    var selectedID:String = String()
    var selectedAmount:String = String()
    var firstImgData:String = String()
    var paymentType:String = ""
    
    var selectedValue = [Int]()
    var topUpVoucherModel: TopUpVoucherModel?
    let sharedData = SharedDefault()
    let reuseIdentifier = "CollectionTopUpVoucherPtCell"
    
    @IBOutlet var lblBankAcc: UILabel!
    @IBOutlet var lblBankName: UILabel!
    @IBOutlet var viewRadioVisa: UIView!
    @IBOutlet var viewBankDet: UIView!
    
    @IBOutlet var viewOfflineHead: UIView!
    @IBOutlet var viewRadionDRSPay: UIView!
    @IBOutlet var viwRadioOnePay: UIView!
    @IBOutlet var viewRadioKBZPay: UIView!
    @IBOutlet var viewRadioOKDollar: UIView!
    
    @IBOutlet var btnUpload: UIButton!
    
    @IBOutlet var btnVPtHistory: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var viewRadioOffline: UIView!
    @IBOutlet weak var collectionTopUpPoints: UICollectionView!
    var items = ["7,500VP + 750VP", "20,000VP + 2,000VP", "75,000VP + 7,500VP","150,000VP + 15,000VP"]
    var itemsSec = ["5,000 MMK", "10,000 MMK", "30,000 MMK","50,000 MMK"]
    var itemsImg = ["voucher1", "voucher2", "voucher3","voucher4"]
    var itemAmount:[VoucherList] = []
    // tell the collection view how many cells to make
    /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     let cell = collectionView.cellForItem(at: indexPath)
     
     cell!.layer.backgroundColor = UIColor.black as! CGColor
     
     self.selectedIndexPath = indexPath
     }
     */
    
    //@IBOutlet weak var lblOffBank: UILabel!
    
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_pt_title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_pt_payment.text {
                    lblSelectP.text = text
                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_ok_dollar.text {
                    lblDollar.text = text
                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_submit.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Top_Up_Wallet_upload.text {
                    btnUpload.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.Top_Up_Wallet_upload_receipt.text {

                    lblUploadReciept.text = text

                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_pt_history.text {
                    
                    
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnVPtHistory.setAttributedTitle(buttonTitleStr, for: .normal)
                }
                
                
                
                if let text = xml.resource.Top_Up_Wallet_offline_bank_transfer.text {
                    lblOffBank.text = text
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
                
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_pt_title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_pt_payment.text {
                    lblSelectP.text = text
                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_ok_dollar.text {
                    lblDollar.text = text
                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_submit.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Top_Up_Wallet_upload.text {
                    btnUpload.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Top_Up_Wallet_upload_receipt.text {

                    lblUploadReciept.text = text

                }
                if let text = xml.resource.Top_Up_Voucher_Point_voucher_pt_history.text {
                    
                    
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnVPtHistory.setAttributedTitle(buttonTitleStr, for: .normal)
                }
                
                
                
                if let text = xml.resource.Top_Up_Wallet_offline_bank_transfer.text {
                    lblOffBank.text = text
                }
                
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let topupCell = collectionTopUpPoints.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionTopUpVoucherPtCell
        
        if selectedIndexPath == indexPath {
            topupCell.imgCollection.backgroundColor = UIColor.white
            topupCell.lblfirst.backgroundColor = UIColor.white
        }
        
        
        self.selectedIndexPath = nil
        // collectionTopUpPoints.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.itemAmount.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionTopUpPoints {
            let topupCell = collectionTopUpPoints.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionTopUpVoucherPtCell
            
            if selectedIndexPath == indexPath {
                topupCell.imgCollection.backgroundColor = UIColor.lightGray
                topupCell.lblfirst.backgroundColor = UIColor.lightGray
            }
            else {
                topupCell.imgCollection.backgroundColor = UIColor.white
                topupCell.lblfirst.backgroundColor = UIColor.white
            }
            
            //topupCell.lblSecond.text = itemsSec[indexPath.row]
            //topupCell.lblfirst.text = items[indexPath.row]
            topupCell.lblSecond.text = self.itemAmount[indexPath.row].price
            topupCell.lblfirst.text = self.itemAmount[indexPath.row].title
            topupCell.viewCollectionBG.layer.cornerRadius = 10
            topupCell.viewCollectionBG.clipsToBounds = true
            topupCell.imgCollection.image = UIImage(named:itemsImg[indexPath.row])
            //itemsImg[indexPath.row]
            if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
                topupCell.imgWidth.constant = 180
                
            }
            cell = topupCell
            
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected top cell #\(indexPath.item)!")
        if collectionView == collectionTopUpPoints {
            let topupCell = collectionTopUpPoints.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionTopUpVoucherPtCell
            topupCell.imgCollection.backgroundColor = UIColor.lightGray
            topupCell.lblfirst.backgroundColor = UIColor.lightGray
            
            selectedIndexPath = indexPath
            var tvar:Int = Int()
            tvar = self.itemAmount[indexPath.row].id!
            selectedID = String(tvar)
            selectedAmount = String(self.itemAmount[indexPath.row].amount!)
            
            
            self.selectedIndexPath = indexPath
            
            if indexPath.row == 0
            {
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "TopUpWalletVC") as! TopUpWalletVC
                //self.navigationController?.pushViewController(next, animated: true)
                
            }
            collectionTopUpPoints.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
        self.changeLanguage()
    }
    override func viewDidLoad() {
        viewT.layer.cornerRadius = viewT.frame.size.height/2
        viewS.layer.cornerRadius = viewS.frame.size.height/2
        viewf.layer.cornerRadius = viewf.frame.size.height/2
        
        btnUpload.layer.cornerRadius = 5
        super.viewDidLoad()
        self.getTopUpVoucherDetails()
        // Do any additional setup after loading the view.
        
        viewOfflineHead.layer.cornerRadius = 15
        viewOfflineHead.clipsToBounds = true
        
        viewBankDet.layer.cornerRadius = 15
        viewBankDet.clipsToBounds = true
        
        
        viewRadioVisa.layer.cornerRadius = viewRadioVisa.frame.size.height/2
        viewRadioVisa.clipsToBounds = true
        
        viewRadioOffline.layer.cornerRadius = viewRadioOffline.frame.size.height/2
        viewRadioOffline.clipsToBounds = true
        
        viewRadioOKDollar.layer.cornerRadius = viewRadioOKDollar.frame.size.height/2
        viewRadioOKDollar.clipsToBounds = true
        
        viewRadioKBZPay.layer.cornerRadius = viewRadioKBZPay.frame.size.height/2
        viewRadioKBZPay.clipsToBounds = true
        
        viwRadioOnePay.layer.cornerRadius = viwRadioOnePay.frame.size.height/2
        viwRadioOnePay.clipsToBounds = true
        
        viewRadionDRSPay.layer.cornerRadius = viewRadionDRSPay.frame.size.height/2
        viewRadionDRSPay.clipsToBounds = true
        
        viewRadioOffline.layer.cornerRadius = viewRadioOffline.frame.size.height/2
        viewRadioOffline.clipsToBounds = true
        viewRadioOffline.layer.borderWidth = 2
        viewRadioOffline.layer.borderColor = UIColor.white.cgColor
        
        
        
        
        
        collectionTopUpPoints.dataSource = self
        collectionTopUpPoints.delegate = self
        let layout = collectionTopUpPoints.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 10
        layout?.minimumInteritemSpacing = 5
        collectionTopUpPoints!.collectionViewLayout = layout!
        if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
            
            
            
        }
        
        
        
        btnSubmit.layer.cornerRadius = 15
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
    
    
    func getTopUpVoucherDetails() {
        self.view.activityStartAnimating()
        
        
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken()
        ]
        let loginURL = Constants.baseURL+Constants.VoucherTopUpURL
        
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
                    self.topUpVoucherModel = TopUpVoucherModel(response)
                    print("self.topUpVoucherModel ",self.topUpVoucherModel!)
                    print("self.topUpVoucherModel ",self.topUpVoucherModel?.httpcode!)
                    
                    
                    let statusCode = Int((self.topUpVoucherModel?.httpcode)!)
                    if statusCode == 200{
                        self.lblBankAcc.text = self.topUpVoucherModel?.topUpVoucherModelData?.drsBankData?.accountNumber
                        self.lblBankName.text = self.topUpVoucherModel?.topUpVoucherModelData?.drsBankData?.bankName
                        
                        self.itemAmount = (self.topUpVoucherModel?.topUpVoucherModelData?.voucherList)!
                        print("itemAmount 123",self.itemAmount)
                        
                        self.collectionTopUpPoints.reloadData()
                        
                    }
                    
                    if statusCode == 400{
                        self.view.activityStopAnimating()
                        if let range3 = (self.topUpVoucherModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.topUpVoucherModel?.message)!)
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
        //offlineBankTransStatus = false
        
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
                    print("self.oKDollarModel ",self.oKDollarModel!)
                    print("self.oKDollarModel ",self.oKDollarModel?.httpcode!)
                    // print("self.topupPaymentModel ",self.validateMobileModelResponse?.validateMobileModelData)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.oKDollarModel?.httpcode)!)
                    if statusCode == 200
                    {
                        
                        
                        let sharedDefault = SharedDefault()

                        if sharedDefault.getLanguage() == 1
                        {
                            self.showToast(message:"ကျေးဇူးပြုပြီး okdollar ဖြင့်ငွေပေးချေပါ")
                        }
                        else if sharedDefault.getLanguage() == 0
                        {
                            self.showToast(message: (self.oKDollarModel?.message)!)
                        }
                        
                        
                        
                        
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                        {
                            // self.selectedAmount = ""
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.oKDollarModel?.message)!)
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
    @IBAction func btnSubmitAction(_ sender: Any) {
        print("btnSubmitAction")
        print("paymentType",paymentType.count)
        if Reachability.isConnectedToNetwork() {
            
            if selectedID.count>0 {
                /*if firstImgData.count<=0{
                 showToast(message: "Upload bank receipt")
                 } else if paymentType == "bank_transfer" {
                 self.offlineTransfer(voucher_id: selectedID,paymentType: paymentType)
                 firstImgData = ""
                 offlineBankTransStatus = false
                 
                 }*/
                if paymentType.count>0 {
                    if paymentType == "bank_transfer" {
                        if firstImgData.count>0 {
                            self.offlineTransfer(voucher_id: selectedID,paymentType: paymentType)
                            firstImgData = ""
                            offlineBankTransStatus = false
                            paymentType = ""
                        } else {
                            if sharedData.getLanguage() == 0 {
                                showToast(message: "The bank receipt field is required.")
                            }
                            else if sharedData.getLanguage() == 1 {
                                showToast(message: "ဘဏ်ငွေလက်ခံဖြတ်ပိုင်းလိုအပ်ပါသည်။")
                            }
                        }
                        
                    }
                        
                    else if paymentType == "ok_dollar" {
                        btnOKDollarStatus = false
                        self.okDollarPayment(amount: selectedAmount,paymentType: paymentType)
                        paymentType = ""
                    }
                } else {
                    //
                    if sharedData.getLanguage() == 0 {
                        showToast(message: "Select payment type")
                    } else  if sharedData.getLanguage() == 1 {
                        showToast(message: "ငွေပေးချေမှုအမျိုးအစားကိုရွေးချယ်ပါ")
                    }
                    
                }
                
                /*else if paymentType == "card" {
                 self.offlineTransfer(voucher_id: selectedID,paymentType: paymentType)
                 paymentType = ""
                 }
                 else if paymentType == "kbz_pay" {
                 self.offlineTransfer(voucher_id: selectedID,paymentType: paymentType)
                 paymentType = ""
                 }
                 else if paymentType == "one_pay" {
                 self.offlineTransfer(voucher_id: selectedID,paymentType: paymentType)
                 paymentType = ""
                 }
                 else if paymentType == "drs_pay" {
                 self.offlineTransfer(voucher_id: selectedID,paymentType: paymentType)
                 paymentType = ""
                 }*/
                
                /*if offlineBankTransStatus == true {
                 if firstImgData.count>0{
                 self.offlineTransfer(amount: txtAmount.text!,paymentType: paymentType)
                 firstImgData = ""
                 }
                 else {
                 showToast(message: "Upload receipt")
                 }
                 
                 } else
                 {
                 showToast(message: "Select paymnet type")
                 }*/
            } else {
                if sharedData.getLanguage() == 0 {
                    showToast(message: "Please select voucher points")
                }
                else if sharedData.getLanguage() == 1 {
                    showToast(message: "ကျေးဇူးပြု၍ ဘောက်ချာအချက်များရွေးပါ")
                }
                
                //
            }
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
    }
    
    func offlineTransfer(voucher_id: String,paymentType:String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "voucher_id":voucher_id,
                    "payment_type":paymentType,
                    "bank_receipt":firstImgData
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.VoucherTopUpVoucherURL
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
                    print("self.topupPaymentModel ",self.topupPaymentModel!)
                    print("self.topupPaymentModel ",self.topupPaymentModel?.httpcode!)
                    // print("self.topupPaymentModel ",self.validateMobileModelResponse?.validateMobileModelData)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.topupPaymentModel?.httpcode)!)
                    if statusCode == 200
                    {
                        let sharedDefault = SharedDefault()

                        if sharedDefault.getLanguage() == 1
                        {
                            self.showToast(message:"ဘောက်ချာထိပ်တန်းအောင်မြင်မှု အချက်များစိစစ်အတည်ပြုပြီးနောက်ကဆက်ပြောသည်လိမ့်မည်")
                        }
                        else if sharedDefault.getLanguage() == 0
                        {
                            self.showToast(message: (self.topupPaymentModel?.message)!)
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5)
                        {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "VoucherPtHistoryVC") as! VoucherPtHistoryVC
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.topupPaymentModel?.message)!)
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
    
    @IBAction func btnUploadAction(_ sender: UIButton) {
        print("btnUploadAction")
        self.showAlert()
    }
    
    
    @IBAction func btnVPTHistoryAction(_ sender: Any) {
        //
        let next = self.storyboard?.instantiateViewController(withIdentifier: "VoucherPtHistoryVC") as! VoucherPtHistoryVC
        self.navigationController?.pushViewController(next, animated: true)
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
        firstImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
        
        
        
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
