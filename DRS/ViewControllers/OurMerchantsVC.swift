//
//  OurMerchantsVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//
import SDWebImage
import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class OurMerchantsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchResultsUpdating ,UISearchBarDelegate{
    var merchantModel: MerchantModel?
    var merchantListModel: MerchantListModel?
    let searchController = UISearchController(searchResultsController: nil)
    var strTitle:String = String()
    var searchTitle:String = String()
    let reuseIdentifier = "CategoryCollectionViewCell" // also enter this string as the cell identifier in the storyboard
    let reuseIdentifierNear = "ViewNearByCell" // also enter this string as the cell identifier in the storyboard
    //var items = ["Womens Accessories", "Sports", "Car & Accessories","Furnitures & Home Accessories", "Events & Accessories", "Optical & Eye-wear","Printing", "Beauty", "Others"]
    var categoryItems = [Categories]()
    var tempCategoryItems = [Categories]()
    var filterCategoryItems = [Categories]()
    var nearByItems = [MerchantsNearby]()
    var itemsImage = ["Women", "Sports", "Car","Furnitures", "Events", "Optical","Printing", "Beauty", "Others"]
    @IBOutlet var collectionNearBy: UICollectionView!
    @IBOutlet var viewNearByMerchants: UIView!
    @IBOutlet var lblMerchants: UILabel!
    @IBOutlet var viewCollection: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var collectionCategory: UICollectionView!
    
    @IBOutlet var searchMerchants: UISearchBar!
    @IBOutlet var viewContentScroll: UIView!
    @IBOutlet var scrollMerchants: UIScrollView!
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Our_Merchants_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Our_Merchants_our_near_merchant.text {
                    print("Our_Merchants_our_near_merchant",text)
                    lblMerchants.text = text
                }
                if let text = xml.resource.Our_Merchants_look_for.text {
                    print("Our_Merchants_look_for",text)
                    searchTitle = text
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
                
                if let text = xml.resource.Our_Merchants_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Our_Merchants_our_near_merchant.text {
                    print("Our_Merchants_our_near_merchant",text)
                    lblMerchants.text = text
                }
                if let text = xml.resource.Our_Merchants_look_for.text {
                    searchTitle = text
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    func getOurMerchantPage() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        let defaults = UserDefaults.standard
        var lang:String?
        
        if sharedData.getLanguage() == 0 {
            lang = "eng"
        } else if sharedData.getLanguage() == 1 {
             lang = "my"
             
        }
        if defaults.object(forKey: "Latitude") == nil || defaults.object(forKey: "Longitude") == nil {
            postDict = ["access_token":sharedData.getAccessToken(),
                        "latitude":"",
                        "longitude":"",
                        "language":lang!
                
            ]
        } else {
            postDict = ["access_token":sharedData.getAccessToken(),
                        "latitude":sharedData.getLatitude(),
                        "longitude":sharedData.getLongitude(),
                        "language":lang!
            ]
        }
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.merchantPageURL
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
                    self.merchantModel = MerchantModel(response)
                    print("self.merchantModel ",self.merchantModel!)
                    print("self.merchantModel ",(self.merchantModel?.httpcode)!)
                    print("self.merchantModel ",(self.merchantModel?.merchantModelData)!)
                    
                    let statusCode = Int((self.merchantModel?.httpcode)!)
                    if statusCode == 200{
                        // self.showToast(message: (self.settingsModel?.message)!)
                        //var itemValue = ["8000", "100,000 MMK"]
                        //var items = ["Womens Accessories", "Sports", "Car & Accessories","Furnitures & Home Accessories", "Events & Accessories", "Optical & Eye-wear","Printing", "Beauty", "Others"]
                        self.categoryItems.removeAll()
                        self.tempCategoryItems.removeAll()
                        self.tempCategoryItems = (self.merchantModel?.merchantModelData?.categories)!
                        // let category = self.merchantModel?.merchantModelData?.categories
                        self.categoryItems = (self.merchantModel?.merchantModelData?.categories)!
                        self.nearByItems = (self.merchantModel?.merchantModelData?.merchantsNearby)!
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            self.collectionCategory.reloadData()
                            self.collectionNearBy.reloadData()
                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            //next.srtName = self.validateMobileModelResponse?.validateMobileModelData?.customerName as! String
                            //next.srtPhone = self.validateMobileModelResponse?.validateMobileModelData?.phoneNumber as! String
                            // self.navigationController?.pushViewController(next, animated: true)
                            
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        if let range3 = (self.merchantModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.merchantModel?.message)!)
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
    func updateSearchResults(for searchController: UISearchController)
    {
        print("searching")
        
         let searchString = searchController.searchBar.text
//
//         filtered = items.filter({ (item) -> Bool in
//         let countryText: NSString = item as NSString
//
//         return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
//         })
//
//         collectionView.reloadData()
         
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.searchMerchants.resignFirstResponder()
                self.categoryItems = (self.merchantModel?.merchantModelData?.categories)!
                self.collectionCategory.reloadData()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Search bar",searchBar.text!)
        searchMerchants.resignFirstResponder()
        filterCategoryItems.removeAll()
        var searchString:String = searchBar.text!
        for item  in categoryItems {
            /* if item.categoryName == searchString
             {
             filterCategoryItems.append(item)
             }*/
            var str = String()
            str = item.categoryName!
            if str.contains(searchString)
            {
                filterCategoryItems.append(item)
            }
        }
        
        if filterCategoryItems.count>0
        {
            categoryItems.removeAll()
            categoryItems = filterCategoryItems
        }
        else if filterCategoryItems.count == 0
        {
            let sharedDefault = SharedDefault()
                if sharedDefault.getLanguage() == 1
                {
                    self.showToast(message: "မှတ်တမ်းမရှိသေးပါ")
                }
                else if sharedDefault.getLanguage() == 0
                {
                    self.showToast(message: Constants.NoResult)
                }
            searchBar.text = ""
        }
        //categoryItems
        
        
        collectionCategory.reloadData()
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        
        print("Search bareeeeee")
        searchMerchants.resignFirstResponder()
        if tempCategoryItems.count>0 {
            categoryItems.removeAll()
            categoryItems = tempCategoryItems
            collectionCategory.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        
        /*
         let myView = UIView(frame: CGRect(x: 0, y: (textFieldInsideSearchBar?.frame.size.height)!-1, width: (textFieldInsideSearchBar?.frame.size.width)!, height: 2))
         myView.backgroundColor = UIColor.white
         textFieldInsideSearchBar!.addSubview(myView)*/
        
        
        
        self.addBackButton()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLanguage()
        self.title = strTitle
        // Do any additional setup after loading the view.
        
        searchController.searchResultsUpdater = self
        searchMerchants.delegate = self
        searchMerchants.showsCancelButton = true
        
        self.getOurMerchantPage()
        
        let layout = MyLeftCustomFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionCategory.collectionViewLayout = layout
        
        searchMerchants.barTintColor = UIColor.clear
        searchMerchants.backgroundColor = UIColor.red
        searchMerchants.isTranslucent = true
        
        searchMerchants.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: searchTitle, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        
        let textFieldInsideSearchBar = searchMerchants.value(forKey: "searchField") as? UITextField
        let fonts = UIFont .boldSystemFont(ofSize: 16.0)
        textFieldInsideSearchBar?.font = fonts
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.borderStyle = .none
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
        
        if let textField = searchMerchants.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        let sharedDefault = SharedDefault()

        if sharedDefault.getLanguage() == 1
        {
            (searchMerchants.value(forKey: "cancelButton") as! UIButton).setTitle("ပယ်ဖျက်မည်", for: .normal)

        }
        else
        {
            (searchMerchants.value(forKey: "cancelButton") as! UIButton).setTitle("Cancel", for: .normal)

        }
        
        
        /*
         let layouts = collectionCategory.collectionViewLayout as? UICollectionViewFlowLayout
         
         if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
         layouts?.minimumLineSpacing = 15
         }
         else if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
         layouts?.minimumInteritemSpacing = 15
         
         }
         else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max" {
         layouts?.minimumLineSpacing = 35
         
         }
         else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS" {
         layouts?.minimumLineSpacing = 15
         
         }
         else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
         layouts?.minimumLineSpacing = 35
         
         }
         else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
         layouts?.minimumLineSpacing = 35
         
         }
         else {
         layouts?.minimumLineSpacing = 10
         
         }
         */
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var countVariable : Int = 0
        if collectionView == collectionCategory {
            countVariable = categoryItems.count
        }
        else if collectionView == collectionNearBy {
            countVariable = nearByItems.count
        }
        return countVariable
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionCategory {
            let cellCategory = collectionCategory.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CategoryCollectionViewCell
            
            cellCategory.CollectionViewBG.layer.cornerRadius = 20
            cellCategory.lblCatName.text = categoryItems[indexPath.row].categoryName
            let url = URL(string:  categoryItems[indexPath.row].categoryImg! )
            cellCategory.imgCategory.sd_setImage(with: URL(string: categoryItems[indexPath.row].categoryImg!), placeholderImage: UIImage(named: ""))
            DispatchQueue.global().async {
                if url != nil{
                    
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        if data!.count>0{
                            // cellCategory.imgCategory.image = UIImage(data: data!)
                            // cellCategory.imgCategory.kf.setImage(with: url)
                            
                        }
                        
                    }
                    
                }
            }
            
            //
            cell = cellCategory
            
        } else if collectionView == collectionNearBy {/** {
             "business_contact_number" = 7736388782;
             // "business_name" = shop55;
             cashback = 1;
             category = 4;
             //"category_name" = Electronic;
             "close_time" = "04:30 pm";
             country = 101;
             "country_name" = India;
             //distance = 2;
             //logo = "https://drssystem.co.uk/uat/storage/app/public/users/8/logo.png";
             "merchant_id" = 8;
             //"open_status" = "OPEN NOW";
             "open_time" = "10:30 am";
             //rating = 3;
             region = 23;
             "region_name" = "";
             }*/
            let cellNearBy = collectionNearBy.dequeueReusableCell(withReuseIdentifier: reuseIdentifierNear, for: indexPath as IndexPath) as! ViewNearByCell
            cellNearBy.viewCollectionBG.layer.cornerRadius = 20
            cellNearBy.viewCollectionBG.clipsToBounds = true
            cellNearBy.lblLikes.layer.cornerRadius = 20
            cellNearBy.lblShopName.text = nearByItems[indexPath.row].businessName
            if nearByItems[indexPath.row].openStatus == "CLOSED NOW"{
                cellNearBy.lblShopStatus.textColor = UIColor.red
            }
            cellNearBy.lblCategory.text = nearByItems[indexPath.row].categoryName
            cellNearBy.lblShopStatus.text = nearByItems[indexPath.row].openStatus
            cellNearBy.lblLikes.text = nearByItems[indexPath.row].rating
            
            cellNearBy.lblDistance.text =   nearByItems[indexPath.row].regionName! + " " +  nearByItems[indexPath.row].distance! + " KM away"
            
            let url = URL(string:  nearByItems[indexPath.row].logo! )
            cellNearBy.imgShop.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            
            
            
            //cellNearBy.CollectionViewBG.layer.cornerRadius = 20
            //cellNearBy.lblCatName.text = nearByItems[indexPath.row].businessName
            //cellCategory.imgCategory.image = UIImage(named: itemsImage[indexPath.row])
            cell = cellNearBy
            
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionCategory {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "OurMerchantDetailVC") as! OurMerchantDetailVC
            next.categoryID = categoryItems[indexPath.row].id!
            next.strCategory =  categoryItems[indexPath.row].categoryName!
            self.navigationController?.pushViewController(next, animated: true)
            
        }
        else if collectionView == collectionNearBy
        {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "MerchantShopDetailVC") as! MerchantShopDetailVC
            next.shopID = nearByItems[indexPath.row].merchantId
            next.strTitle = nearByItems[indexPath.row].businessName
            
           
            next.strTitle = "Merchant Details"

            //next.strCategory =  nearByItems[indexPath.row].categoryName!
            self.navigationController?.pushViewController(next, animated: true)
            
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
