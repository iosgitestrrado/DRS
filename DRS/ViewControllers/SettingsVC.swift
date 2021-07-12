//
//  SettingsVC.swift
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

class SettingsVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var viewLanguageBG: UIView!
    @IBOutlet weak var viewLang: UIView!
    @IBOutlet weak var tableLanguage: UITableView!
    //var languageItem = ["English","Burmese"]//Burmese
    var languageItem = [String]()//Burmese
    //var languageCode = [Int]()
    
    var languageCode = [0,1]
    
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblAreUSure: UILabel!
    var settingsModel: SettingsModel?
    var signModel: SignModel?
    @IBOutlet weak var viewScrollContent: UIView!
    @IBOutlet var lblPhone: UILabel!
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var viewLogoutBG: UIView!
    @IBOutlet weak var viewLogout: UIView!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var tableSettings: UITableView!
     var strTitle:String = ""
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var viewSettings: UIView!
    @IBOutlet weak var tableViewBal: UITableView!
    @IBOutlet weak var viewBalanceBG: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    //var items = ["Voucher points", "Balance in the wallet"]
     var items = [String]()
    //var settingsitems = ["Account Settings", "My Wallet","Invite & Earn","Notifications","Transaction History","Language","Customer Support","Sign up as a DRS Merchant","About DRS"]
    //var settingsitems = ["Account Settings", "My Wallet","Invite & Earn","Transaction History","Customer Support","Sign up as a DRS Merchant","About DRS"]
    
    //var settingsitems = ["Account Settings", "My Wallet","Invite & Earn","Transaction History","Customer Support","Sign up as a DRS Merchant","About DRS"]
    var settingsitems = [String]()
    //var settingsitems = ["Account Settings","About DRS"]
    var itemValue = ["", ""]
    
    @IBAction func btnCancelAction(_ sender: Any) {
        btnCancel.isHidden = true
               viewLanguageBG.isHidden = true
               viewLang.isHidden = true
    }
  
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        languageItem.removeAll()
        items.removeAll()
        settingsitems.removeAll()
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                languageItem.removeAll()
                
                let xml = try! XML.parse(text)
                if let text = xml.resource.Setting_title.text {
                    strTitle = text
                    self.title = strTitle
                }
                
                
                
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                
                if let text = xml.resource.Setting_vouch_pts.text {
                    items.append(text)
                }
                if let text = xml.resource.Setting_bal_wallet.text {
                    items.append(text)
                    print("text",text)
                }
                
                if let text = xml.resource.Setting_acc_settings.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_my_wallet.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_invite_earn.text {
                    settingsitems.append(text)
                }
                
                // Changes by Praveen
                
                if let text = xml.resource.Setting_notification.text {
                    settingsitems.append(text)
                }
                
                // Changes by Praveen
                
                
                
                if let text = xml.resource.Setting_trans_history.text {
                    settingsitems.append(text)
                }
                
                if let text = xml.resource.Setting_Language.text {
                    settingsitems.append(text)
                    lblLanguage.text = text
                }
                
                
                if let text = xml.resource.Setting_Cust_Support.text {
                    settingsitems.append(text)
                }
               
                if let text = xml.resource.Setting_DRSM.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_About.text {
                    settingsitems.append(text)
                }
               
                
                if let text = xml.resource.Setting_SIGN_OUT.text {
                    btnSignOut.setTitle(text, for: .normal)
                }
                print("items",items)
                print("settingsitems",settingsitems)
                
                if let text = xml.resource.Account_Setting_cancel.text {
                    btnCancel.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Setting_yes.text {
                    btnYes.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Setting_no.text {
                    btnNo.setTitle(text, for: .normal)
                }
                
            }
            catch(_){print("error")}
        }
        else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                languageItem.removeAll()
                let xml = try! XML.parse(text)
                if let text = xml.resource.Setting_title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_vouch_pts.text {
                    items.append(text)
                }
                if let text = xml.resource.Setting_bal_wallet.text {
                    items.append(text)
                }
                if let text = xml.resource.Setting_are_u_sure_sign_out.text {
                    lblAreUSure.text = text
                }
                if let text = xml.resource.Setting_acc_settings.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_my_wallet.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_invite_earn.text {
                    settingsitems.append(text)
                }
                
                
                
                // Changes by Praveen
                
                if let text = xml.resource.Setting_notification.text
                {
                    settingsitems.append(text)
                
                }
                
                // Changes by Praveen
                
                
                
                if let text = xml.resource.Setting_trans_history.text {
                    settingsitems.append(text)
                }
                
                if let text = xml.resource.Setting_Language.text {
                    settingsitems.append(text)
                    lblLanguage.text = text
                }
                
                
                if let text = xml.resource.Setting_Cust_Support.text {
                    settingsitems.append(text)
                }
               
                if let text = xml.resource.Setting_DRSM.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_About.text {
                    settingsitems.append(text)
                }
               
                
                if let text = xml.resource.Setting_SIGN_OUT.text {
                    btnSignOut.setTitle(text, for: .normal)
                }
                print("items",items)
                print("settingsitems",settingsitems)
                if let text = xml.resource.Account_Setting_cancel.text {
                    btnCancel.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Setting_yes.text {
                    btnYes.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Setting_no.text {
                    btnNo.setTitle(text, for: .normal)
                }
                
            }
            catch(_){print("error")}
            
            
        }
        tableViewBal.reloadData()
        tableSettings.reloadData()
        print("languageItem.removeAll() ---- ",languageItem)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewLang.layer.cornerRadius = 20.0
        viewLang.clipsToBounds = true
        btnCancel.layer.cornerRadius = btnCancel.frame.size.height/2
        
        self.title = strTitle
        self.addBackButton()
        viewLogoutBG.isHidden = true
        viewLogout.isHidden = true
        
        viewLogout.layer.cornerRadius = 15
        
        self.changeLanguage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let sharedData = SharedDefault()
        print("Access token ----- ",sharedData.getAccessToken())
        self.getSettingPageDetails()
        
        imgProfile.makeRounded()
        tableViewBal.tableFooterView = UIView()
        tableSettings.tableFooterView = UIView()
        viewBalanceBG.layer.cornerRadius = 20
        viewBalanceBG.clipsToBounds = true
        
        viewSettings.layer.cornerRadius = 20
        viewSettings.clipsToBounds = true
        btnYes.layer.cornerRadius = btnSignOut.frame.size.height/2
        btnSignOut.layer.cornerRadius = btnSignOut.frame.size.height/2
        
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: tableViewBal.frame.size.width, height: px)
        let line = UIView(frame: frame)
        tableViewBal.tableHeaderView = line
        line.backgroundColor = tableViewBal.separatorColor
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableCount = Int()
        if tableView == tableViewBal {
            tableCount = items.count
        }
        else if tableView == tableSettings
        {
            tableCount = settingsitems.count
        }
        else if tableView == tableLanguage {
            tableCount = languageCode.count
        }
        return tableCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableViewBal {
            let cellBal = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SettingsTableCell
            if indexPath.row == 0 {
                cellBal.lblValue.textColor = Constants.textRedColor
            } else {
                cellBal.lblValue.textColor = Constants.textColor
            }
            cellBal.selectionStyle = .none
            cellBal.lblContent.text = items[indexPath.row]
            cellBal.lblValue.text = itemValue[indexPath.row]
            cell = cellBal
        } else if tableView == tableSettings {
            let cellBal = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SettingsTableCell
            cellBal.lblContent.text = settingsitems[indexPath.row]
            cellBal.selectionStyle = .none
            //cellBal.lblValue.text = itemValue[indexPath.row]
            cell = cellBal
        }else if tableView == tableLanguage {
            let cellBal = tableLanguage.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
            cellBal.backgroundColor = UIColor.white
            cellBal.selectionStyle = .none
            //cellBal.lblCountry.text = languageItem[indexPath.row]
            cellBal.lblLanguage.text = languageItem[indexPath.row]
            //cellBal.lblLanguage.text = languageItem[indexPath.row]
            
            cell = cellBal
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableSettings {
            if indexPath.row == 0 {
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingsVC") as! AccountSettingsVC
                self.navigationController?.pushViewController(next, animated: true)
                
            }
            else  if indexPath.row == 1 {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "TopUpWalletVC") as! TopUpWalletVC
                self.navigationController?.pushViewController(next, animated: true)
                
            }
            else  if indexPath.row == 2 {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "InviteAndEarnVC") as! InviteAndEarnVC
                self.navigationController?.pushViewController(next, animated: true)
            }
            else  if indexPath.row == 3
            {
//                let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryVC") as! TransactionHistoryVC
//                self.navigationController?.pushViewController(next, animated: true)
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
                self.navigationController?.pushViewController(next, animated: true)
            }
            else  if indexPath.row == 4
            {
                //TransactionHistoryVC
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryVC") as! TransactionHistoryVC
                self.navigationController?.pushViewController(next, animated: true)
                
                
                
                
            }
            else  if indexPath.row == 5
            {
                
                //Language
                
                btnCancel.isHidden = false
                viewLanguageBG.isHidden = false
                viewLang.isHidden = false
                
                
            }
            else  if indexPath.row == 6
            {
                
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomerSupportVC") as! CustomerSupportVC
                self.navigationController?.pushViewController(next, animated: true)
               
               
            }
            else  if indexPath.row == 7
            {
                
                
                //CustomerSupportVC
                //https://apps.apple.com/us/app/drs-merchant/id1514558880?ls=1
                if let url = URL(string: "itms-apps://apps.apple.com/us/app/drs-merchant/id1514558880?ls=1"),
                    UIApplication.shared.canOpenURL(url)
                {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
                
               
            }
            else  if indexPath.row == 8
            {
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
                self.navigationController?.pushViewController(next, animated: true)
//                let next = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
//                self.navigationController?.pushViewController(next, animated: true)
            }
            
            
            
        }else if tableView == tableLanguage {
            btnCancel.isHidden = true
            viewLanguageBG.isHidden = true
            viewLang.isHidden = true
            let sharedDefault = SharedDefault()
            sharedDefault.setLanguage(language: languageCode[indexPath.row])
            self.changeLanguage()
            print("sharedDefault  ",sharedDefault.getLanguage())
            tableViewBal.reloadData()
            tableLanguage.reloadData()
            tableSettings.reloadData()
            
        }
    }
    
    @IBAction func btnSignOutAction(_ sender: UIButton) {
        
        viewLogoutBG.isHidden = false
        viewLogout.isHidden = false
        
        
        
    }
    @IBAction func btnNoAction(_ sender: UIButton) {
        viewLogoutBG.isHidden = true
        viewLogout.isHidden = true
    }
    @IBAction func btnYesAction(_ sender: UIButton) {
        self.logout()
        
        //self.navigationController?.popToRootViewController(animated: true)
        /*
         DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
         let sharedData = SharedDefault()
         sharedData .setLoginStatus(loginStatus: false)
         
         UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
         UserDefaults.standard.synchronize()
         
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
         let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
         let navigationController = UINavigationController(rootViewController: yourVC)
         
         appDelegate.window?.rootViewController = navigationController
         appDelegate.window?.makeKeyAndVisible()
         
         self.navigationController?.popToRootViewController(animated: true)
         
         }*/
    }
    
    func getSettingPageDetails() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken() as String
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.settingsPageURL
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
                    self.settingsModel = SettingsModel(response)
                    print("self.settingsModel ",self.settingsModel!)
                    print("self.settingsModel ",self.settingsModel?.httpcode!)
                    print("self.settingsModel ",self.settingsModel?.settingsModelData)
                    let sharedDefault = SharedDefault()
                    let statusCode = Int((self.settingsModel?.httpcode)!)
                    if statusCode == 200{
                        // self.showToast(message: (self.settingsModel?.message)!)
                        //var itemValue = ["8000", "100,000 MMK"]
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                        next.AcBal = (self.settingsModel?.settingsModelData?.customerData?.accountBalance)!
                        next.VPoints = (self.settingsModel?.settingsModelData?.customerData?.voucherPoints)!
                        self.itemValue.removeAll()
                        self.itemValue.append((self.settingsModel?.settingsModelData?.customerData?.voucherPoints)!)
                        self.itemValue.append((self.settingsModel?.settingsModelData?.customerData?.accountBalance)!)
                        self.tableViewBal.reloadData()
                        self.lblName.text = (self.settingsModel?.settingsModelData?.customerData?.firstName)! + (self.settingsModel?.settingsModelData?.customerData?.lastName)!
//                        self.lblPhone.text = (self.settingsModel?.settingsModelData?.customerData?.phoneNumber)!
                        self.lblPhone.text =  String(sharedDefault.getDialCode()) + " " + (self.settingsModel?.settingsModelData?.customerData?.phoneNumber)!

                        let url = URL(string: (self.settingsModel?.settingsModelData?.customerData?.profilePic)!)
                        if url != nil{
                            self.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                        }else {
                            self.imgProfile.image = UIImage(named: "SplashImage")
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            //next.srtName = self.validateMobileModelResponse?.validateMobileModelData?.customerName as! String
                            //next.srtPhone = self.validateMobileModelResponse?.validateMobileModelData?.phoneNumber as! String
                            // self.navigationController?.pushViewController(next, animated: true)
                            self.tableViewBal.reloadData()
                        }
                        
                        
                    }
                    if statusCode == 400{
                       
                       
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.settingsModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.settingsModel?.message)!)
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
    
    func logout() {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        let sharedData:SharedDefault = SharedDefault()
        postDict = ["access_token":sharedData.getAccessToken()
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.SignOutURL
        
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
                    self.signModel = SignModel(response)
                    print("self.signModel ",self.signModel!)
                    print("self.signModel ",self.signModel?.httpcode!)
                    // print("self.signModel ",self.loginResponse?.loginData?.userData!)
                    let sharedDefault = SharedDefault()
                    let statusCode = Int((self.signModel?.httpcode)!)
                    if statusCode == 200{
                        sharedDefault .setLoginStatus(loginStatus: false)
                        sharedDefault.clearAccessToken()
                        
                        
                        //self.showToast(message: (self.signModel?.signModelData?.msg)!)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            self.viewLogoutBG.isHidden = true
                            self.viewLogout.isHidden = true
                            let sharedData = SharedDefault()
                            sharedData .setLoginStatus(loginStatus: false)
                            sharedData.clearAccessToken()
                            //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                            //UserDefaults.standard.synchronize()
                            sharedData.clearFcmToken()
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            let navigationController = UINavigationController(rootViewController: yourVC)
                            
                            appDelegate.window?.rootViewController = navigationController
                            appDelegate.window?.makeKeyAndVisible()
                            
                            self.navigationController?.popToRootViewController(animated: true)
                            
                        }
                    }
                    if statusCode == 400{
                        sharedDefault .setLoginStatus(loginStatus: false)
                        self.viewLogoutBG.isHidden = true
                        self.viewLogout.isHidden = true
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.signModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.signModel?.message)!)
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
