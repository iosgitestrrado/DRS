//
//  OurMerchantDetailVC.swift
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

class OurMerchantDetailVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate {
    private let refreshControl = UIRefreshControl()
    var ofsetValue:Int = 0
    
    var merchantListModel: MerchantListModel?
    var merchantList = [MerchantList]()
    var strTitle:String = String()
    var strSearchTitle:String = String()
    @IBOutlet var collectionCatDetail: UICollectionView!
    var categoryID: Int = Int()
    var strCategory: String = String()
    @IBOutlet var searchMerchant: UISearchBar!
    @IBOutlet var viewSearch: UIView!
    let reuseIdentifier = "CategoryDetailCell"
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Our_Merchants_look_for_category_detail.text {
                    strSearchTitle = text
                    print("strSearchTitle",strSearchTitle)
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
                
                if let text = xml.resource.Our_Merchants_look_for_category_detail.text {
                    strSearchTitle = text
                    print("strSearchTitle",text)
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
       
        ofsetValue = 0
        searchMerchant.text=""
        print("Search searchBarCancelButtonClicked")
        self.merchantList.removeAll()
        //self.getMerchantList()
         self.getMerchantList(offset: ofsetValue)
        searchMerchant.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Search bar searchBarSearchButtonClicked",searchBar.text!)
        searchMerchant.resignFirstResponder()
        self.searchMerchantPage(searchText: searchBar.text!)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.merchantList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if self.merchantList.count>0{
            if collectionView == collectionCatDetail {
                let cellCategory = collectionCatDetail.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CategoryDetailCell
                cellCategory.viewCollectionBG.layer.cornerRadius = 20
                cellCategory.viewCollectionBG.clipsToBounds = true
                
                if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
                    cellCategory.widthViewBG.constant = 340
                }
                else if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
                    cellCategory.widthViewBG.constant = 370
                    
                }
                else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max" {
                    cellCategory.widthViewBG.constant = 370
                }
                else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS" {
                    cellCategory.widthViewBG.constant = 370
                    
                }
                else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                    
                    cellCategory.widthViewBG.constant = 370
                }
                else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                    
                    cellCategory.widthViewBG.constant = 370
                }
                else {
                    cellCategory.widthViewBG.constant = 370
                    
                }
                
                if merchantList[indexPath.row].openStatus!.count > 0 {
                    cellCategory.lblShopStatus.text = merchantList[indexPath.row].openStatus!
                    
                    
                }
                
                if merchantList[indexPath.row].categoryName!.count > 0 {
                    cellCategory.lblCategory.text = merchantList[indexPath.row].categoryName!
                }
                
                if merchantList[indexPath.row].businessName!.count > 0 {
                    cellCategory.lblShopName.text = merchantList[indexPath.row].businessName!
                }
                
                if merchantList[indexPath.row].regionName!.count > 0 {
                    cellCategory.lblDistance.text =  merchantList[indexPath.row].regionName! + " " + merchantList[indexPath.row].distance! + " KM away"
                }
                
                
                if merchantList[indexPath.row].rating!.count > 0 {
                    cellCategory.lblLikes.text = merchantList[indexPath.row].rating
                    cellCategory.lblLikes .sizeToFit()
                    
                }
                
                
                
                
                
                let url = URL(string:  merchantList[indexPath.row].logo! )
                if url != nil{
                    //CGSizeMake(200.0, 200.0)
                    /*
                     let url = URL(string:  merchantList[indexPath.row].logo!)
                     let data = try? Data(contentsOf: url!)
                     
                     if let imageData = data {
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                     
                     let imageqq = UIImage(data: imageData)
                     let timage = self.resizeImage(image: imageqq!, targetSize: CGSize(width: 300, height: 200))
                     print("width  ==== ",timage.size.width)
                     print("height ==== ",timage.size.height)
                     }
                     }
                     */
                    // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    //cellCategory.imgShop.sd_setImage(with: imageNa, placeholderImage: UIImage(named: "Transparent"))
                    
                    cellCategory.imgShop.sd_setImage(with: URL(string:  merchantList[indexPath.row].logo!), placeholderImage: UIImage(named: "Transparent"))
                }else {
                    cellCategory.imgShop.image = UIImage(named: "SplashImage")
                }
                //SplashImage
                /*DispatchQueue.global().async {
                 if url != nil{
                 
                 let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                 DispatchQueue.main.async {
                 if data!.count>0{
                 cellCategory.imgShop.image = UIImage(data: data!)
                 
                 
                 }
                 
                 }
                 
                 } else {
                 cellCategory.imgShop.image = UIImage(named: "SplashImage")
                 }
                 }*/
                cell = cellCategory
                
            }
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionCatDetail {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "MerchantShopDetailVC") as! MerchantShopDetailVC
            next.shopID = merchantList[indexPath.row].merchantId
            next.strTitle = merchantList[indexPath.row].businessName
            self.navigationController?.pushViewController(next, animated: true)
        }
        
        
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = strCategory
        self.addBackButton()
        self.changeLanguage()
    }
    func searchMerchantPage(searchText:String) {
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
                        "category":"",
                        "search_key":searchText,
                        "latitude":"",
                        "longitude":"",
                        "language":lang
                
                
            ]
        } else {
            postDict = ["access_token":sharedData.getAccessToken(),
                        "category":"",
                        "search_key":searchText,
                        "latitude":sharedData.getLatitude(),
                        "longitude":sharedData.getLongitude(),
                        "language":lang
                
                
            ]
        }
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.merchantShopListURL
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
                    self.merchantListModel = MerchantListModel(response)
                    print("self.merchantListModel ",self.merchantListModel!)
                    print("self.merchantListModel ",(self.merchantListModel?.httpcode)!)
                    print("self.merchantListModel ",(self.merchantListModel?.merchantListModelData?.merchantList)!)
                    
                    let statusCode = Int((self.merchantListModel?.httpcode)!)
                    if statusCode == 200{
                        
                        if (self.merchantListModel?.merchantListModelData?.merchantList)!.count>0 {
                            self.merchantList = (self.merchantListModel?.merchantListModelData?.merchantList)!
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                                
                                if self.merchantList.count>0
                                {
                                    self.collectionCatDetail.reloadData()
                                } else
                                {
                                    self.showToast(message: "No results found")
                                    
                                }
                               
                                self.view.activityStopAnimating()
                            }
                        } else {
                            self.showToast(message: "No result found")
                        }
                        
                        
                        // let category = self.merchantModel?.merchantModelData?.categories
                        
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        if let range3 = (self.merchantListModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.merchantListModel?.message)!)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLanguage()
        
        // Do any additional setup after loading the view.
        collectionCatDetail.delegate = self
        collectionCatDetail.dataSource = self
        searchMerchant.barTintColor = UIColor.clear
        searchMerchant.backgroundColor = UIColor.red
        searchMerchant.placeholder = "placeholder"
        searchMerchant.isTranslucent = true
        print("strSearchTitle ----",strSearchTitle)
        searchMerchant.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string:strSearchTitle, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        
        let textFieldInsideSearchBar = searchMerchant.value(forKey: "searchField") as? UITextField
        let fonts = UIFont .boldSystemFont(ofSize: 16.0)
        textFieldInsideSearchBar?.font = fonts
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.borderStyle = .none
        textFieldInsideSearchBar?.textColor = UIColor.white
        let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
        if let textField = searchMerchant.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        let sharedDefault = SharedDefault()



        
        
        if sharedDefault.getLanguage() == 1
        {
            
            self.searchMerchant.setValue("ပယ်ဖျက်မည်", forKey: "cancelButtonText")


        }
        else
        {
            
            self.searchMerchant.setValue("Cancel", forKey: "cancelButtonText")


        }
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *)
        {
            collectionCatDetail.refreshControl = refreshControl
        }
        else
        {
            collectionCatDetail.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).clearButtonMode = .never
        searchMerchant.delegate = self
        //searchMerchant.showsCancelButton = true
        searchMerchant.showsCancelButton = true
        //self.getMerchantList()
        self.getMerchantList(offset: ofsetValue)
        searchMerchant.placeholder = "placeholder"

    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        //Bottom Refresh

        if scrollView == collectionCatDetail {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                
                print("bottomRefresh ----------------------------------> ",ofsetValue)
                print("Fetch bottom Data")
                ofsetValue = ofsetValue + 10
                 self.getMerchantList(offset: ofsetValue)
                //self.getMerchantList()
                print("ofsetValue ----------------------------------> ",ofsetValue)


            }
        }
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        //fetchWeatherData()
        print("Fetch Weather DataMerchantDetails")
        refreshControl.endRefreshing()
        ofsetValue = ofsetValue + 10
         self.getMerchantList(offset: ofsetValue)
        
        print("ofsetValue ----------------------------------> ",ofsetValue)
        //self.getMerchantList()
    }
    
    func getMerchantList(offset:Int)
    {
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
        if defaults.object(forKey: "Latitude") == nil || defaults.object(forKey: "Longitude") == nil
        {
            postDict = ["access_token":sharedData.getAccessToken(),
                        "category":String(categoryID),
                        "search_key":"",
                        "latitude":"",
                        "longitude":"",
                        "offset":String(offset),
                        "language":lang
                
            ]
        }
        else
        {
            postDict = ["access_token":sharedData.getAccessToken(),
                        "category":String(categoryID),
                        "search_key":"",
                        "latitude":sharedData.getLatitude(),
                        "longitude":sharedData.getLongitude(),
                        "offset":String(offset),
                        "language":lang
                
            ]
        }
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.merchantShopListURL
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
                    self.merchantListModel = MerchantListModel(response)
                    print("self.merchantDetailModel ",self.merchantListModel!)
                    print("self.merchantDetailModel ",(self.merchantListModel?.httpcode)!)
                    print("self.merchantDetailModel ",(self.merchantListModel?.merchantListModelData)!)
                    
                    let statusCode = Int((self.merchantListModel?.httpcode)!)
                    if statusCode == 200{
                        //self.merchantList = (self.merchantListModel?.merchantListModelData?.merchantList)!
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            
                            if (self.merchantListModel?.merchantListModelData?.merchantList)!.count>0
                            {
                                if self.merchantList.count>0
                                {
                                    self.merchantList .append(contentsOf: (self.merchantListModel?.merchantListModelData?.merchantList)!)
                                }
                                else {
                                    self.merchantList = (self.merchantListModel?.merchantListModelData?.merchantList)!
                                }
                            }
                            else {
                                let sharedDefault = SharedDefault()
                                if sharedDefault.getLanguage() == 1 {
                                    self.showToast(message:Constants.noRecordBur )
                                } else  if sharedDefault.getLanguage() == 0 {
                                    self.showToast(message:Constants.noRecordEng )
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                   // self.navigationController?.popViewController(animated: true)
                                }
                            }
                            self.collectionCatDetail.reloadData()
                            
                           
                            /*
                            if self.merchantList.count>0
                            {
                                self.collectionCatDetail.reloadData()
                            } else
                            {
                                self.showToast(message: "No shops in this category")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                            */
                            self.view.activityStopAnimating()
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.merchantListModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.merchantListModel?.message)!)
                        }
                        
                    }
                    
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }
    
    func getMerchantList() {
           let sharedData = SharedDefault()
        var lang = ""
        
        if sharedData.getLanguage() == 1 {
            //print("Bermese")
            lang = "my"
        }
        else if sharedData.getLanguage() == 0 {
            //print("Bermese")
            lang = ""
        }
           self.view.activityStartAnimating()
           var postDict = Dictionary<String,String>()
           let defaults = UserDefaults.standard
           if defaults.object(forKey: "Latitude") == nil || defaults.object(forKey: "Longitude") == nil {
               postDict = ["access_token":sharedData.getAccessToken(),
                           "category":String(categoryID),
                           "search_key":"",
                           "latitude":"",
                           "longitude":"",
                           "offset":"",
                           "language":lang
                   
               ]
           } else {
               postDict = ["access_token":sharedData.getAccessToken(),
                           "category":String(categoryID),
                           "search_key":"",
                           "latitude":sharedData.getLatitude(),
                           "longitude":sharedData.getLongitude(),
                           "offset":"",
                           "language":lang
                   
               ]
           }
           
           print("PostData: ",postDict)
           let loginURL = Constants.baseURL+Constants.merchantShopListURL
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
                       self.merchantListModel = MerchantListModel(response)
                       print("self.merchantDetailModel ",self.merchantListModel!)
                       print("self.merchantDetailModel ",(self.merchantListModel?.httpcode)!)
                       print("self.merchantDetailModel ",(self.merchantListModel?.merchantListModelData)!)
                       
                       let statusCode = Int((self.merchantListModel?.httpcode)!)
                       if statusCode == 200{
                           self.merchantList = (self.merchantListModel?.merchantListModelData?.merchantList)!
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                               
                               if self.merchantList.count>0
                               {
                                   self.collectionCatDetail.reloadData()
                               } else
                               {
                                   self.showToast(message: "No shops in this category")
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                       self.navigationController?.popViewController(animated: true)
                                   }
                               }
                               
                               //let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                               //next.srtName = self.validateMobileModelResponse?.validateMobileModelData?.customerName as! String
                               //next.srtPhone = self.validateMobileModelResponse?.validateMobileModelData?.phoneNumber as! String
                               // self.navigationController?.pushViewController(next, animated: true)
                               self.view.activityStopAnimating()
                           }
                           
                           
                       }
                       if statusCode == 400{
                           
                           self.view.activityStopAnimating()
                           if let range3 = (self.merchantListModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                               self.showAlert(title: Constants.APP_NAME, message: (self.merchantListModel?.message)!)
                           }
                           
                       }
                       
                       
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
