//
//  ShopReviewVC.swift
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

class ShopReviewVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextViewDelegate{
    var selectedIndexPathCollection : IndexPath? //declare this
    var selectedTableIndexPath : IndexPath? //declare this
     var validateMobileModelResponse: ValidateMobileModel?
    var strTitle:String = String()
    var priceRange = String()
    var rating = String()
    
    var priceStatus:Bool = false
    var ratingStatus:Bool = false
    
    var placeHolder = String()
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblLove: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    //priceRangeList
    var priceList:[PriceRangeList] = []
    var merchantReviewPageLoadModel:MerchantReviewPageLoadModel?
    var strMerchantID:String = String ()
    @IBOutlet var scrollShopReview: UIScrollView!
    @IBOutlet weak var txtViewComments: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var viewComments: UIView!
    @IBOutlet weak var viewPrice: UIView!
    
    let reuseIdentifier = "CollectionRatingCell"
    @IBOutlet weak var collectionRating: UICollectionView!
    @IBOutlet weak var tablePrice: UITableView!
    let reuseIdentifierPrice = "PriceTableCell"
    var items = ["Top Up Wallet", "Buy Voucher Point", "Share","Top Up Wallet", "Buy Voucher Point", "Share"]
    /**
     <>Review</Review_title>
     <>Price</Review_price>
     <Review_under>Under</Review_under>
     <Review_over>Over</Review_over>
     <>Love Rating</Review_love_rating>
     <>Comments</Review_comments>
     <>Type here...</Review_type_here>
     
     */
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        placeHolder = ""
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Review_title.text {
                 strTitle = text
                 self.title = strTitle
                }
                if let text = xml.resource.Review_price.text {
                    lblPrice.text = text
                  
                }
                if let text = xml.resource.Review_love_rating.text {
                 lblLove.text = text
                }
                if let text = xml.resource.Review_comments.text {
                    lblComments.text = text
                }
                if let text = xml.resource.Review_type_here.text {
                    placeHolder = text
                    txtViewComments.text = placeHolder
                }
                if let text = xml.resource.Top_Up_Wallet_submit.text
                {

                    btnSubmit.setTitle(text, for: .normal)
                    btnSubmit.titleLabel?.text = text


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
                
               if let text = xml.resource.Review_title.text {
                strTitle = text
                self.title = strTitle
               }
               if let text = xml.resource.Review_price.text {
                   lblPrice.text = text
                 
               }
               if let text = xml.resource.Review_love_rating.text {
                lblLove.text = text
               }
               if let text = xml.resource.Review_comments.text {
                   lblComments.text = text
               }
               if let text = xml.resource.Review_type_here.text {
                   placeHolder = text
                txtViewComments.text = placeHolder
               }
                if let text = xml.resource.Top_Up_Wallet_submit.text
                {

                    btnSubmit.setTitle(text, for: .normal)
                    btnSubmit.titleLabel?.text = text


                }
            }
            catch(_){print("error")}
            
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var countVariable : Int = 0
        if collectionView == collectionRating {
            countVariable = 5
            
        }
        
