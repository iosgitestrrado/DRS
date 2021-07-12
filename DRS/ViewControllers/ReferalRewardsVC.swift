//
//  ReferalRewardsVC.swift
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
class ReferalRewardsVC: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    private let refreshControl = UIRefreshControl()
    var strTitle:String = String()
    let reuseIdentifierPromo = "ReferralTableCell"
    var items = ["Top Up Wallet", "Buy Voucher Point", "Share"]
    let sharedData = SharedDefault()
    
    var ofsetValue:Int = 0
    
    
    var sectionDetail = [ReferralRewards]()
    var commissionHistoryModel: CommissionHistoryModel?
    
    @IBOutlet weak var tableReferral: UITableView!
    @IBOutlet weak var viewBg: UIView!
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Referral_Rewards_ref_rewards.text {
                    strTitle = text
                 self.title = strTitle
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
                
               if let text = xml.resource.Referral_Rewards_ref_rewards.text {
                    strTitle = text
                 self.title = strTitle
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableCount = Int()
        if tableView == tableReferral {
            tableCount = sectionDetail.count
        }
        
        return tableCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableReferral {
            let cellBal = tableReferral.dequeueReusableCell(withIdentifier: "ReferralTableCell", for: indexPath) as! ReferralTableCell
            
            cellBal.selectionStyle = .none
            if sharedData.getLanguage() == 0 {
                cellBal.lbtType.text = self.sectionDetail[indexPath.row].title
            } else if sharedData.getLanguage() == 1 {
                cellBal.lbtType.text = self.sectionDetail[indexPath.row].title
            }
            if self.sharedData.getLanguage() == 0
            {
                var greet:String = ""
                
                if self.sectionDetail[indexPath.row].title! == "Referal reward"
                {
                    greet = "Referal reward"
                }
                else if self.sectionDetail[indexPath.row].title! == "Merchant payment reward"
                {
                    greet = "Merchant payment reward"
                }
                cellBal.lbtType.text = greet
            }
            else if self.sharedData.getLanguage() == 1
            {
                var greet:String = ""
                
                if self.sectionDetail[indexPath.row].title! == "Referal reward" {
                    greet = "လွှဲပြောင်းဆု"
                } else if self.sectionDetail[indexPath.row].title! == "Merchant payment reward" {
                    greet = "ကုန်သည်ပေးချေမှုဆု"
                }
                cellBal.lbtType.text = greet
            }
            //let mySubstring = str.prefix(5) // Hello
            
            cellBal.lblAmount.text = self.sectionDetail[indexPath.row].amount
             cellBal.lblCurrency.text = self.sectionDetail[indexPath.row].currency
            
            if self.sharedData.getLanguage() == 0
            {
                var greet:String = self.sectionDetail[indexPath.row].discription!
                let mySubstring1 = greet.prefix(20) // Hello
                let mySubstring2 = greet.suffix(20)
              
                
                cellBal.lblDateTime.text = greet
            }
            else if self.sharedData.getLanguage() == 1
            {
                var greet:String = self.sectionDetail[indexPath.row].discription!
                //let mySubstring1 = greet.suffix(from: greet[20]) // Hello
                //let mySubstring2 = greet.suffix(26)
                print(greet.substring(from: 20))
                
                cellBal.lblDateTime.text = "ဘောက်ချာပွိုင့်အပေါ်" + greet.substring(from: 23)
            }
            
            cell = cellBal
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.changeLanguage()
        viewBg.layer.cornerRadius = 15
        tableReferral.dataSource = self
        tableReferral.delegate = self
        viewBg.clipsToBounds = true
        ofsetValue = ofsetValue + 1
        self.getReferralReward(offset:"")
        
        tableReferral.tableFooterView = UIView()
        
        // Configure Refresh Control
               refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
               
               refreshControl.tintColor = UIColor.clear
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableReferral.refreshControl = refreshControl
        } else {
            tableReferral.addSubview(refreshControl)
        }
       
        
        
        
        
    }
    @objc private func refreshWeatherData(_ sender: Any) {
           // Fetch Weather Data
           //fetchWeatherData()
           print("Fetch Weather Data")
           refreshControl.endRefreshing()
            
         self.getReferralReward(offset:String(ofsetValue))
          
       }
    
    func getReferralReward(offset:String) {
        self.view.activityStartAnimating()
        
        
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "offset":offset
        ]
        let loginURL = Constants.baseURL+Constants.ReferalRewardURL
        
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
                    self.commissionHistoryModel = CommissionHistoryModel(response)
                    print("self.commissionHistoryModel ",self.commissionHistoryModel!)
                    print("self.commissionHistoryModel ",self.commissionHistoryModel?.httpcode!)
                    
                    
                    let statusCode = Int((self.commissionHistoryModel?.httpcode)!)
                    if statusCode == 200{
                        
                        if (self.commissionHistoryModel?.commissionHistoryModelData?.referralRewards!.count)!>0 {
                            if self.sectionDetail.count>0 {
                                
                                self.sectionDetail .append(contentsOf: (self.commissionHistoryModel?.commissionHistoryModelData?.referralRewards)!)
                            } else {
                                self.sectionDetail = (self.commissionHistoryModel?.commissionHistoryModelData?.referralRewards)!
                            }
                            
                            self.tableReferral.reloadData()
                        }
                        else
                        {
                            if self.sharedData.getLanguage() == 1
                            {
                                self.showToast(message: "မှတ်တမ်းမရှိသေးပါ")

                            }
                            else
                            {
                                self.showToast(message: Constants.NoResult)

                            }
                                                    }
                        
                       // print("self.commissionHistoryModel ",self.commissionHistoryModel!.commissionHistoryModelData?.referralRewards?.count)
                      /*
                        self.lblBankAcc.text = self.topUpVoucherModel?.topUpVoucherModelData?.drsBankData?.accountNumber
                        self.lblBankName.text = self.topUpVoucherModel?.topUpVoucherModelData?.drsBankData?.bankName
                        
                        self.itemAmount = (self.topUpVoucherModel?.topUpVoucherModelData?.voucherList)!
                        print("itemAmount 123",self.itemAmount)
                        
                        self.collectionTopUpPoints.reloadData()
                        */
                        
                    }
                    
                    if statusCode == 400{
                        self.view.activityStopAnimating()
                        if let range3 = (self.commissionHistoryModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.commissionHistoryModel?.message)!)
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

        if scrollView == tableReferral {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                
                print("bottomRefresh ----------------------------------> ",ofsetValue)
                print("Fetch Weather Data")
                refreshControl.endRefreshing()
                self.getReferralReward(offset:String(ofsetValue))
                print("ofsetValue ----------------------------------> ",ofsetValue)


            }
        }
    }
}
