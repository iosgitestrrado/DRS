//
//  CustomerSupportVC.swift
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

class CustomerSupportVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating ,UISearchBarDelegate{
     private let refreshControl = UIRefreshControl()
    @IBOutlet var searchSupport: UISearchBar!
    @IBOutlet var viewSoarch: UIView!
    @IBOutlet weak var tableCustSupport: UITableView!
    
    var strTitle: String! = String()
    var strSearch: String! = ""
    var strOffset: String! = ""
    
    var chatListModel: ChatListModel?
    var chatDeleteModel: ChatDeleteModel?
    
    var chatListArray = [ChatList]()
    
    func changeLanguage()
    {
        
          let sharedDefault = SharedDefault()
        
          if sharedDefault.getLanguage() == 1
          {
              print("changeLanguage")
             
              let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
              do {
                  var text = try String(contentsOfFile: path!)
                  
                  let xml = try! XML.parse(text)
                  
                  if let text = xml.resource.Setting_Cust_Support.text {
                      strTitle = text
                      self.title = strTitle
                      print("strTitle",text)
                  }
                  
               
               if let text = xml.resource.Customer_Support_Im_looking_for.text {
                   print("btnNext",text)
                   UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                   
                   let textFieldInsideSearchBar = searchSupport.value(forKey: "searchField") as? UITextField
                   let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                   textFieldInsideSearchBar?.font = fonts
                   textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                   textFieldInsideSearchBar?.borderStyle = .none
                   textFieldInsideSearchBar?.textColor = UIColor.white
                   
                   let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                   clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                   clearButton.tintColor = UIColor.white
                
//                let text = xml.resource.Title_Cancel.text
//                (searchSupport.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                
              
                   
               }
             
                  
              }
              catch(_){print("error")}
          } else if sharedDefault.getLanguage() == 0 {
           var strHead:String = ""
           
              let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
              do {
                  var text = try String(contentsOfFile: path!)
                  //print("text",text)
                  let xml = try! XML.parse(text)
               if let text = xml.resource.Setting_Cust_Support.text {
                   strTitle = text
                  self.title = strTitle
                  
                  //print("text",text)
               }
               if let text = xml.resource.Customer_Support_Im_looking_for.text {
                   print("btnNext",text)
                   UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                   
                   let textFieldInsideSearchBar = searchSupport.value(forKey: "searchField") as? UITextField
                   let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                   textFieldInsideSearchBar?.font = fonts
                   textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                   textFieldInsideSearchBar?.borderStyle = .none
                   textFieldInsideSearchBar?.textColor = UIColor.white
                   
                   let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                   clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                   clearButton.tintColor = UIColor.white
                
              
                   
               }
              
                 
              }
              catch(_){print("error")}
              
              
          }
        
        if sharedDefault.getLanguage() == 1
        {
            (searchSupport.value(forKey: "cancelButton") as! UIButton).setTitle("ပယ်ဖျက်မည်", for: .normal)

        }
        else
        {
            (searchSupport.value(forKey: "cancelButton") as! UIButton).setTitle("Cancel", for: .normal)

        }
          
      }
    func updateSearchResults(for searchController: UISearchController)
       {
        print("searching")
       
//           let searchString = searchController.searchBar.text
//
//           filtered = items.filter({ (item) -> Bool in
//               let countryText: NSString = item as NSString
//
//               return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
//           })
//
//           collectionView.reloadData()
       }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
    print("Search bar",searchBar.text!)
        strSearch = searchBar.text!
    searchSupport.resignFirstResponder()
        strOffset = ""
        self.getCustomerSupportList()
    /*
    var searchString:String = searchBar.text!
    for item  in categoryItems {
    /* if item.categoryName == searchString
     {
     filterCategoryItems.append(item)
     }*/
    var str = String()
    str = item.categoryName!
    if str.contains(searchString) {
    filterCategoryItems.append(item)
    }
    }
    if filterCategoryItems.count>0 {
    categoryItems.removeAll()
    categoryItems = filterCategoryItems
    }
    
    //categoryItems
    
    
    collectionCategory.reloadData()
    
    */
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
{
    searchSupport.text = ""
    print("Search ")
     strSearch = ""
    searchSupport.resignFirstResponder()
    self.getCustomerSupportList()
    /*if tempCategoryItems.count>0 {
    categoryItems.removeAll()
    categoryItems = tempCategoryItems
    collectionCategory.reloadData()
    }
    */
    }
    @objc func btnDeleteAction(sender : Int) {
    print("btnDeleteAction",sender);
    
    
    }
    func deleteChatList()
    {
    
        
    }
    @objc func deletepressed(sender: UIButton!)
    {
    print("tableNotification ",sender.tag)
    
    print(" self.chatListModel[sender.tag] ",String(self.chatListArray[sender.tag].chatId!))
    self.deleteChatMsg(chatID: String(self.chatListArray[sender.tag].chatId!))
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    if tableView == tableCustSupport {
    let cellBal = tableCustSupport.dequeueReusableCell(withIdentifier: "CustomerSupportCell", for: indexPath) as! CustomerSupportCell
    cellBal.layer.cornerRadius = 15
    cellBal.clipsToBounds = true
    cellBal.selectionStyle = .none
    cellBal.lblHeader.text! = chatListArray[indexPath.section].name!
        if chatListArray[indexPath.section].msgType?.description == "image" {
             cellBal.lblMsg.text! = "Image"
        } else {
             cellBal.lblMsg.text! = chatListArray[indexPath.section].chatMsg!
        }
    //cellBal.lblMsg.text! = chatListArray[indexPath.section].chatMsg!
    cellBal.lblDate.text! = chatListArray[indexPath.section].date!
    cellBal.btnDelete.tag = indexPath.section
    
    cellBal.btnDelete.addTarget(self, action: #selector(deletepressed(sender:)), for: .touchUpInside)
    
    //cellBal.btnDelete.addTarget(self, action: #selector(self.btnDeleteAction(sender:indexPath.row)), for: .touchUpInside)
    //cellBal.btnDelete.addTarget(self, action:#selector(btnDeleteAction(sender: indexPath.section)), for: .touchUpInside)
    
    cell = cellBal
    }
    
    return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    print("tableNotification ",indexPath.row)
    print("tableNotification section ",indexPath.section)
    
    let next = self.storyboard?.instantiateViewController(withIdentifier: "MsgDetailListVC") as! MsgDetailListVC
    next.chatIDData = String(self.chatListArray[indexPath.section].chatId!)
    self.navigationController?.pushViewController(next, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
    return  chatListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
    }
    
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 44
     }
     
     */
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.clear
    return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        //Bottom Refresh

        if scrollView == tableCustSupport {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if searchSupport.text == ""
                {
                print("bottomRefresh ----------------------------------> ",strOffset as Any)
                self.getCustomerSupportList()
                print("ofsetValue ----------------------------------> ",strOffset as Any)

                }
            }
        }
    }
    
    
    
    @objc func btnNewMsgAction() {
    // Function body goes here
    print("addTapped")
    let next = self.storyboard?.instantiateViewController(withIdentifier: "NewMsgVC") as! NewMsgVC
    self.navigationController?.pushViewController(next, animated: true)
    //self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    self.title = strTitle
    self.addBackButton()
    
    let button = UIButton(type: UIButton.ButtonType.custom)
    button.setImage(UIImage(named: "Add"), for: .normal)
    button.addTarget(self, action:#selector(btnNewMsgAction), for: .touchUpInside)
    button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
    let barButton = UIBarButtonItem(customView: button)
    self.navigationItem.rightBarButtonItems = [barButton]
        self.strSearch = ""
        self.strOffset = ""
        self.chatListArray .removeAll()
    self.getCustomerSupportList()
     
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableCustSupport.delegate = self
        tableCustSupport.dataSource = self
        
        
        
        searchSupport.barTintColor = UIColor.clear
        searchSupport.backgroundColor = UIColor.red
        searchSupport.isTranslucent = true
        
        searchSupport.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        /*
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: " I'm looking for date", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        
        let textFieldInsideSearchBar = searchSupport.value(forKey: "searchField") as? UITextField
        let fonts = UIFont .boldSystemFont(ofSize: 16.0)
        textFieldInsideSearchBar?.font = fonts
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.borderStyle = .none
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        */
        
        if let textField = searchSupport.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        
      
        
        
        /*
         let myView = UIView(frame: CGRect(x: 0, y: (textFieldInsideSearchBar?.frame.size.height)!-1, width: (textFieldInsideSearchBar?.frame.size.width)!, height: 2))
         myView.backgroundColor = UIColor.white
         textFieldInsideSearchBar!.addSubview(myView)*/
         /*
        let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
           */
        
        
        //searchSupport.searchResultsUpdater = self
        searchSupport.delegate = self
        searchSupport.showsCancelButton = true
        
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableCustSupport.refreshControl = refreshControl
        } else {
            tableCustSupport.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
        
        self.changeLanguage()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        //fetchWeatherData()
        if searchSupport.text == ""
        {
        print("Fetch Weather Data")
        refreshControl.endRefreshing()
        self.getCustomerSupportList()
        //print("Fetch Weather Data ----- ",self.sectionDetail[sectionDetail.count-1].date!)
        //self.getWalletHistory(date: self.sectionDetail[sectionDetail.count-1].date!,searchData: "")
        }
    }
    
    func deleteChatMsg(chatID:String)
    {
    let sharedData = SharedDefault()
    self.view.activityStartAnimating()
    var postDict = Dictionary<String,String>()
    //120585943
    //"access_token":sharedData.getAccessToken() as String
    postDict = ["access_token":sharedData.getAccessToken() as String,
    "chat_id":chatID
    
    ]
    
    print("PostData: ",postDict)
    let loginURL = Constants.baseChatURL+Constants.DeleteURL
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
    self.chatDeleteModel = ChatDeleteModel(response)
    print("self.chatListModel ",self.chatListModel!)
    //print("self.chatListModel ",self.chatListModel?.httpcode!)
    
    //self.chatListArray = self.chatListModel?.chatListModelData?.chatList! as! [ChatList]
    
    print("chatListArray ----- ",self.chatListArray.count)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0)
    {
        let sharedDefault = SharedDefault()

        if sharedDefault.getLanguage() == 1
        {
            self.showToast(message: "ပံ့ပိုးမှုအောင်မြင်စွာဖျက်ပြီးပါပြီ")
        }
        else if sharedDefault.getLanguage() == 0
        {
            self.showToast(message: (self.chatDeleteModel?.message!)!)
        }
    self.chatListArray.removeAll()
    self.strSearch = ""
    self.strOffset = ""
    self.getCustomerSupportList()
    
    // self.tableCustSupport.reloadData()
    
    }
    
    /*
     
     if statusCode == 400{
     
     self.view.activityStopAnimating()
     self.showAlert(title: Constants.APP_NAME, message: (self.chatListModel?.message)!)
     }
     */
    
    self.view.activityStopAnimating()
    
    }
    catch let err {
    print("Error::",err.localizedDescription)
    }
    }
    }
    }
    
    func getCustomerSupportList()
    {
        searchSupport.text = ""
    let sharedData = SharedDefault()
    self.view.activityStartAnimating()
    var postDict = Dictionary<String,String>()
    //120585943
    //"access_token":sharedData.getAccessToken() as String
    postDict = ["access_token":sharedData.getAccessToken() as String,
    "offset":strOffset,
    "search_key":strSearch
    
    ]
    
    print("PostData: ",postDict)
    let loginURL = Constants.baseChatURL+Constants.SupportMessageListURL
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
            self.chatListModel = ChatListModel(response)
            print("self.chatListModel ",self.chatListModel!.chatListModelData?.offset)
            if (self.chatListModel?.chatListModelData?.chatList!.count)!>0 && self.searchSupport.text!.count > 0
            {
//                let offSet = (self.chatListModel!.chatListModelData?.offset)!
//                
//                self.strOffset = String(offSet)
//            
//               
//                self.chatListArray = self.chatListModel?.chatListModelData?.chatList! as! [ChatList]
                
                if (self.chatListModel?.chatListModelData?.chatList!.count)!>0 && self.searchSupport.text!.count > 0
                {
                    let offSet = (self.chatListModel!.chatListModelData?.offset)!
                    
                    self.strOffset = String(offSet)
                    
                    if (self.chatListModel?.chatListModelData?.chatList!.count)!>0
                    {
                        self.chatListArray .append(contentsOf: (self.chatListModel?.chatListModelData?.chatList)!)
                    }
                    else
                    {
                        self.chatListArray = self.chatListModel?.chatListModelData?.chatList! as! [ChatList]
                    }
                    
                
                   
                    
                }
                
            }
            else if (self.chatListModel?.chatListModelData?.chatList!.count)!>0 && self.searchSupport.text!.count == 0
            {
                   let offSet = (self.chatListModel!.chatListModelData?.offset)!
                    
                    self.strOffset = String(offSet)
                
//                 self.chatListArray .append(contentsOf: (self.chatListModel?.chatListModelData?.chatList)!)
                
//                if (self.chatListModel?.chatListModelData?.chatList!.count)!>0
//                {
//                    self.chatListArray .append(contentsOf: (self.chatListModel?.chatListModelData?.chatList)!)
//                }
//                else
//                {
                    self.chatListArray = self.chatListModel?.chatListModelData?.chatList! as! [ChatList]
//                }
            }
            else
            {
//                self.chatListArray.removeAll()
                self.searchSupport.text = ""
                self.view.activityStopAnimating()
                
                var strPwdMsg = ""
               

                let sharedDefault = SharedDefault()
                
                if sharedDefault.getLanguage() == 0
                {
                    strPwdMsg = "No records found"

                  

                }
                else if sharedDefault.getLanguage() == 1
                {
                    strPwdMsg = "မှတ်တမ်းမရှိပါ"
                    

                    
                }
                self.showToast(message: strPwdMsg)
                self.tableCustSupport.reloadData()

                return
            }
            
            print("chatListArray ----- ",self.chatListArray.count)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                
                
                self.tableCustSupport.reloadData()
                
//            }
            
            /*
             
             if statusCode == 400{
             
             self.view.activityStopAnimating()
             self.showAlert(title: Constants.APP_NAME, message: (self.chatListModel?.message)!)
             }
             */
            self.strSearch = ""
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
