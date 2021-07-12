//
//  TransactionHistoryVC.swift
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

class TransactionHistoryVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    let sharedDefault = SharedDefault()
    
    var paymentHistoryModel: PaymentHistoryModel?
    private let refreshControl = UIRefreshControl()
    var strType:String = ""
    var strTitle:String = String()
    var statusType = [String]()
    
    var sectionDetail = [PaymentHistory]()
    @IBOutlet var searchTransHistory: UISearchBar!
    
    @IBOutlet weak var btnAllPayment: UIButton!
    
    @IBOutlet weak var btnCash: UIButton!
    
    @IBOutlet weak var btnWallet: UIButton!
    
    
    @IBOutlet weak var collectionTransHistory: UICollectionView!
    
    let reuseIdentifier = "TransHistoryCCell"
    let reuseIdentifierheader = "SectionHeaderTransHistory"
    func changeLanguage() {
           let sharedDefault = SharedDefault()
           if sharedDefault.getLanguage() == 1 {
               print("changeLanguage")
              
               let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                
                  
                if let text = xml.resource.Transaction_History.text {
                    print("btnNext",text)
                    strTitle = text
                    self.title = text
                }
                
                if let text = xml.resource.Transaction_Hitory_Im_looking_for.text {
                    print("btnNext",text)
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchTransHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchTransHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                }
               
                  
                   if let text = xml.resource.Transaction_History_All_Payment.text {
                        btnAllPayment.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Wallet.text {
                     btnWallet.setTitle(text, for: .normal)
                     print("btnNext",text)
                 
                }
                   if let text = xml.resource.Transaction_History_Cash.text {
                        btnCash.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Successful.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                }
                if let text = xml.resource.Transaction_History_Pending.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                 //statusType
                }
                if let text = xml.resource.Transaction_History_Unsuccessful.text {
                     
                     print("btnNext",text)
                     statusType.append(text)
                 //statusType
                }
                   
               }
               catch(_){print("error")}
           } else if sharedDefault.getLanguage() == 0 {
            var strHead:String = ""
            
               let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                
                  
                 if let text = xml.resource.Transaction_History.text {
                                   print("btnNext",text)
                                   strTitle = text
                                   self.title = text
                               }
                
                if let text = xml.resource.Transaction_Hitory_Im_looking_for.text {
                    print("btnNext",text)
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchTransHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchTransHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                                     
                   
                    
                }
               
                  
                   if let text = xml.resource.Transaction_History_All_Payment.text {
                        btnAllPayment.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Wallet.text {
                     btnWallet.setTitle(text, for: .normal)
                     print("btnNext",text)
                 
                }
                   if let text = xml.resource.Transaction_History_Cash.text {
                        btnCash.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Successful.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                }
                if let text = xml.resource.Transaction_History_Pending.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                 //statusType
                }
                if let text = xml.resource.Transaction_History_Unsuccessful.text {
                     
                     print("btnNext",text)
                     statusType.append(text)
                 //statusType
                }
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionDetail.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionDetail[section].paymentHistoryValue!.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        let  firstheader: SectionHeaderTransHistory = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierheader, for: indexPath) as! SectionHeaderTransHistory
        
        firstheader.strHeader = self.sectionDetail[indexPath.section].date
        reusableview = firstheader
        return reusableview
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionTransHistory {
            let topupCell = collectionTransHistory.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TransHistoryCCell
            topupCell.viewBG.layer.cornerRadius = 20
            topupCell.viewBG.clipsToBounds = true
            /*
            if self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status == "Success"{
                topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
                topupCell.lblStatus.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status!
            }else  if self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status == "Pending"{
                topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
                topupCell.lblStatus.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status!
            }
            else  if self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status == "Unsuccessful"{
                topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
                topupCell.lblStatus.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status!
            }
            */
            
            if let range3 = (self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status)!.range(of: "Successful", options: .caseInsensitive){
                print(" 123 success")
                topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status!
                if sharedDefault.getLanguage() == 0
                {
                    topupCell.lblStatus.text = "Successful"
                }
                else if sharedDefault.getLanguage() == 1
                {
                   topupCell.lblStatus.text = "အောင်မြင်သည်"
                }
            }
            if let range3 = (self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status)!.range(of: "Pending", options: .caseInsensitive){
                print(" 123 Pending")
                topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status!
                if sharedDefault.getLanguage() == 0
                {
                    topupCell.lblStatus.text = "Pending"
                }
                else if sharedDefault.getLanguage() == 1
                {
                   topupCell.lblStatus.text = "ဆိုင်းငံ့ထား"
                }
            }
            if let range3 = (self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status)!.range(of: "Unsuccessful", options: .caseInsensitive){
                print(" 123 Unsuccessful")
                topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].status!
                if sharedDefault.getLanguage() == 0
                {
                    topupCell.lblStatus.text = "Unsuccessful"
                }
                else if sharedDefault.getLanguage() == 1
                {
                   topupCell.lblStatus.text = "မအောင်မြင်"
                }
            }
            
            topupCell.lblTransType.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].paymentType!
            if topupCell.lblTransType.text == "Cash" || topupCell.lblTransType.text == "CASH"
            {
                if sharedDefault.getLanguage() == 1
                {
                    topupCell.lblTransType.text = "ငွေသား"
                }
                else if sharedDefault.getLanguage() == 0
                {
                    topupCell.lblTransType.text = "Cash"
                }
                
            }
            
            if topupCell.lblTransType.text == "Wallet" || topupCell.lblTransType.text == "WALLET"
            {
                if sharedDefault.getLanguage() == 1
                {
                    topupCell.lblTransType.text = "ပိုက်ဆံအိတ်"
                }
                else if sharedDefault.getLanguage() == 0
                {
                    topupCell.lblTransType.text = "Wallet"
                }
                
            }
            
            topupCell.lblAmt.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].amount!
            topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].transactionId!
            topupCell.lblDateTime.text = self.sectionDetail[indexPath.section].paymentHistoryValue![indexPath.row].paidOn!
            
            if sharedDefault.getLanguage() == 0
            {
                topupCell.lblTrans.text = "Transaction ID"
            }
            else if sharedDefault.getLanguage() == 1
            {
                topupCell.lblTrans.text = "ငွေသွင်းငွေထုတ် ID"
            }
            
            
            if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
                topupCell.widthViewBG.constant = 340
            }
            else if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
                topupCell.widthViewBG.constant = 370
                
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max" {
                topupCell.widthViewBG.constant = 370
            }
            else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS" {
                topupCell.widthViewBG.constant = 370
                
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                
                topupCell.widthViewBG.constant = 370
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                
                topupCell.widthViewBG.constant = 370
            }
            else {
                topupCell.widthViewBG.constant = 370
                
            }
            
            cell = topupCell
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionInfoVC") as! TransactionInfoVC
        //self.navigationController?.pushViewController(next, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnAllPayment.layer.cornerRadius = 10
        btnCash.layer.cornerRadius = 10
        btnWallet.layer.cornerRadius = 10
        
        collectionTransHistory.delegate = self
        collectionTransHistory.dataSource = self
        
        
        
        searchTransHistory.barTintColor = UIColor.clear
        searchTransHistory.backgroundColor = UIColor.red
        searchTransHistory.isTranslucent = true
        searchTransHistory.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: " I'm looking for date", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        
        let textFieldInsideSearchBar = searchTransHistory.value(forKey: "searchField") as? UITextField
        let fonts = UIFont .boldSystemFont(ofSize: 16.0)  
        textFieldInsideSearchBar?.font = fonts
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.borderStyle = .none
        textFieldInsideSearchBar?.textColor = UIColor.white
        
       

        
        if let textField = searchTransHistory.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        
        
        let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
        
        searchTransHistory.delegate = self
        searchTransHistory.showsCancelButton = true
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionTransHistory.refreshControl = refreshControl
        } else {
            collectionTransHistory.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
        
        self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
        
        self.changeLanguage()
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        //fetchWeatherData()
        if searchTransHistory.text == ""
        {
        print("Fetch Weather Data")
        refreshControl.endRefreshing()
        
        self.getTransactionDetails(searchKey: "", filter: strType, lastDate: self.sectionDetail[sectionDetail.count-1].date!)
        //(date: ,searchData: "")
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.searchTransHistory.resignFirstResponder()
                self.getTransactionDetails(searchKey: searchBar.text!, filter: searchText, lastDate: "")
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
           print("Search bar",searchBar.text!)
           searchTransHistory.resignFirstResponder()
           self.getTransactionDetails(searchKey: searchBar.text!, filter: strType, lastDate: "")
           
       }
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
       {
        if searchTransHistory.text!.count>0 {
            searchTransHistory.text = ""
            searchTransHistory.resignFirstResponder()
        }
        self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
        
           print("Search b")
           
       }
    @IBAction func btnAllPaymentAction(_ sender: UIButton) {
         self.sectionDetail.removeAll()
         strType = ""
        btnCash.backgroundColor = UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        btnWallet.backgroundColor =  UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
         btnAllPayment.backgroundColor = Constants.textColor
        self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
    }
    @IBAction func btnWalletAction(_ sender: UIButton) {
         self.sectionDetail.removeAll()
        strType = "wallet"
        btnCash.backgroundColor = UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        btnAllPayment.backgroundColor =  UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        btnWallet.backgroundColor = Constants.textColor
        self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
    }
    
    @IBAction func btnCashAction(_ sender: UIButton) {
        strType = "cash"
         self.sectionDetail.removeAll()
        btnWallet.backgroundColor = UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        btnAllPayment.backgroundColor =  UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
        btnCash.backgroundColor = Constants.textColor
        
        self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
    }
    
    func getTransactionDetails(searchKey:String,filter:String,lastDate:String) {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "search_key":searchKey,
                    "filter":filter,
                    "last_date":lastDate
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.PaymentHistoryURL
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
                    self.paymentHistoryModel = PaymentHistoryModel(response)
                    print("self.paymentHistoryModel ",self.paymentHistoryModel!)
                    print("self.paymentHistoryModel ",self.paymentHistoryModel?.httpcode!)
                    
                    
                    let statusCode = Int((self.paymentHistoryModel?.httpcode)!)
                    if statusCode == 200{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [self] in
                            if (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!.count>0 && self.searchTransHistory.text!.count<=0{
                                //self.sectionDetail.removeAll()
                            //self.sectionDetail = (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!
                           
                            
                            
                                if (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!.count>0
                            {
                                self.sectionDetail .append(contentsOf: (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!)

                            }
                            else
                            {
                                
                                self.sectionDetail = (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!

                            }
                            
                                
                            }else if (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!.count > 0 && self.searchTransHistory.text!.count > 0
                            {
                                self.view.activityStopAnimating()
                                 self.sectionDetail = (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!
                               
                            }
                            else if (self.paymentHistoryModel!.paymentHistoryModelData?.paymentHistory)!.count == 0 {
                                self.view.activityStopAnimating()
                                if self.sharedDefault.getLanguage() == 1
                                {
                                    self.showToast(message: "မှတ်တမ်းမရှိသေးပါ")

                                }
                                else
                                {
                                    self.showToast(message: Constants.NoResult)

                                }
                                return
                            }
                            
                            print("ArrayCount of Transaction history",self.sectionDetail.count)
                            
                        self.collectionTransHistory.reloadData()
                        }
                        
                        
                    }
                    if statusCode == 400{
                
                        self.view.activityStopAnimating()
                        if let range3 = (self.paymentHistoryModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.paymentHistoryModel?.message)!)
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
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        //Bottom Refresh

        if scrollView == collectionTransHistory {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                
                print("bottomRefresh ----------------------------------> ")
                if searchTransHistory.text == ""
                {
                print("Fetch Weather Data")
                refreshControl.endRefreshing()
                self.getTransactionDetails(searchKey: "", filter: strType, lastDate: self.sectionDetail[sectionDetail.count-1].date!)
                
                print("ofsetValue ----------------------------------> ")

                }
            }
        }
    }
}
