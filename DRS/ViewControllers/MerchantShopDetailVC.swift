//
//  MerchantShopDetailVC.swift
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

class MerchantShopDetailVC: UIViewController {
    var merchantDetailModel: MerchantDetailModel?
    let sharedDefault = SharedDefault()
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblOff: UILabel!
    @IBOutlet weak var lblOffDays: UILabel!
    @IBOutlet var lblShopDesc: UILabel!
    @IBOutlet var scrollPage: UIScrollView!
    @IBOutlet var viewBGScroll: UIView!
    @IBOutlet var imgShop: UIImageView!
    @IBOutlet var viewDetail: UIView!
    
    @IBOutlet var lblLocationHead: UILabel!
    @IBOutlet var lblLocDetails: UILabel!
    
    @IBOutlet var lblShopStatus: UILabel!
    @IBOutlet var lblLike: UILabel!
    @IBOutlet var lblShopName: UILabel!
    @IBOutlet var lblCategory: UILabel!
    
    @IBOutlet var lblDollar: UILabel!
    @IBOutlet var lblStartTime: UILabel!
    
    @IBOutlet var btnCall: UIButton!
    @IBOutlet var lblOpenHrHead: UILabel!
    
    @IBOutlet var btnDirection: UIButton!
    @IBOutlet var lblDistance: UILabel!
    
    var strPhone : String?
    var strLat : String?
    var strLong : String?
    var strBusName : String?
    