        return countVariable
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionRating {
            let cellCategory = collectionRating.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionRatingCell
            cellCategory.viewBG.layer.cornerRadius = 10
            cellCategory.viewBG.layer.borderWidth = 1
            cellCategory.viewBG.layer.borderColor = Constants.textColor.cgColor
            cellCategory.lblRating.text = String(indexPath.row + 1)
            cellCategory.clipsToBounds = true
          
            
            if ratingStatus == true{
                
                if indexPath.row+1 == (self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.rating)!{
                    cellCategory.imgLike.image = UIImage(named: "likes")//dislike
                    ratingStatus = false
                    
                    print("collectionView ---  ",indexPath.row+1)
                    print("collectionView rating ---  ",(self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.rating)!)
                    
                } else {
                     cellCategory.imgLike.image = UIImage(named: "dislike")//dislike
                }
            }
            
        
            cell = cellCategory
            
        }
        
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 60, height: 60)
    }
    
    //choosing an animal
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionRating.cellForItem(at: indexPath) as! CollectionRatingCell
        currentCell.imgLike.image = UIImage(named: "likes")
        // let animal = currentCell.imgLike.restorationIdentifier! //gets what type of animal selected
        //selectionLabel.text = "\(animal) selected" //changes label
        
        rating = String (indexPath.row + 1)
        selectedIndexPathCollection = indexPath
        priceStatus = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let currentCell = collectionRating.cellForItem(at: indexPath) as! CollectionRatingCell
        if selectedIndexPathCollection == indexPath {
            currentCell.imgLike.image = UIImage(named: "dislike")
        }
        //collectionRating.reloadData()
        selectedIndexPathCollection = nil
    }
    
    /* func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     let currentCell = collectionRating.cellForItem(at: indexPath) as! CollectionRatingCell
     selectedIndexPath = nil
     currentCell.imgLike.image = UIImage(named: "dislike")
     collectionRating.re
     
     }*/
    /*
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     if let cell = tablePrice.cellForRow(at: indexPath) {
     //cell.accessoryType = .none
     }
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     if let cell = tablePrice.cellForRow(at: indexPath) {
     //cell.accessoryType = .checkmark
     
     
     }
     }
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tablePrice {
            let cellBal = tablePrice.dequeueReusableCell(withIdentifier: "PriceTableCell", for: indexPath) as! PriceTableCell
            cellBal.backgroundColor = UIColor.white
            /*cellBal.layer.cornerRadius = 15
             cellBal.clipsToBounds = true*/
            cellBal.selectionStyle = .none
            //cellBal.btnCheck.addTarget(self, action: #selector(self.checkAction(_:)), for: .touchUpInside)
            cellBal.lblAmount.text = priceList[indexPath.row].title
            //(self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.priceRangeList)!
            //self.view.bringSubviewToFront(label);
            cellBal.bringSubviewToFront(cellBal.lblAmount)
            let rowNumber : Int = indexPath.row
           
            print("[indexPath.row]  ",priceList[indexPath.row].id! )
            print("[indexPath.row] 11  ",(self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.priceRangeId)!  )
            if priceList[indexPath.row].id! == (self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.priceRangeId)!   {
                if priceStatus == true {
                   cellBal.imgCheck.image = UIImage(named: "checked")// checked
                } else
                 {
                   cellBal.imgCheck.image = UIImage(named: "check")// checked
                }
            } else {
                 cellBal.imgCheck.image = UIImage(named: "check")// checked
            }
            
            
            /*if priceRange.count<=0 {
                if indexPath.row - 1 == self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.priceRangeId! {
                    cellBal.imgCheck.image = UIImage(named: "checked")
                    //currentCell.imgCheck.image = UIImage(named: "check")
                    print("9999")
                }
            }
            */
            //
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableNotification ",indexPath.row)
        print("tableNotification section ",indexPath.section)
        //let cellBal = tablePrice.dequeueReusableCell(withIdentifier: "PriceTableCell", for: indexPath) as! PriceTableCell
        let currentCell = tablePrice.cellForRow(at: indexPath) as! PriceTableCell
        currentCell.imgCheck.image = UIImage(named: "checked")
        /*
        if selectedTableIndexPath == indexPath {
            currentCell.imgCheck.image = UIImage(named: "check")
        } else {
            currentCell.imgCheck.image = UIImage(named: "checked")
        }
        */
        //cellBal.imgCheck.image = UIImage(named: "checked")
        let textPrice =  "\(priceList[indexPath.row].id!)"
        
        priceRange = String(textPrice)
        
        selectedTableIndexPath = indexPath
        
        priceStatus = false
        
    }
    
  
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let currentCell = tablePrice.cellForRow(at: indexPath) as! PriceTableCell
        if selectedTableIndexPath == indexPath {
            currentCell.imgCheck.image = UIImage(named: "check")
        } else {
            currentCell.imgCheck.image = UIImage(named: "checked")
        }
        //cellBal.imgCheck.image = UIImage(named: "checked")
        selectedTableIndexPath = nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceList.count
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
        // 177 179 182
        //UIColor(red: 177.0/255.0, green: 179.0/255.0, blue: 182.0/255.0, alpha: 1.0)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLanguage()
        // Do any additional setup after loading the view.
        tablePrice.delegate = self
        tablePrice.dataSource = self
        
        collectionRating.delegate = self
        collectionRating.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        //layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        collectionRating!.collectionViewLayout = layout
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        viewPrice.layer.cornerRadius = 15
        viewPrice.clipsToBounds = true
        viewRating.layer.cornerRadius = 15
        viewComments .layer.cornerRadius = 15
        
        txtViewComments.delegate = self
        
        //txtViewComments.text = "Type here..."
        //txtViewComments.textColor = UIColor(red: 177.0/255.0, green: 179.0/255.0, blue: 182.0/255.0, alpha: 0.5)
        
        self.getMerchantReviewDetails()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    @objc func keyboardWillShow(notification:NSNotification){
           //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
           var userInfo = notification.userInfo!
           var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
           keyboardFrame = self.view.convert(keyboardFrame, from: nil)
           
           var contentInset:UIEdgeInsets = self.scrollShopReview.contentInset
           contentInset.bottom = keyboardFrame.size.height
           self.scrollShopReview.contentInset = contentInset
       }
       
       @objc func keyboardWillHide(notification:NSNotification){
           let contentInset:UIEdgeInsets = UIEdgeInsets.zero
           self.scrollShopReview.contentInset = contentInset
       }
    @objc func dismissKeyboard()
    {
         self.txtViewComments.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 177.0/255.0, green: 179.0/255.0, blue: 182.0/255.0, alpha: 1.0) {
            //textView.text = nil
            //textView.textColor = Constants.textColor
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolder
            //textView.text = "Type here..."
            textView.textColor = UIColor(red: 177.0/255.0, green: 179.0/255.0, blue: 182.0/255.0, alpha: 1.0)
        }
    }
    
    func getMerchantReviewDetails() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken() as String,
                    "merchant_id":String(strMerchantID)
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.ReviewDetailURL
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
                    self.merchantReviewPageLoadModel = MerchantReviewPageLoadModel(response)
                    print("self.merchantReviewPageLoadModel ",self.merchantReviewPageLoadModel!)
                    print("self.merchantReviewPageLoadModel ",(self.merchantReviewPageLoadModel?.httpcode)!)
                    
                    let statusCode = Int((self.merchantReviewPageLoadModel?.httpcode)!)
                    if statusCode == 200{
                        
                        //self.merchantList = (self.merchantListModel?.merchantListModelData?.merchantList)!
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            self.priceList = (self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.priceRangeList)!
                           
                           // self.tablePrice.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                            
                            self.txtViewComments.text = (self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.review)!
                            
                            
                            if (self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.rating)!>0
                            {
                                self.ratingStatus = true
                                print("ratingStatus")
                            }
                            if (self.merchantReviewPageLoadModel?.merchantReviewPageLoadModelData?.reviewPage?.reviewData?.priceRangeId)!>0
                            {
                                self.priceStatus = true
                                print("priceStatus")
                            }
                            
                            
                            self.collectionRating.reloadData()
                            
                             self.tablePrice.reloadData()
                           
                            self.view.activityStopAnimating()
                            
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.merchantReviewPageLoadModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.merchantReviewPageLoadModel?.message)!)
                        }
                        
                        
                    }
                    
                    
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func reviewSubmitAction(_ sender: Any)
    {
        let sharedDefault = SharedDefault()
        
       
        if priceRange.count<=0
        {
            if sharedDefault.getLanguage() == 0
            {
                self.showToast(message: "Select price range")

              

            }
            else if sharedDefault.getLanguage() == 1
            {
                self.showToast(message: "စျေးနှုန်းအကွာအဝေးကိုရွေးပါ")

                
            }
            
            
            
        }
        else if rating.count<=0
        {
            if sharedDefault.getLanguage() == 0
            {
                self.showToast(message: "Select rating")

              

            }
            else if sharedDefault.getLanguage() == 1
            {
                self.showToast(message: "အဆင့်သတ်မှတ်ချက်ကိုရွေးချယ်ပါ")

                
            }
            
        } else {
            self.updateReview()
        }
        
    }
    func updateReview() {
          let sharedData = SharedDefault()
          self.view.activityStartAnimating()
          var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                      "merchant_id":strMerchantID,
                      "price_range_id":priceRange,
                      "rating":rating,
            "review":txtViewComments.text
          ]
          
          print("PostData: ",postDict)
          let loginURL = Constants.baseURL+Constants.ReviewUpdateURL
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
                      self.validateMobileModelResponse = ValidateMobileModel(response)
                      print("self.validateMobileModelResponse ",self.validateMobileModelResponse!)
                      print("self.validateMobileModelResponse ",self.validateMobileModelResponse?.httpcode!)
                      
                      
                      let statusCode = Int((self.validateMobileModelResponse?.httpcode)!)
                      if statusCode == 200
                      {
                        
                        
                        if sharedData.getLanguage() == 1
                        {
                            self.showToast(message: "ကုန်သည်ပြန်လည်ဆန်းစစ်ခြင်းအောင်မြင်စွာအဆင့်မြှင့်တင်")

                        }
                        else
                        {
                            self.showToast(message: (self.validateMobileModelResponse?.message!)!)

                        }
                        
                        
                          
                      }
                      if statusCode == 400{
                          
                        self.view.activityStopAnimating()
                        if let range3 = (self.validateMobileModelResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.validateMobileModelResponse?.message)!)
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
