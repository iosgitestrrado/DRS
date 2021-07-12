//
//  VoucherPtHistoryVC.swift
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

class VoucherPtHistoryVC: UIViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    private let refreshControl = UIRefreshControl()
    var strTitle:String = ""
    var voucherPointHistoryModel: VoucherPointHistoryModel?
    var sectionDetail = [VoucherPointHistory]()
    let sharedData = SharedDefault()
    let reuseIdentifier = "WalletHistoryCell"
    let reuseIdentifierheader = "SectionHeaderVoucherTopUpHistory"
    var items = ["5,000 MMK", "10,000 MMK", "20,000 MMK","50,000 MMK", "100,000 MMK", "200,000 MMK"]
    var sectionitems = ["March 2020", "February 2020"]
    
    @IBOutlet var collectionVoucherPtHistory: UICollectionView!
    @IBOutlet var searchVoucherPtHistory: UISearchBar!
    func changeLanguage() {
           let sharedDefault = SharedDefault()
           
           if sharedDefault.getLanguage() == 1 {
               print("Bermese")
               
               let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                  //print("text",text)
                   let xml = try! XML.parse(text)
                   
                   if let text = xml.resource.Top_Up_Voucher_Point_history_title.text {
                       strTitle = text
                       self.title = strTitle
                   }
                   if let text = xml.resource.Top_Up_Voucher_Point_history_Im_looking_for.text {
                    
                         UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                         
                         let textFieldInsideSearchBar = searchVoucherPtHistory.value(forKey: "searchField") as? UITextField
                         let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                         textFieldInsideSearchBar?.font = fonts
                         textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                         textFieldInsideSearchBar?.borderStyle = .none
                         textFieldInsideSearchBar?.textColor = UIColor.white
                         let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                                clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchVoucherPtHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                                     
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
                   
                   if let text = xml.resource.Top_Up_Voucher_Point_history_title.text {
                       strTitle = text
                       self.title = strTitle
                   }
                   if let text = xml.resource.Top_Up_Voucher_Point_history_Im_looking_for.text {
                    
                         UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                         
                         let textFieldInsideSearchBar = searchVoucherPtHistory.value(forKey: "searchField") as? UITextField
                         let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                         textFieldInsideSearchBar?.font = fonts
                         textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                         textFieldInsideSearchBar?.borderStyle = .none
                         textFieldInsideSearchBar?.textColor = UIColor.white
                         let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                                clearButton.tintColor = UIColor.white
//                    Title_Cancel
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchVoucherPtHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)


//                    let cancelButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.gray]
//                    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
                                     
                   }
                   
                   
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionDetail.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionDetail[section].voucherPointHistoryValue!.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        let  firstheader: SectionHeaderVoucherTopUpHistory = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierheader, for: indexPath) as! SectionHeaderVoucherTopUpHistory
        firstheader.strHeader = sectionDetail[indexPath.section].date!
        reusableview = firstheader
        return reusableview
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionVoucherPtHistory
        {
            let topupCell = collectionVoucherPtHistory.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WalletHistoryCell
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
             }*/
            /* if self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status == "Success"{
             topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
             topupCell.lblStatus.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status!
             }else  if self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status == "Pending"{
             topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
             topupCell.lblStatus.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status!
             }
             else  if self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status == "Unsuccessful"{
             topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
             topupCell.lblStatus.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status!
             }
             */
            if let range3 = (self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status)!.range(of: "Success", options: .caseInsensitive){
                topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status!
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
            if let range3 = (self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status)!.range(of: "Pending", options: .caseInsensitive){
                topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
               // topupCell.lblStatus.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status!
                if sharedData.getLanguage() == 0
                {
                    topupCell.lblStatus.text = "Pending"
                }
                else if sharedData.getLanguage() == 1
                {
                   topupCell.lblStatus.text = "ဆိုင်းငံ့ထား"
                }
            }
            if let range3 = (self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status)!.range(of: "Failed", options: .caseInsensitive){
                topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
                
                topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)

                
                //topupCell.lblStatus.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].status!
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
            topupCell.lblAmt.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].amount!
            topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].transactionId!
            topupCell.lblDateTime.text = self.sectionDetail[indexPath.section].voucherPointHistoryValue![indexPath.row].paidOn!
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
       // self.navigationController?.pushViewController(next, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
        self.changeLanguage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getVoucherPointHistory(date: "",searchData:"")
        // Do any additional setup after loading the view.
        
        collectionVoucherPtHistory.delegate = self
        collectionVoucherPtHistory.dataSource = self
        searchVoucherPtHistory.barTintColor = UIColor.clear
        searchVoucherPtHistory.backgroundColor = UIColor.red
        searchVoucherPtHistory.isTranslucent = true
        searchVoucherPtHistory.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        /*
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: " I'm looking for date", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        
        let textFieldInsideSearchBar = searchVoucherPtHistory.value(forKey: "searchField") as? UITextField
        let fonts = UIFont .boldSystemFont(ofSize: 16.0)
        textFieldInsideSearchBar?.font = fonts
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.borderStyle = .none
        textFieldInsideSearchBar?.textColor = UIColor.white
         
         let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = UIColor.white
                
        
 */
        
        if let textField = searchVoucherPtHistory.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        /*
         let myView = UIView(frame: CGRect(x: 0, y: (textFieldInsideSearchBar?.frame.size.height)!-1, width: (textFieldInsideSearchBar?.frame.size.width)!, height: 2))
         myView.backgroundColor = UIColor.white
         textFieldInsideSearchBar!.addSubview(myView)*/
        
       
       // let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
       // UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        searchVoucherPtHistory.delegate = self
        searchVoucherPtHistory.showsCancelButton = true
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionVoucherPtHistory.refreshControl = refreshControl
        } else {
            collectionVoucherPtHistory.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.isHidden = true
        refreshControl.tintColor = UIColor.clear
        
        
        
        
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        //fetchWeatherData()
        if searchVoucherPtHistory.text == ""
        {
        print("Fetch Weather Data")
        refreshControl.endRefreshing()
        searchVoucherPtHistory.text = ""
        self.getVoucherPointHistory(date: self.sectionDetail[sectionDetail.count-1].date!,searchData:"")
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.searchVoucherPtHistory.resignFirstResponder()
                self.getVoucherPointHistory(date: "", searchData: searchBar.text!)
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Search bar",searchBar.text!)
        if (self.voucherPointHistoryModel!.voucherPointHistoryModelData?.voucherPointHistory)!.count<=0{
            self.sectionDetail.removeAll()
        }
        searchVoucherPtHistory.resignFirstResponder()
        self.getVoucherPointHistory(date: "", searchData: searchBar.text!)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchVoucherPtHistory.text = ""
        print("Search bareeeeee")
        searchVoucherPtHistory.resignFirstResponder()
        self.sectionDetail.removeAll()
        self.getVoucherPointHistory(date: "", searchData: "")
    }
    func getVoucherPointHistory(date: String,searchData:String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "search_key":searchData,
                    "last_date":date
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.VoucherHistoryURL
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
                    self.voucherPointHistoryModel = VoucherPointHistoryModel(response)
                    print("self.voucherPointHistoryModel ",self.voucherPointHistoryModel!)
                    print("self.voucherPointHistoryModel ",self.voucherPointHistoryModel?.httpcode!)
                    // print("self.topupPaymentModel ",self.validateMobileModelResponse?.validateMobileModelData)
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.voucherPointHistoryModel?.httpcode)!)
                    if statusCode == 200{
                        if (self.voucherPointHistoryModel!.voucherPointHistoryModelData?.voucherPointHistory)!.count>0 && self.searchVoucherPtHistory.text!.count <= 0
                        {
                            
                            
                            if (self.voucherPointHistoryModel!.voucherPointHistoryModelData?.voucherPointHistory)!.count>0
                            {
                                self.sectionDetail .append(contentsOf: (self.voucherPointHistoryModel!.voucherPointHistoryModelData?.voucherPointHistory)!)

                            }
                            else
                            {
                                
                                self.sectionDetail = (self.voucherPointHistoryModel!.voucherPointHistoryModelData?.voucherPointHistory)!

                            }
                            
                            print("sectionDetail ",self.sectionDetail)
                            
                            self.collectionVoucherPtHistory.reloadData()
                        } else if (self.voucherPointHistoryModel!.voucherPointHistoryModelData?.voucherPointHistory)!.count>0 && self.searchVoucherPtHistory.text!.count > 0
                        {
                            self.view.activityStopAnimating()
                             self.sectionDetail = (self.voucherPointHistoryModel!.voucherPointHistoryModelData?.voucherPointHistory)!
                            self.collectionVoucherPtHistory.reloadData()
                        }
                            
                        else {
                             self.view.activityStopAnimating()
                            self.searchVoucherPtHistory.text = ""

                            if self.sharedData.getLanguage() == 1
                            {
                                self.showToast(message: "မှတ်တမ်းမရှိသေးပါ")

                            }
                            else
                            {
                                self.showToast(message: Constants.NoResult)

                            }
                            
                            return
                        }
                        
                        print("ArrayCount of Voucher history",self.sectionDetail.count)

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                     
                        }
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.voucherPointHistoryModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.voucherPointHistoryModel?.message)!)
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

        if scrollView == collectionVoucherPtHistory {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if searchVoucherPtHistory.text == ""
                {
                print("bottomRefresh ----------------------------------> ")
                searchVoucherPtHistory.text = ""
                print("Fetch Weather Data")
                refreshControl.endRefreshing()
                self.getVoucherPointHistory(date: self.sectionDetail[sectionDetail.count-1].date!,searchData:"")
                
                print("ofsetValue ----------------------------------> ")
                }

            }
        }
    }
}
