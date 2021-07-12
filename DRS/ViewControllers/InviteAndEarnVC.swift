//
//  InviteAndEarnVC.swift
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

class InviteAndEarnVC: UIViewController {
    var strWhatsAppMsg: String = " Your Invite Code is "
    var strWhatsAppMsg1: String = " https://apps.apple.com/us/app/drs-user/id1516639728 \n https://play.google.com/store/apps/details?id=com.drs.drsuser"
    var strWhatsAppMsg2: String = ""
    
    //var strWhatsAppMsg1: String = " Your Invite Code is \""
    // var strWhatsAppMsg2: String = "\"\n Android Download: https://play.google.com/store/apps/details?id=com.drs.drsuser \n\n Apple Download: https://apps.apple.com/us/app/drs-user/id1516639728"
    var strTitle:String = String()
    
    @IBOutlet weak var lblWhat: UILabel!
    @IBOutlet weak var btnWhat: UIButton!
    @IBOutlet weak var lblInviteCode: UILabel!
    
    @IBOutlet weak var lblMore: UILabel!
    @IBOutlet weak var lblEarn: UILabel!
    
    @IBOutlet var btnMore: UIButton!
    @IBOutlet var imgMore: UIImageView!
    @IBOutlet var viewMore: UIView!
    @IBOutlet var lblRefCode: UILabel!
    var inviteEarnModel:InviteEarnModel?
    
    @IBOutlet var lblNow: UILabel!
    @IBOutlet var lblPtEarn: UILabel!
    @IBOutlet weak var btnViewCommission: UIButton!
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var lblCommission: UILabel!
    @IBOutlet weak var btnWithDrawal: UIButton!
    @IBOutlet weak var viewCommission: UIView!
    @IBOutlet weak var viewInvitecode: UIView!
    @IBOutlet weak var viewWhatsApp: UIView!
    @IBOutlet weak var imgInvite: UIImageView!
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Setting_invite_earn.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Invite_and_Earn_u_have_earn.text {
                    print("Invite_and_Earn_u_have_earn --------",text)
                    lblEarn.text = text
                }
                if let text = xml.resource.Invite_and_Earn_for_now.text {
                    print("Invite_and_Earn_for_now --------",text)
                    lblNow.text = text
                }
                if let text = xml.resource.Invite_and_Earn_ur_invite_code.text {
                    print("Invite_and_Earn_ur_invite_code --------",text)
                    lblInviteCode.text = text
                }
                if let text = xml.resource.Invite_and_Earn_share_via_watsap.text {
                    print("Invite_and_Earn_share_via_watsap --------",text)
                    //btnWhat.setTitle(text, for: .normal)
                    lblWhat.text = text
                }
                if let text = xml.resource.Invite_and_Earn_more.text {
                    print("Invite_and_Earn_more --------",text)
                    lblMore.text = text
                }
                if let text = xml.resource.Invite_and_Earn_commission_history.text {
                    print("Invite_and_Earn_commission_history --------",text)
                    lblCommission.text = text
                }
                if let text = xml.resource.Invite_and_Earn_view.text {
                    print("Invite_and_Earn_view --------",text)
                    lblView.text = text
                }
                if let text = xml.resource.Invite_and_Earn_withdrawal.text {
                    print("Invite_and_Earn_withdrawal --------",text)
                    btnWithDrawal.setTitle(text, for: .normal)
                }
                
                
                
                
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            print("English")
            
