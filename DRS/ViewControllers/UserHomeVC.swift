//
//  UserHomeVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/22/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import CoreLocation
import SwiftyXMLParser

class UserHomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblScanPay: UILabel!
    @IBOutlet weak var lblAssis: UILabel!
    @IBOutlet weak var lblMerchant: UILabel!
    var VPoints = String()
    var AcBal = String()
    var locationManager = CLLocationManager()
    var promotionArray = [Promotions]()
    var tutorialArray = [Tutorials]()
    @IBOutlet weak var lblHomeLeading: NSLayoutConstraint!
    
    @IBOutlet weak var lblMerchantTrailing: NSLayoutConstraint!
    @IBOutlet var viewAssistantHeight: NSLayoutConstraint!
    let longTitleLabel = UILabel()
      let sharedData = SharedDefault()
    @IBOutlet var lblBalance: UILabel!
    @IBOutlet var lblVP: UILabel!
    @IBOutlet weak var btnScanPay: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnMerchants: UIButton!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var viewAssitant: UIView!
    @IBOutlet weak var viewPromotions: UIView!
    @IBOutlet weak var lblPromotions: UILabel!
    @IBOutlet weak var collectionPromotions: UICollectionView!
    @IBOutlet var homeCollectionTopup: UICollectionView!
    @IBOutlet weak var collectionAssistant: UICollectionView!
    @IBOutlet var viewBalance: UIView!
    let reuseIdentifierPromo = "PromotionCollectionViewCell"
    let reuseIdentifierAssist = "AssistantCollectionViewCell"
    
    let reuseIdentifier = "HomeCollectionViewCell" // also enter this string as the cell identifier in the storyboard
    //var items = ["Top Up Wallet", "Buy Voucher Point", "Share"]
    var items = [String]()
   
    var itemsImage = ["HomeTop", "Voucher", "Share"]
    //var itemsImage = ["HomeTop", "Voucher"]
    
    var dashdoardModel: DashdoardModel?
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        items.removeAll()
        print("getLanguage", sharedDefault.getLanguage())
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                lblHomeLeading.constant = 15
                lblMerchantTrailing.constant = 20
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.home_page_MMK.text {
                    print("text1",text)
                }
                if let text = xml.resource.home_page_VP.text {
                    print("text1",text)
                }
                if let text = xml.resource.home_page_top_up_wallet.text {
                    items.append(text)
                    print("items ---",items)
                }
                if let text = xml.resource.home_page_buy_voucher_pt.text {
                    items.append(text)
                    print("items ---",items)
                }
                if let text = xml.resource.home_page_share.text {
                    items.append(text)
                    print("home_page_share ---",items)
                }
                if let text = xml.resource.home_page_promtions.text {
                    lblPromotions.text = text
                }
                if let text = xml.resource.home_page_assistant.text {
                    lblAssis.text = text
                }
                if let text = xml.resource.home_page_home.text {
                     lblHome.text = text
                }
                
                if let text = xml.resource.home_page_scan_pay.text {
                     lblScanPay.text = text
                }
                if let text = xml.resource.home_page_merchant.text {
                    lblMerchant.text = text
                }
                
            
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                 lblHomeLeading.constant = 33
                lblMerchantTrailing.constant = 25
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.home_page_MMK.text {
                    print("text1",text)
                }
                if let text = xml.resource.home_page_VP.text {
                    print("text1",text)
                }
                if let text = xml.resource.home_page_top_up_wallet.text {
                    items.append(text)
                }
                if let text = xml.resource.home_page_buy_voucher_pt.text {
                    items.append(text)
                }
                if let text = xml.resource.home_page_share.text {
                    items.append(text)
                    print("items ---",items)
                }
                if let text = xml.resource.home_page_promtions.text {
                    lblPromotions.text = text
                }
                if let text = xml.resource.home_page_assistant.text {
                    lblAssis.text = text
                }
                if let text = xml.resource.home_page_home.text {
                     lblHome.text = text
                }
                
                if let text = xml.resource.home_page_scan_pay.text {
                     lblScanPay.text = text
                }
                if let text = xml.resource.home_page_merchant.text {
                    lblMerchant.text = text
                }
                print("items",items)
            
            }
            catch(_){print("error")}
            
            
        }
        homeCollectionTopup.reloadData()
    }
   
    @IBAction func btnAssitantListingAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "AssistantVC") as! AssistantVC
        next.tutorialArray = self.tutorialArray
         self.navigationController?.pushViewController(next, animated: true)
        
    }
    @IBAction func btnmoveAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "PromotionListVC") as! PromotionListVC
        next.promotionArray = self.promotionArray
        self.navigationController?.pushViewController(next, animated: true)
        /*   let collectionBounds = self.collectionPromotions.bounds
         let contentOffset = CGFloat(floor(self.collectionPromotions.contentOffset.x + collectionBounds.size.width))
         self.moveCollectionToFrame(contentOffset: contentOffset)*/
    }
   
    
    func getDashboardDetails() {
         self.view.activityStartAnimating()
      
        var lang:String?
        
        if sharedData.getLanguage() == 0 {
            lang = "eng"
           
             
        } else if sharedData.getLanguage() == 1 {
             lang = "my"
        }
         var postDict = Dictionary<String,String>()
         postDict = ["access_token":sharedData.getAccessToken(),
                     "language":lang!
         ]
        print("postDict --- ",postDict)
         let loginURL = Constants.baseURL+Constants.DashboardURL
         print("loginURL --- ",loginURL)
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
         self.dashdoardModel = DashdoardModel(response)
         print("self.dashdoardModel ",self.dashdoardModel!)
         print("self.dashdoardModel ",self.dashdoardModel?.httpcode!)
       
         
         let statusCode = Int((self.dashdoardModel?.httpcode)!)
         if statusCode == 200{
            self.AcBal = (self.dashdoardModel?.dashdoardModelData?.customerData?.accountBalance)!
            self.VPoints = (self.dashdoardModel?.dashdoardModelData?.customerData?.voucherPoints)!
            self.lblBalance.text = self.AcBal
            self.lblVP.text = self.VPoints
            if self.sharedData.getLanguage() == 0 {
                var greet:String = ""
                
                if (self.dashdoardModel?.dashdoardModelData?.greetingMsg)! == "Good Afternoon" {
                    greet = "Good Afternoon"
                } else if(self.dashdoardModel?.dashdoardModelData?.greetingMsg)! == "Good Morning" {
                    greet = "Good Morning"
                }
                else if(self.dashdoardModel?.dashdoardModelData?.greetingMsg)! == "Good Evening" {
                    greet = "Good Evening"
                }
                
                self.longTitleLabel.text = greet + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.firstName!)! + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.lastName!)!
            }
            else if self.sharedData.getLanguage() == 1 {
                var greet:String = ""
                if (self.dashdoardModel?.dashdoardModelData?.greetingMsg)! == "Good Afternoon" {
                    greet = "မင်္ဂလာနေ့လည်ခင်း"
                } else if(self.dashdoardModel?.dashdoardModelData?.greetingMsg)! == "Good Morning" {
                    greet = "မင်္ဂလာနံနက်ခင်းပါ"
                }
                else if(self.dashdoardModel?.dashdoardModelData?.greetingMsg)! == "Good Evening" {
                    greet = "မင်္ဂလာညနေခင်းပါ"
                }
                self.longTitleLabel.text = greet + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.firstName!)! + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.lastName!)!
            }
            print("555 ------- ",(self.dashdoardModel?.dashdoardModelData?.greetingMsg)! + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.firstName!)! + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.lastName!)!)
            self.longTitleLabel.textColor = UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0)
                // self.longTitleLabel.text = (self.dashdoardModel?.dashdoardModelData?.greetingMsg)! + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.firstName!)! + " " + (self.dashdoardModel?.dashdoardModelData?.customerData?.lastName!)!
            self.longTitleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
                  //[longTitleLabel, setFont:[UIFont boldSystemFontOfSize:16]];
            self.longTitleLabel.sizeToFit()
            let leftItem = UIBarButtonItem(customView: self.longTitleLabel)
                  self.navigationItem.leftBarButtonItem = leftItem
            
            self.promotionArray = (self.dashdoardModel?.dashdoardModelData?.promotions)!
            self.tutorialArray = (self.dashdoardModel?.dashdoardModelData?.tutorials)!
            
            self.viewAssistantHeight.constant =  CGFloat(self.tutorialArray.count) * 60.0 + 80.0
            
            self.collectionAssistant.reloadData()
            self.collectionPromotions.reloadData()
                  
            
         }
         
            if statusCode == 400{
                if let range3 = (self.dashdoardModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                    self.showAlert(title: Constants.APP_NAME, message: (self.dashdoardModel?.message)!)
                }
                
            }
         
         self.view.activityStopAnimating()
         
         }
         catch let err {
         print("Error::",err.localizedDescription)
         }
         }
         }
        homeCollectionTopup.reloadData()
         }
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var countVar:Int = 0
        if collectionView == collectionPromotions {
            countVar = self.promotionArray.count
        }
        else if collectionView == homeCollectionTopup {
             countVar = items.count
        }
        else if collectionView == collectionAssistant {
             countVar = tutorialArray.count
        }
        
        return countVar
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionPromotions {
            let promotionCell = collectionPromotions.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPromo, for: indexPath as IndexPath) as! PromotionCollectionViewCell
            promotionCell.viewBG.layer.cornerRadius = 20
            //promotionCell.lblCellPromotion.text = "Don't miss out the special offer"
            promotionCell.lblCellPromotion.text = self.promotionArray[indexPath.row].title
            
            
            promotionCell.imgviewCollection.roundCorners(corners: [.topLeft,.topRight], radius: 20)
            promotionCell.imgviewCollection.sd_setImage(with: URL(string: self.promotionArray[indexPath.row].image!), placeholderImage: nil)
            cell = promotionCell
            
        }
        else if collectionView == homeCollectionTopup {
            let homeCell = homeCollectionTopup.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as!  HomeCollectionViewCell
            
            homeCell.viewCellBG.layer.cornerRadius = 20
            homeCell.lblNameCollectionCell.text = items[indexPath.row]
            homeCell.lblNameCollectionCell.layer.cornerRadius = 20
            homeCell.lblNameCollectionCell.numberOfLines = 0
            homeCell.imgCollectionCell.image = UIImage(named: itemsImage[indexPath.row])
            homeCell.lblNameCollectionCell.sizeToFit()
            
            
            if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
                homeCell.cellWidth.constant = 110
                
            }
            cell = homeCell
        }
        else if collectionView == collectionAssistant {
            let assistCell = collectionAssistant.dequeueReusableCell(withReuseIdentifier: reuseIdentifierAssist, for: indexPath as IndexPath) as!  AssistantCollectionViewCell
            assistCell.viewBG.layer.cornerRadius = assistCell.viewBG.frame.size.height/2
            assistCell.lblHeadAsisit.text = self.tutorialArray[indexPath.row].title
            assistCell.lblDetail.text = self.tutorialArray[indexPath.row].subTitle
             
            assistCell.imgViewAssist.sd_setImage(with: URL(string: self.tutorialArray[indexPath.row].image!), placeholderImage: nil)
             //cellCategory.imgCategory.sd_setImage(with: URL(string: categoryItems[indexPath.row].categoryImg!), placeholderImage: UIImage(named: ""))
            print("Asssist")
            cell = assistCell
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if collectionView == homeCollectionTopup {
            if indexPath.row == 0
            {
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "TopUpWalletVC") as! TopUpWalletVC
                self.navigationController?.pushViewController(next, animated: true)
                
               /* let next = self.storyboard?.instantiateViewController(withIdentifier: "MerchantShopDetailVC") as! MerchantShopDetailVC
                next.strTitle = "Merchant Details"
                self.navigationController?.pushViewController(next, animated: true)
 */
 }
            else if(indexPath.row == 1)
            {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "TopUpVoucherPtVC") as! TopUpVoucherPtVC
                self.navigationController?.pushViewController(next, animated: true)
            }
            else if(indexPath.row == 2)
            {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "InviteAndEarnVC") as! InviteAndEarnVC
                self.navigationController?.pushViewController(next, animated: true)
            }
        }
        else if collectionView == collectionPromotions {
           
            let next = self.storyboard?.instantiateViewController(withIdentifier: "PromotionDetail") as! PromotionDetail
            next.title = ""
            next.promotionID = String(self.promotionArray[indexPath.row].id!)
            next.pagetype = true
            self.navigationController?.pushViewController(next, animated: true)
        } else if collectionView == collectionAssistant {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "PromotionDetail") as! PromotionDetail
             next.title = ""
            next.promotionID = String(self.tutorialArray[indexPath.row].id!)
            next.pagetype = false
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    func moveCollectionToFrame(contentOffset : CGFloat) {

        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionPromotions.contentOffset.y ,width : self.collectionPromotions.frame.width,height : self.collectionPromotions.frame.height)
        self.collectionPromotions.scrollRectToVisible(frame, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            
            let user_lat = String(format: "%f", currentLoc.coordinate.latitude)
            let user_long = String(format: "%f", currentLoc.coordinate.longitude)
            
            sharedData.setLatitude(latitude: user_lat)
            sharedData.setLongitude(longitude: user_long)
            
        } else {
             locationManager.requestWhenInUseAuthorization()
        }
        
        self.changeLanguage()
        homeCollectionTopup.reloadData()
        self.getDashboardDetails()
        self.navigationController?.navigationBar.isHidden = false
        //self.navigationItem.setHidesBackButton(true, animated: true);
        self.lblBalance.text = self.AcBal
        self.lblVP.text = self.VPoints
       /*
        longTitleLabel.textColor = UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0)
        longTitleLabel.text = ""
        longTitleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        //[longTitleLabel, setFont:[UIFont boldSystemFontOfSize:16]];
        longTitleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        */
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "Settings"), for: .normal)
        button.addTarget(self, action:#selector(btnSettingsAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
        
        viewBalance.layer.cornerRadius = viewBalance.frame.size.height/2
        
        viewFooter.layer.cornerRadius = 30
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        print("screenType:", UIDevice.current.screenType)
        print("screenType:", UIDevice.current.screenType.rawValue)
        let layout = homeCollectionTopup.collectionViewLayout as? UICollectionViewFlowLayout
        
        if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
            layout?.minimumLineSpacing = 15
        }
        else if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
            layout?.minimumLineSpacing = 20
            
            
        }
        else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max" {
            layout?.minimumLineSpacing = 35
            
        }
        else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS" {
            layout?.minimumLineSpacing = 15
            
        }
        else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
            layout?.minimumLineSpacing = 35
            
        }
        else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
            layout?.minimumLineSpacing = 35
            
        }
        else {
            layout?.minimumLineSpacing = 10
            
        }
        
        
    }
    
    @objc func btnSettingsAction() {
        // Function body goes here
        print("addTapped")
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(next, animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sampleAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailOTPVC") as! PaymentDetailOTPVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func btnHomeAction(_ sender: Any) {
    }
    
    
    @IBAction func btnScanPay(_ sender: Any) {
        //ScanCodeVC
        //let next = self.storyboard?.instantiateViewController(withIdentifier: "PayCodeVC") as! PayCodeVC
        //self.navigationController?.pushViewController(next, animated: true)
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ScanCodeVC") as! ScanCodeVC
        self.navigationController?.pushViewController(next, animated: true)
        
       // ScanCodeVC
    }
    
    
    @IBAction func btnMerchantAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "OurMerchantsVC") as! OurMerchantsVC
        self.navigationController?.pushViewController(next, animated: true)
    }
}