    var strTitle: String! = String()
    var shopID: String! = String()
    func changeLanguage() {
           let sharedDefault = SharedDefault()
           
           if sharedDefault.getLanguage() == 1 {
               print("Bermese")
               
               let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                  // print("text",text)
                   let xml = try! XML.parse(text)
                   
                   if let text = xml.resource.Merchant_Details_location.text {
                    lblLocationHead.text = text
                   }
                if let text = xml.resource.Merchant_Details_open_hrs.text {
                    lblOpenHrHead.text = text
                }
//                if let text = xml.resource.Merchant_Details_call.text {
//                   lblOpenHrHead.text = text
//                }
                if let text = xml.resource.Merchant_Details_direction.text {
                   btnDirection.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Merchant_Details_review.text {
                   lblReview.text = text
                }
                if let text = xml.resource.Merchant_Details_call.text {
                   btnCall.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Merchant_Details_off.text {
                    lblOff.text = text
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
                   
                  if let text = xml.resource.Merchant_Details_location.text {
                      lblLocationHead.text = text
                     }
                  if let text = xml.resource.Merchant_Details_open_hrs.text {
                      lblOpenHrHead.text = text
                  }
//                  if let text = xml.resource.Merchant_Details_call.text {
//                     lblOpenHrHead.text = text
//                  }
                  if let text = xml.resource.Merchant_Details_direction.text {
                     btnDirection.setTitle(text, for: .normal)
                  }
                  if let text = xml.resource.Merchant_Details_review.text {
                     lblReview.text = text
                  }
                  if let text = xml.resource.Merchant_Details_call.text {
                     btnCall.setTitle(text, for: .normal)
                  }
                  if let text = xml.resource.Merchant_Details_off.text {
                      lblOff.text = text
                  }
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }

    override func viewWillAppear(_ animated: Bool)
    {
        if sharedDefault.getLanguage() == 1
        {
            strTitle = "ကုန်သည်အသေးစိတ်"
        }
        else if sharedDefault.getLanguage() == 0
        {
            strTitle = "Merchant Details"

        }
        self.title = strTitle
        self.addBackButton()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLanguage()
        
        // Do any additional setup after loading the view.
        
        btnCall.layer.cornerRadius = 10
         btnDirection.layer.cornerRadius = 10
        self.getMerchantDetail()
    }
    
    @IBAction func btnReviewAction(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ShopReviewVC") as! ShopReviewVC
        next.strMerchantID = (self.merchantDetailModel?.merchantDetailData?.merchantData?.merchantId)!
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    func getMerchantDetail() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var lang = ""
        
        if sharedData.getLanguage() == 1 {
            //print("Bermese")
            lang = "my"
        }
        else if sharedData.getLanguage() == 0 {
            //print("Bermese")
            lang = ""
        }
        var postDict = Dictionary<String,String>()
         let defaults = UserDefaults.standard
                if defaults.object(forKey: "Latitude") == nil || defaults.object(forKey: "Longitude") == nil {
                    postDict = ["access_token":sharedData.getAccessToken(),
                                       "merchant_id":shopID,
                                       "latitude":"",
                                       "longitude":"",
                                       "language":lang
                               
                           ]
                } else {
                     postDict = ["access_token":sharedData.getAccessToken(),
                                       "merchant_id":shopID,
                                       "latitude":sharedData.getLatitude(),
                                       "longitude":sharedData.getLongitude(),
                                       "language":lang
                               
                           ]
                }
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.merchantShopDetailURL
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
                    self.merchantDetailModel = MerchantDetailModel(response)
                    print("self.merchantDetailModel ",self.merchantDetailModel!)
                    print("self.merchantDetailModel ",(self.merchantDetailModel?.httpcode)!)
                    print("self.merchantDetailModel ",(self.merchantDetailModel?.merchantDetailData)!)
                    
                    let statusCode = Int((self.merchantDetailModel?.httpcode)!)
                    if statusCode == 200{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            /*

                             var strPhone : String?
                             var strLat : String?
                             var strLong : String?
                             var strBusName : String?
                             */
                            
                            self.strLat = self.merchantDetailModel?.merchantDetailData?.merchantData?.locationLat
                            self.strLong = self.merchantDetailModel?.merchantDetailData?.merchantData?.locationLong
                            
                            self.strPhone = self.merchantDetailModel?.merchantDetailData?.merchantData?.businessContactNumber
                        
                            let url = URL(string:  (self.merchantDetailModel?.merchantDetailData?.merchantData?.logo)! )
                            if url != nil{
                                self.imgShop.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                            }else {
                                self.imgShop.image = UIImage(named: "SplashImage")
                            }
                            
                            self.lblCategory.text = self.merchantDetailModel?.merchantDetailData?.merchantData?.categoryName!
                            self.lblShopName.text = self.merchantDetailModel?.merchantDetailData?.merchantData?.businessName!
                            self.lblLike.text = self.merchantDetailModel?.merchantDetailData?.merchantData?.rating!
                            self.lblShopStatus.text = self.merchantDetailModel?.merchantDetailData?.merchantData?.openStatus!
                            self.lblLocDetails.text = self.merchantDetailModel?.merchantDetailData?.merchantData?.address!
                            self.lblDistance.text =  (self.merchantDetailModel?.merchantDetailData?.merchantData?.distance!)! + " KM away"
                            self.lblStartTime.text = (self.merchantDetailModel?.merchantDetailData?.merchantData?.openTime!)! + "-" + (self.merchantDetailModel?.merchantDetailData?.merchantData?.closeTime!)!
                            self.lblShopDesc.text = ""
                            self.lblOffDays.text = (self.merchantDetailModel?.merchantDetailData?.merchantData?.offDays!)!
                            
                            
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                       
                        self.view.activityStopAnimating()
                        if let range3 = (self.merchantDetailModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                         let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if sharedDefault.getLanguage() == 0 {
                                self.showToast(message:Constants.InvalidAccessEng )
                            }
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                let customViewControllersArray : NSArray = [newViewController]
                                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            
                        } else {
                            self.showAlert(title: Constants.APP_NAME, message: (self.merchantDetailModel?.message)!)
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
    
    @IBAction func btnDirectionAction(_ sender: Any) {
        
        if self.strLat!.count>0 && self.strLong!.count>0 {
            let mapString:String? = "comgooglemaps://?saddr=" + sharedDefault.getLatitude() + "," + sharedDefault.getLongitude() + "&daddr=" + self.strLat! + "," +  self.strLong! + "&directionsmode=driving"
             
            // var mapString:String? = "comgooglemaps://?saddr=" + sharedDefault.getLatitude() + "," + sharedDefault.getLongitude() + "&daddr=" +self.strLat + "," +  self.strLong + "&directionsmode=driving"
             
             if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
               UIApplication.shared.openURL(URL(string:
                 mapString!)!)
                 
                 //comgooglemaps://?saddr=8.8932,76.6141&daddr=8.5581,76.8816&directionsmode=driving
             } else {
                self.showToast(message: "Install Google map")
             }
        } else {
             self.showToast(message: "Location not available")
        }
        
        
        
        
    }


    @IBAction func btnCallAction(_ sender: Any) {
        
        
        
        if self.strPhone!.count>0 {
            if let phoneCallURL = URL(string: "tel://\(self.strPhone!)") {

              let application:UIApplication = UIApplication.shared
              if (application.canOpenURL(phoneCallURL)) {
                  application.open(phoneCallURL, options: [:], completionHandler: nil)
              }
            } else {
                self.showToast(message: "Phone is currently unavailable")
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