            let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
               // print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.Setting_invite_earn.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Setting_invite_earn.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Invite_and_Earn_u_have_earn.text {
                    print("Invite_and_Earn_u_have_earn --------",text)
                    lblEarn.text = text
                }
                if let text = xml.resource.Invite_and_Earn_for_now.text {
                    print("Invite_and_Earn_for_now --------",text)
                    lblNow.text = text
                }
                if let text = xml.resource.Invite_and_Earn_ur_invite_code.text {
                    print("Invite_and_Earn_ur_invite_code --------",text)
                    lblInviteCode.text = text
                }
                if let text = xml.resource.Invite_and_Earn_share_via_watsap.text {
                    print("Invite_and_Earn_share_via_watsap --------",text)
                    lblWhat.text = text
                }
                if let text = xml.resource.Invite_and_Earn_more.text {
                    print("Invite_and_Earn_more --------",text)
                    lblMore.text = text
                }
                if let text = xml.resource.Invite_and_Earn_commission_history.text {
                    print("Invite_and_Earn_commission_history --------",text)
                    lblCommission.text = text
                }
                if let text = xml.resource.Invite_and_Earn_view.text {
                    print("Invite_and_Earn_view --------",text)
                    lblView.text = text
                }
                if let text = xml.resource.Invite_and_Earn_withdrawal.text {
                    print("Invite_and_Earn_withdrawal --------",text)
                    btnWithDrawal.setTitle(text, for: .normal)
                }
                
                
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    @IBAction func btnMoreAction(_ sender: Any) {
        // text to share
        let text = self.strWhatsAppMsg2
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnWithDrawal.layer.cornerRadius = btnWithDrawal.frame.size.height/2
        viewInvitecode.layer.cornerRadius = 25
        viewWhatsApp.layer.cornerRadius = 10
        viewCommission.layer.cornerRadius = 25
        viewCommission.clipsToBounds = true
        
        lblNow.layer.cornerRadius = lblNow.frame.size.height/2
        lblPtEarn.layer.cornerRadius = lblPtEarn.frame.size.height/2
        lblNow.clipsToBounds = true
        lblPtEarn.clipsToBounds = true
        
        viewInvitecode.clipsToBounds = true
        
        self.getReferralDetails()
        self.changeLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
        
    }
    
    @IBAction func btnWhatsAppAction(_ sender: UIButton) {
        
//        let urlString = "whatsapp://send?text=" + self.strWhatsAppMsg2
//
//        let backImage = UIImage(named: "BackNav")
//        print("urlString ",urlString)
//
//        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//        let URL = NSURL(string: urlStringEncoded!)
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(URL! as URL, options: [:], completionHandler: nil)
//        }
//        else {
//            UIApplication.shared.openURL(URL! as URL)
//        }
        let urlString = "whatsapp://send?text=" + self.strWhatsAppMsg2
        if let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString)
            {
                if UIApplication.shared.canOpenURL(whatsappURL as URL)
                {
                    if #available(iOS 10.0, *)
                    {
                        UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
                    }
                    else
                    {
                        UIApplication.shared.openURL(whatsappURL as URL)
                    }
                    
                }
                else
                {
                  print("Cannot open whatsapp")
                    let sharedDefault = SharedDefault()

                    if sharedDefault.getLanguage() == 1
                    {
                        self.showToast(message: "Whatsapp ကို install လုပ်မထား")
                    }
                    else if sharedDefault.getLanguage() == 0
                    {
                        self.showToast(message: "Whatsapp not installed")
                    }
                    
                }
            }
        }
        
        
    }
    @IBAction func btnViewCommissionAction(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ReferalRewardsVC") as! ReferalRewardsVC
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func btnWithdrawAction(_ sender: UIButton) {
        //WithdrawalVC
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalVC") as! WithdrawalVC
        self.navigationController?.pushViewController(next, animated: true)
        
        
    }
    
    func getReferralDetails() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken()
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.ReferalInviteURL
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
                    //96TAQul3YG
                    let response = JSON(data.data!)
                    self.inviteEarnModel = InviteEarnModel(response)
                    print("self.inviteEarnModel ",self.inviteEarnModel!)
                    print("self.inviteEarnModel ",self.inviteEarnModel?.httpcode!)
                    
                    //let sharedDefault = SharedDefault()
                    let statusCode = Int((self.inviteEarnModel?.httpcode)!)
                    if statusCode == 200{
                        self.lblPtEarn.text = (self.inviteEarnModel?.inviteEarnModelData?.earnings)!
                        self.lblRefCode.text = (self.inviteEarnModel?.inviteEarnModelData?.referalId)!
                        self.strWhatsAppMsg2 = self.strWhatsAppMsg + (self.inviteEarnModel?.inviteEarnModelData?.referalId)! +  self.strWhatsAppMsg1
                        
                        //self.strWhatsAppMsg = self.strWhatsAppMsg1 + (self.inviteEarnModel?.inviteEarnModelData?.referalId)! + self.strWhatsAppMsg2
                        
                        //(self.inviteEarnModel?.inviteEarnModelData?.referalId)! + self.strWhatsAppMsg
                    }
                    if statusCode == 400{
                        
                        self.showAlert(title: Constants.APP_NAME, message: (self.inviteEarnModel?.message)!)
                        self.view.activityStopAnimating()
                        if let range3 = (self.inviteEarnModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.inviteEarnModel?.message)!)
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
