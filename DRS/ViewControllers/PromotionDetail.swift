
//
//  AboutUsVC.swift
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

class PromotionDetail: UIViewController {
    
     var pageNotiyfytype:Bool = false
    
    var pagetype:Bool = false
    @IBOutlet var btnShare: UIButton!
    var strTitle:String = ""
    
    @IBOutlet var imgShare: UIImageView!
    @IBOutlet var imgViewPromotion: UIImageView!
    @IBOutlet var lblHeader: UILabel!
    var promotionModel: PromotionModel?
    var assistantModel: AssistantModel?
    @IBOutlet var lblDescription: UILabel!
    var promotionID:String = String()
    let sharedData = SharedDefault()
    @IBOutlet var viewContent: UIView!
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if pagetype == true {
                    if let text = xml.resource.home_page_promotion_detail.text {
                        strTitle = text
                        //self.title = strTitle
                    }
                } else {
                    if let text = xml.resource.home_page_assistant_detail.text {
                        strTitle = text
                        //self.title = strTitle
                    }
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
                if pagetype == true {
                    if let text = xml.resource.home_page_promotion_detail.text {
                        strTitle = text
                        //self.title = strTitle
                    }
                } else {
                    if let text = xml.resource.home_page_assistant_detail.text {
                        strTitle = text
                        //self.title = strTitle
                    }
                }
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.changeLanguage()
        self.navigationController?.navigationBar.isHidden = false
        self.addBackButton()
        if pagetype == true {
            //self.title = strTitle
            btnShare.isHidden = false
            imgShare.isHidden = false
            
        } else {
            //self.title = strTitle
            btnShare.isHidden = true
            imgShare.isHidden = true
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if pagetype == true {
            self.getPromotionDetails(stringURL:Constants.baseURL+Constants.PromotionDetailURL)
        } else {
            self.getPromotionDetails(stringURL:Constants.baseURL+Constants.AssistantDetailURL)
        }
        
        
        
    }
    
    @IBAction func btnPromotionShareAction(_ sender: UIButton)
    {
        // text to share
        var text = ""
        if self.pagetype == true {
            text = (self.promotionModel?.promotionModelData?.promotionData?.title)! + " " + (self.promotionModel?.promotionModelData?.promotionData?.image)!
            /*//text = (self.promotionModel?.promotionModelData?.promotionData?.description)!
             self.imgViewPromotion.sd_setImage(with: URL(string: (self.promotionModel?.promotionModelData?.promotionData?.image)!), placeholderImage: nil)
             
             self.lblDescription .sizeToFit()
             self.lblHeader .sizeToFit()*/
        } else {
            /* self.lblHeader.text = (self.assistantModel?.assistantModelData?.assistantData?.title)!
             self.lblDescription.text = (self.assistantModel?.assistantModelData?.assistantData?.description)!
             self.imgViewPromotion.sd_setImage(with: URL(string: (self.assistantModel?.assistantModelData?.assistantData?.image)!), placeholderImage: nil)
             //promotionCell.imgviewCollection.sd_setImage(with: URL(string: self.promotionArray[indexPath.row].image!), placeholderImage: nil)
             self.lblDescription .sizeToFit()
             self.lblHeader .sizeToFit()*/
        }
        
        // let text = "s"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    func getPromotionDetails(stringURL:String) {
        self.view.activityStartAnimating()
        
        var lang:String?
        if sharedData.getLanguage() == 0 {
            lang = "eng"
          
             
        } else if sharedData.getLanguage() == 1 {
             lang = "my"
        }
        
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "id":promotionID,
                    "language":lang!
        ]
        print("postDict",postDict)
        let loginURL = stringURL
        
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
                    var statusCode = Int ()
                    if self.pagetype == true {
                        self.promotionModel = PromotionModel(response)
                        statusCode = Int((self.promotionModel?.httpcode)!)!
                    } else {
                        
                        self.assistantModel = AssistantModel(response)
                        statusCode = Int((self.assistantModel?.httpcode)!)!
                    }
                    //print("self.promotionModel ",self.promotionModel!)
                    // print("self.promotionModel ",self.promotionModel?.httpcode!)
                    
                    
                    
                    if statusCode == 200{
                        
                        if self.pagetype == true {
                            self.title = (self.promotionModel?.promotionModelData?.promotionData?.title)!
                            //self.lblHeader.text = (self.promotionModel?.promotionModelData?.promotionData?.title)!
                            self.lblDescription.text = (self.promotionModel?.promotionModelData?.promotionData?.description)!
                            self.imgViewPromotion.sd_setImage(with: URL(string: (self.promotionModel?.promotionModelData?.promotionData?.image)!), placeholderImage: nil)
                            //promotionCell.imgviewCollection.sd_setImage(with: URL(string: self.promotionArray[indexPath.row].image!), placeholderImage: nil)
                            self.lblDescription .sizeToFit()
                            self.lblHeader .sizeToFit()
                        } else {
                            //self.lblHeader.text = (self.assistantModel?.assistantModelData?.assistantData?.title)!
                             self.title = (self.assistantModel?.assistantModelData?.assistantData?.title)!
                            self.lblDescription.text = (self.assistantModel?.assistantModelData?.assistantData?.description)!
                            self.imgViewPromotion.sd_setImage(with: URL(string: (self.assistantModel?.assistantModelData?.assistantData?.image)!), placeholderImage: nil)
                            //promotionCell.imgviewCollection.sd_setImage(with: URL(string: self.promotionArray[indexPath.row].image!), placeholderImage: nil)
                            self.lblDescription .sizeToFit()
                            self.lblHeader .sizeToFit()
                        }
                    }
                    
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.assistantModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.assistantModel?.message)!)
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
