//
//  WalletHistoryVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/27/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class WalletHistoryVC: UIViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    private let refreshControl = UIRefreshControl()
    var walletTopupHistoryModel: WalletTopupHistoryModel?
    var sectionDetail = [WalletTopupHistory]()
    var tempsectionDetail = [WalletTopupHistory]()
    let sharedData = SharedDefault()
    var strTitle:String = String()
    var cancelTitle:String = String()
    
    let reuseIdentifier = "WalletHistoryCell"
    let reuseIdentifierheader = "SectionHeaderWalletHistory"
    var items = ["5,000 MMK", "10,000 MMK", "20,000 MMK","50,000 MMK", "100,000 MMK", "200,000 MMK"]
    var sectionitems = ["March 2020", "February 2020"]
    @IBOutlet var collectionWalletHistory: UICollectionView!
    @IBOutlet var searchWalletHistory: UISearchBar!
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
               // print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Top_Up_Wallet_History_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Title_Cancel.text {
                    cancelTitle = text
                    
                }
                if let text = xml.resource.Wallet_History_look_for.text {
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchWalletHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchWalletHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                    
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
                if let text = xml.resource.Top_Up_Wallet_History_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Title_Cancel.text {
                    cancelTitle = text
                    
                }
                if let text = xml.resource.Wallet_History_look_for.text {
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchWalletHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchWalletHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                    
                }
                
                
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionDetail.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.sectionDetail[section].walletTopupHistoryValue!.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        let  firstheader: SectionHeaderWalletHistory = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierheader, for: indexPath) as! SectionHeaderWalletHistory
        firstheader.strHeader = self.sectionDetail[indexPath.section].date
        reusableview = firstheader
        return reusableview
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionWalletHistory {
            let topupCell = collectionWalletHistory.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WalletHistoryCell
            topupCell.viewBG.layer.cornerRadius = 20
            topupCell.viewBG.clipsToBounds = true
            /*if indexPath.row == 0 {
             topupCell.lblStatus.text = "Successful"
             topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
             } else if indexPath.row == 1 {
             topupCell.lblStatus.text = "Pending"
             topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
             }else if indexPath.row == 2 {
             topupCell.lblStatus.text = "Unsuccessful"
             topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
             }
             */
            //print("asd ****",self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!)
            
            /*
             if self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status == "Successful"{
             topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
             topupCell.lblStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!
             }else  if self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status == "Pending"{
             topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
             topupCell.lblStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!
             }
             else  if self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status == "Unsuccessful"{
             topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
             topupCell.lblStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!
             }
             */
            if let range3 = (self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status)!.range(of: "Success", options: .caseInsensitive){
                topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!
                if sharedData.getLanguage() == 0
                {
//                    topupCell.lblStatus.text = "Success"
                    
                    topupCell.lblStatus.text = "Successful"

                }
                else if sharedData.getLanguage() == 1
                {
                    topupCell.lblStatus.text = "အောင်မြင်သည်"
                }
            }
            if let range3 = (self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status)!.range(of: "Pending", options: .caseInsensitive){
//                topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
                
                topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)

                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!
                if sharedData.getLanguage() == 0
                {
                    topupCell.lblStatus.text = "Pending"
                }
                else if sharedData.getLanguage() == 1
                {
                    topupCell.lblStatus.text = "ဆိုင်းငံ့ထား"
                }
            }
            if let range3 = (self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status)!.range(of: "Unsuccessful", options: .caseInsensitive){
//                topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
                
                topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)

                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!
                if sharedData.getLanguage() == 0
                {
                    topupCell.lblStatus.text = "Unsuccessful"
                }
                else if sharedData.getLanguage() == 1
                {
                    topupCell.lblStatus.text = "မအောင်မြင်"
                }
            }
            if let range4 = (self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status)!.range(of: "Failed", options: .caseInsensitive){
                
                topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)

                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].status!
                
                if sharedData.getLanguage() == 0
                {
//                    topupCell.lblStatus.text = "Failed"
                    
                    topupCell.lblStatus.text = "Unsuccessful"

                }
                else if sharedData.getLanguage() == 1
                {
                    topupCell.lblStatus.text = "မအောင်မြင်"
                }
            }
            if sharedData.getLanguage() == 0
            {
                topupCell.lblTrans.text = "Transaction ID"
            }
            else if sharedData.getLanguage() == 1
            {
                topupCell.lblTrans.text = "ငွေသွင်းငွေထုတ် ID"
            }
            
            topupCell.lblAmt.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].amount!
            topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].transactionId!
            topupCell.lblDateTime.text = self.sectionDetail[indexPath.section].walletTopupHistoryValue![indexPath.row].paidOn!
            
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
            //topupCell.lblAmt.text = items[indexPath.row]
            //topupCell.viewCollectionBG.layer.cornerRadius = 10
            //topupCell.viewCollectionBG.clipsToBounds = true
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
        self.getWalletHistory(date: "",searchData: "")
        
        
        // Do any additional setup after loading the view.
        collectionWalletHistory.delegate = self
        collectionWalletHistory.dataSource = self
        searchWalletHistory.barTintColor = UIColor.clear
        searchWalletHistory.backgroundColor = UIColor.red
        searchWalletHistory.isTranslucent = true
        searchWalletHistory.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        
       
        
        
        if let textField = searchWalletHistory.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        /*
         let myView = UIView(frame: CGRect(x: 0, y: (textFieldInsideSearchBar?.frame.size.height)!-1, width: (textFieldInsideSearchBar?.frame.size.width)!, height: 2))
         myView.backgroundColor = UIColor.white
         textFieldInsideSearchBar!.addSubview(myView)*/
        
        
        
        searchWalletHistory.setValue("New Title", forKey: "cancelButtonText")


        searchWalletHistory.delegate = self
        searchWalletHistory.showsCancelButton = true
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionWalletHistory.refreshControl = refreshControl
        } else {
            collectionWalletHistory.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
        
        self.changeLanguage()
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        //fetchWeatherData()
        if searchWalletHistory.text == ""
        {
        print("Fetch Weather Data")
        refreshControl.endRefreshing()
        searchWalletHistory.text = ""
        print("Fetch Weather Data ----- ",self.sectionDetail[sectionDetail.count-1].date!)
        self.getWalletHistory(date: self.sectionDetail[sectionDetail.count-1].date!,searchData: "")
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.searchWalletHistory.resignFirstResponder()
                self.getWalletHistory(date: "", searchData: searchBar.text!)
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Search bar",searchBar.text!)
        searchWalletHistory.resignFirstResponder()
        self.getWalletHistory(date: "", searchData: searchBar.text!)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {searchWalletHistory.text = ""
        print("Search bareeeeee")
        searchWalletHistory.resignFirstResponder()
        if (self.walletTopupHistoryModel!.walletTopupHistoryModelData?.walletTopupHistory)!.count>0 {
            self.sectionDetail.removeAll()
        }
        self.getWalletHistory(date: "", searchData: "")
        
    }
    
    func getWalletHistory(date: String,searchData: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "search_key":searchData,
                    "last_date":date
            
        ]
        
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.WalletHistoryURL
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
                    self.walletTopupHistoryModel = WalletTopupHistoryModel(response)
                    print("self.walletTopupHistoryModel ",self.walletTopupHistoryModel!)
                    
                    let statusCode = Int((self.walletTopupHistoryModel?.httpcode)!)
                    print("statusCode",statusCode)
                    if statusCode == 200{
                        if (self.walletTopupHistoryModel!.walletTopupHistoryModelData?.walletTopupHistory)!.count>0 && self.searchWalletHistory.text!.count <= 0
                        {
                            if (self.walletTopupHistoryModel!.walletTopupHistoryModelData?.walletTopupHistory)!.count>0
                            {
                                self.sectionDetail .append(contentsOf: (self.walletTopupHistoryModel!.walletTopupHistoryModelData?.walletTopupHistory)!)

                            }
                            else
                            {
                                self.sectionDetail = (self.walletTopupHistoryModel!.walletTopupHistoryModelData?.walletTopupHistory)!
                            }
                            
                            
                            self.collectionWalletHistory.reloadData()
                        } else  if (self.walletTopupHistoryModel!.walletTopupHistoryModelData?.walletTopupHistory)!.count>0 && self.searchWalletHistory.text!.count > 0
                        {
                            
                                self.sectionDetail = (self.walletTopupHistoryModel!.walletTopupHistoryModelData?.walletTopupHistory)!
                            

                            self.collectionWalletHistory.reloadData()
                        }
                        
                        else {
                            self.searchWalletHistory.text = ""
                            self.view.activityStopAnimating()
                            var strPwdMsg = ""
                            let sharedDefault = SharedDefault()
                            
                            if sharedDefault.getLanguage() == 0
                            {
                                strPwdMsg = "No records found"

                              

                            }
                            else if sharedDefault.getLanguage() == 1
                            {
                                strPwdMsg = "မှတ်တမ်းမရှိပါ"
                                

                                
                            }

                            self.showToast(message: strPwdMsg)
                            return
                        }
                        
                        print("ArrayCount of Wallet history",self.sectionDetail.count)

                        
                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
//
//
//                        }
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.walletTopupHistoryModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.walletTopupHistoryModel?.message)!)
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

        if scrollView == collectionWalletHistory {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if searchWalletHistory.text == ""
                {
                print("bottomRefresh ----------------------------------> ")
                searchWalletHistory.text = ""
                refreshControl.endRefreshing()
                print("Fetch Weather Data ----- ",self.sectionDetail[sectionDetail.count-1].date!)
                self.getWalletHistory(date: self.sectionDetail[sectionDetail.count-1].date!,searchData: "")
                
                print("ofsetValue ----------------------------------> ")
                }

            }
        }
    }
}
