//
//  NewsEvents.swift
//  DRS
//
//  Created by softnotions on 04/08/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SDWebImage

class NewsEvents: UIViewController {
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var imageDet: SDAnimatedImageView!
    var newsModel:NewsModel?
    var pagetitle:String?
    var newsID:String?
    let sharedData = SharedDefault()
    //NewsEventsList
    override func viewWillAppear(_ animated: Bool) {
        
        self.addBackButton()
        print("self.sectionDetail[indexPath.section].typeId! ",newsID! as String)
        print("self ",sharedData.getAccessToken())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if Reachability.isConnectedToNetwork() {
            self.getNewsDetails()
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
    }
    // MARK: - notification list method
    func getNewsDetails() {
        self.view.activityStartAnimating()
        var lang:String?
        if sharedData.getLanguage() == 0 {
            lang = "eng"
            
        } else if sharedData.getLanguage() == 1 {
             lang = "my"
        }
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "id":newsID! as String,
                    "language":lang!
                    
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.NewsEventDetail
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
                    print("response ---- ",response)
                    self.newsModel = NewsModel(response)
                    
                    let statusCode = Int((self.newsModel?.httpcode)!)
                    if statusCode == 200{
                        //self.showToast(message: (self.validateMobileModelResponse?.message)!)
                        self.imageDet.sd_setImage(with: URL(string:  (self.newsModel?.newsModelData?.newsData?.image!)!), placeholderImage: nil)
                        self.lblDesc.text = self.newsModel?.newsModelData?.newsData?.title!
                        self.lblDetails.text = self.newsModel?.newsModelData?.newsData?.description!
                        
                        self.title = self.newsModel?.newsModelData?.newsData?.title!
                        
                    }
                    if statusCode == 400{
                        if let range3 = (self.newsModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if sharedDefault.getLanguage() == 0 {
                                self.showToast(message:Constants.InvalidAccessEng )
                            }
                            //self.showToast(message:(self.validateMobileModelResponse?.message!)! )
                            
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
                            let sharedDefault = SharedDefault()
                           if sharedDefault.getLanguage() == 0 {
                               self.showAlert(title: Constants.APP_NAME, message: (self.newsModel?.message)!)
                           } else if sharedDefault.getLanguage() == 1 {
                               self.showAlert(title: Constants.APP_NAME_BUR, message: (self.newsModel?.message)!)
                           }
                            //self.showAlert(title: Constants.APP_NAME, message: (self.validateMobileModelResponse?.message)!)
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
