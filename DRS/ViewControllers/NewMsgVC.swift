//
//  NewMsgVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import PhotosUI
import Photos
import SwiftyXMLParser

class NewMsgVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let sharedDefault = SharedDefault()
       var keyboardStatus: Bool = false
    var sectionDetail = [ChatMessages]()
    var createNewMsgModel: CreateNewMsgModel?
    var messageDetailModel: MessageDetailModel?
    var chatDeleteModel: ChatDeleteModel?
    var firstImgData:String = String()
     var strTitle:String = String()
    
    var imagePicker = UIImagePickerController()
    //MARK: - Outlets
    var chatIDStats: Bool = false
    var strChatID: String = String()
    
    @IBOutlet weak var tableMessage: UITableView!
    @IBOutlet weak var lblMessageId: UILabel!
    @IBOutlet weak var txtMessageInput: UITextField!
    @IBOutlet weak var lblFileName: UILabel!
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnChooseFile: UIButton!
    
    
    //MARK: - Variables
    // var discussionArray = [["message":"Hi John","isMe":"0","date":"12 May,2018","sender":"Michal Alleps"],["message":"Hi Michal","isMe":"1","date":"12 May,2018","sender":"John"],["message":"How are you John? Wat are you doing nowadays ? Lets meet somewhare if you are free.","isMe":"0","date":"12 May,2018","sender":"Michal Alleps"],["message":"I am fine. I am free nowadays. Let's meet at our old cafe.","isMe":"2","date":"12 May,2018","sender":"John"],["message":"Thanks john. Let's meet at 5 O'clock today in evening.","isMe":"0","date":"12 May,2018","sender":"Michal Alleps"],["message":"Sure, Michal. will be there at 5.","isMe":"1","date":"12 May,2018","sender":"John","image":"http://estrradodemo.com/drs/uat/storage/app/public/no-avatar.png"]]
    
    var discussionArray =  [[String:String]]()
    //[String:String]()
    
    func changeLanguage() {
           let sharedDefault = SharedDefault()
           if sharedDefault.getLanguage() == 1 {
               print("changeLanguage")
               
               let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                  // print("text",text)
                   let xml = try! XML.parse(text)
                   
                  if let text = xml.resource.New_Message.text {
                      strTitle = text
                     self.title = strTitle
                  }
                   
                   if let text = xml.resource.New_Message_No_ﬁle_chosen.text {
                    // btnSignOut.setTitle(text, for: .normal)
                       lblFileName.text = text
                   }
                   if let text = xml.resource.New_Message_Send.text {
                     btnSend.setTitle(text, for: .normal)
                       
                   }
                   if let text = xml.resource.New_Message_Please_type_a_message.text {
                       txtMessageInput.placeholder = text
                       
                   }
                   if let text = xml.resource.New_Message_To_Support_Centre.text {
                       lblMessageId.text = text
                       
                   }
                   if let text = xml.resource.New_Message_Choose_File.text {
                     btnChooseFile.setTitle(text, for: .normal)
                       
                   }
                   
               }
               catch(_){print("error")}
           } else if sharedDefault.getLanguage() == 0 {
               var strHead:String = ""
               
               let path = Bundle.main.path(forResource: "mer_english", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                  // print("text",text)
                   let xml = try! XML.parse(text)
                   if let text = xml.resource.New_Message.text {
                       strTitle = text
                    self.title = strTitle
                   }
                  
                   if let text = xml.resource.New_Message_No_ﬁle_chosen.text {
                    // btnSignOut.setTitle(text, for: .normal)
                       lblFileName.text = text
                   }
                   if let text = xml.resource.New_Message_Send.text {
                     btnSend.setTitle(text, for: .normal)
                       
                   }
                   if let text = xml.resource.New_Message_Please_type_a_message.text {
                       txtMessageInput.placeholder = text
                       
                   }
                   if let text = xml.resource.New_Message_To_Support_Centre.text {
                       lblMessageId.text = text
                       
                   }
                   if let text = xml.resource.New_Message_Choose_File.text {
                     btnChooseFile.setTitle(text, for: .normal)
                       
                   }
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }
    //MARK: - Button Actions
    @IBAction func btnSendAction(_ sender: UIButton) {
        
        print("Message Sent")
        /*
         var dictionaryChat:[String:String] = [String:String]()
         
         dictionaryChat["isMe"] = "1"
         dictionaryChat["message"] = self.txtMessageInput.text
         dictionaryChat["image"] = ""
         
         self.discussionArray.append(dictionaryChat)
         
         print("asdadadadas",discussionArray.count)
         
         self.tableMessage.reloadData()
         
         */
        
        if txtMessageInput.text!.count>0 ||  firstImgData.count>0
        {
            txtMessageInput.resignFirstResponder()
            if self.keyboardStatus == true
            {
                self.keyboardStatus = false
                self.animateViewMoving(up: false, moveValue: 225.0)
            }
            txtMessageInput.resignFirstResponder()
            self.createNewChat()
        }
        else
        {
            if sharedDefault.getLanguage() == 0 {
                self.showToast(message: "Enter message")
            } else if sharedDefault.getLanguage() == 1 {
                self.showToast(message: "မက်ဆေ့ခ်ျကိုရိုက်ထည့်ပါ")
            }
            
            return
        }
        
        
        
    }
    @IBAction func btnChooseFileAction(_ sender: UIButton)
    {
        DispatchQueue.main.async
        {
            self.showAlert()

        }
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Info ------->",info as Any)
        if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL
        {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
            print("hjhjhjjhjjhjhjhj", asset?.value(forKey: "filename") as Any)

            
            self.lblFileName.text = asset?.value(forKey: "filename") as? String

            
        } else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if self.sharedDefault.getLanguage() == 1
                {
                    self.lblFileName.text = "ဖိုင်မရွေးချယ်ရသေးပါ"
                }
                else if self.sharedDefault.getLanguage() == 0
                {
                    self.lblFileName.text = "Image Selected"
                }
                
                print("312312312321312321")
            }
        }
        let pImage = info[UIImagePickerController.InfoKey.originalImage]
        let timage:UIImage = (pImage as? UIImage)!
        firstImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
        
 
        dismiss(animated: true, completion: nil)
        
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    //Animate textfield move up/down
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    func getMessageDetails(chatID:String)
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
        let loginURL = Constants.baseChatURL+Constants.MessageDetailURL
        print("getMessageDetailsURL",loginURL)
        
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
                    self.messageDetailModel = MessageDetailModel(response)
                    print("self.messageDetailModel ",self.messageDetailModel!)
                    // self.sectionDetail = self.messageDetailModel?.messageDetailModelData?.chatMessages as! [ChatMessagesValue]
                    self.sectionDetail = (self.messageDetailModel?.messageDetailModelData?.chatMessages)!
                    //self.sectionDetail =
                    let cid = (self.messageDetailModel?.messageDetailModelData?.chatId)!
                    self.strChatID = String(cid)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        
                        //self.lblMessageId.text = (self.messageDetailModel?.messageDetailModelData?.chatData?.name)!
                        
                        self.tableMessage.reloadData()
                        
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
    
    func createNewChat() {
        let sharedDefault = SharedDefault()
        self.view.activityStartAnimating()
        var loginURL = String()
        
        var postDict = Dictionary<String,String>()
        if chatIDStats == true
        {
            loginURL = Constants.baseChatURL+Constants.SendChatURL

            postDict = ["access_token":sharedDefault.getAccessToken(),
                        "chat_id":self.strChatID,
                        "chat_msg":txtMessageInput.text!,
                        "file":firstImgData
            ]
        } else if chatIDStats == false
        {
            postDict = ["access_token":sharedDefault.getAccessToken(),
                        "chat_msg":txtMessageInput.text!,
                        "file":firstImgData,
                        "chat_id":"",
            ]
            loginURL = Constants.baseChatURL+Constants.CreateNewChatURL
        }
        
        
        print("chatIDStats --- ",chatIDStats)
        print("PostData: ",postDict)
        
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
                    if self.chatIDStats == false
                    {
                        self.createNewMsgModel = CreateNewMsgModel(response)
                        print("self.createNewMsgModel ",self.createNewMsgModel!)
                        print("self.createNewMsgModel ",self.createNewMsgModel?.httpcode!)
                        let statusCode = Int((self.createNewMsgModel?.httpcode)!)
                        if statusCode == 200{
                            self.txtMessageInput.text = ""
                            
                            self.firstImgData = ""
                            let chatId = "\(String(describing: (self.createNewMsgModel?.createNewMsgModelData?.chatId)!))"
                            self.strChatID = String(chatId)
                            //self.createNewMsgModel?.createNewMsgModelData?.chatId
                            
                            if self.strChatID.count>0 {
                                self.chatIDStats =  true
                                let sharedDefault = SharedDefault()
                                
                                if sharedDefault.getLanguage() == 0
                                {
                                    self.lblFileName.text = "No file choosen"

                                }
                                else if sharedDefault.getLanguage() == 1
                                {
                                    self.lblFileName.text = "ဖိုင်မရွေးရ"
                                    
                                }
                                
                                self.getMessageDetails(chatID:self.strChatID)
                            } else {
                                self.chatIDStats =  false
                                let sharedDefault = SharedDefault()
                                
                                if sharedDefault.getLanguage() == 0
                                {
                                    self.lblFileName.text = "No file choosen"

                                }
                                else if sharedDefault.getLanguage() == 1
                                {
                                    self.lblFileName.text = "ဖိုင်မရွေးရ"
                                    
                                }
                                
                            }
                            
                           
                            
                        }
                        if statusCode == 400
                        {
                            
                            
                            if let range3 = (self.createNewMsgModel?.message)!.range(of: "The chat msg field is required.", options: .caseInsensitive)
                            {
                                self.showAlert(title: Constants.APP_NAME, message: (self.createNewMsgModel?.message)!)
                                
                                
                            }
                            else
                            {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    let sharedDefault = SharedDefault()
                                    sharedDefault .clearAccessToken()
                                    sharedDefault .setLoginStatus(loginStatus: false)
                                    let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                    let customViewControllersArray : NSArray = [newViewController]
                                    self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                            }
                            
                            
                            
                            
                        }
                        else
                        {
                                //self.showAlert(title: Constants.APP_NAME, message: (self.createNewMsgModel?.message)!)
                            if statusCode == 400
                            {
                                
                                
                                if let range3 = (self.createNewMsgModel?.message)!.range(of: "The chat msg field is required.", options: .caseInsensitive)
                                {
                                    let sharedDefault = SharedDefault()
                                    
                                    if sharedDefault.getLanguage() == 0
                                    {
                                        self.showAlert(title: Constants.APP_NAME, message: (self.createNewMsgModel?.message)!)

                                    }
                                    else if sharedDefault.getLanguage() == 1
                                    {
                                        self.showAlert(title: Constants.APP_NAME_BUR, message: "မက်ဆေ့ခ်ျအကွက်လိုအပ်သည်")

                                    }                                }
                            }
                            
                        }
                            
                        
                    }
                    else {
                        self.chatDeleteModel = ChatDeleteModel(response)
                        print("self.chatDeleteModel ",self.chatDeleteModel!)
                        print("self.chatDeleteModel ",self.chatDeleteModel?.httpcode!)
                        let statusCode = Int((self.chatDeleteModel?.httpcode)!)
                        if statusCode == 200{

                             self.getMessageDetails(chatID:self.strChatID)
                            self.txtMessageInput.text = ""
                            self.firstImgData = ""
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
    
    //Show alert to selected the media source type.
//    func showAlert() {
//
//        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
//
//            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
//                // Already Authorized
//                self.getImage(fromSourceType: .camera)
//            } else {
//                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
//                   if granted == true {
//                       // User granted
//                    self.getImage(fromSourceType: .camera)
//                   } else {
//                       // User rejected
//                   }
//               })
//            }
//        }))
//        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
//
//            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized
//                   {
//                      self.getImage(fromSourceType: .photoLibrary)
//                   }
//                   else
//                   {
//                      PHPhotoLibrary.requestAuthorization { (status) in
//                          // cruch here
//                        self.getImage(fromSourceType: .photoLibrary)
//                      }
//                   }
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
    
    
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        DispatchQueue.main.async
                {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    //MARK: - ViewController Delegate Methods
    override func viewWillAppear(_ animated: Bool) {
        self.title = strTitle
        self.addBackButton()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableMessage.delegate = self
        tableMessage.dataSource = self
        tableMessage.tableFooterView = UIView()
        
        txtMessageInput.delegate = self
        txtMessageInput.autocorrectionType = .no
        btnChooseFile.layer.cornerRadius = 5
        btnChooseFile.layer.borderWidth = 1
        btnChooseFile.layer.borderColor = Constants.textColor.cgColor
        
        btnSend.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        self.changeLanguage()
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableMessage.contentInset = UIEdgeInsets(top: keyboardHeight - 50, left: 0, bottom: keyboardHeight+115, right: 0)
            self.animateViewMoving(up: true, moveValue: 225)
            self.keyboardStatus = true
        }
        //self.animateViewMoving(up: true, moveValue: 225.0)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableMessage.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            if self.keyboardStatus == true{
                self.animateViewMoving(up: false, moveValue: 225)
            } else {
                self.animateViewMoving(up: false, moveValue: 0)
            }
            
            self.keyboardStatus = false
        })
        //self.animateViewMoving(up: false, moveValue: 225.0)
    }
    
    /*
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        self.animateViewMoving(up: true, moveValue: 225.0)
        
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        self.animateViewMoving(up: false, moveValue: 225.0)
    }
    */
    //MARK: - TableView Delegate Methods
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Tuesday 3:30 PM"
        label.textColor = Constants.textColor
        label.textAlignment = .center
        return label
    }
    /*func numberOfSections(in tableView: UITableView) -> Int {
     //return 10
     print("numberOfSections --- ",discussionArray.count)
     return 1
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
     print("numberOfRowsInSection --- ",discussionArray.count)
     return discussionArray.count
     
     }
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionDetail.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = self.sectionDetail[section].chatMessagesValue?.count
        
        return rowCount!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell = UITableViewCell()
        if tableView == tableMessage {
            let isOwn = sectionDetail[indexPath.section].chatMessagesValue![indexPath.row]
            if isOwn.type == "text" {
                if isOwn.me == 0 {
                    let cell: ReceivedCell = tableMessage.dequeueReusableCell(withIdentifier: "ReceivedCell") as! ReceivedCell
                    cell.lblMessage.text = isOwn.message!//"Received"
                    cell.viewBG.layer.cornerRadius = 8
                    tableCell = cell
                } else {
                    let cell: SentCell = tableMessage.dequeueReusableCell(withIdentifier: "SentCell") as! SentCell
                    cell.lblMessage.text = isOwn.message!//"Sent"
                    cell.viewBG.layer.cornerRadius = 8
                    tableCell = cell
                }
            }
            else {
                if isOwn.me == 0 {
                    let cell: ReceivedImageCell = tableMessage.dequeueReusableCell(withIdentifier: "ReceivedImageCell") as! ReceivedImageCell
                    let urlstr = isOwn.message
                    cell.imgReceived.sd_setImage(with: URL(string: urlstr!), placeholderImage: nil)
                    
                    cell.viewBG.layer.cornerRadius = 8
                    tableCell = cell
                }
                else {
                    let cell: ImageCell = tableMessage.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
                    let urlstr = isOwn.message
                    cell.imageUp.sd_setImage(with: URL(string: urlstr!), placeholderImage: nil)
                    
                    cell.viewBG.layer.cornerRadius = 8
                    tableCell = cell
                }
            }
            /*
             
             if isOwn["image"] != nil && isOwn["image"] != "" {
             let cell: ImageCell = tableMessage.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
             let urlstr = discussionArray[indexPath.section]["image"]!
             let url = URL(string: "http://estrradodemo.com/drs/uat/storage/app/public/no-avatar.png")
             
             cell.imageUp.sd_setImage(with: URL(string: "http://estrradodemo.com/drs/uat/storage/app/public/no-avatar.png"), placeholderImage: nil)
             
             
             //                cell.imageUp!.sd_setImage(with: url, completed: nil)
             //                cell.imageUp.image = UIImage(named: "Car")
             cell.viewBG.layer.cornerRadius = 8
             tableCell = cell
             }
             */
            /*
             let isOwn = discussionArray[indexPath.row]
             if isOwn["isMe"] == "0" {
             let cell: ReceivedCell = tableMessage.dequeueReusableCell(withIdentifier: "ReceivedCell") as! ReceivedCell
             cell.lblMessage.text = discussionArray[indexPath.row]["message"]//"Received"
             cell.viewBG.layer.cornerRadius = 8
             tableCell = cell
             } else {
             let cell: SentCell = tableMessage.dequeueReusableCell(withIdentifier: "SentCell") as! SentCell
             cell.lblMessage.text = discussionArray[indexPath.row]["message"]//"Sent"
             cell.viewBG.layer.cornerRadius = 8
             tableCell = cell
             }
             if isOwn["image"] != nil && isOwn["image"] != "" {
             let cell: ImageCell = tableMessage.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
             let urlstr = discussionArray[indexPath.row]["image"]!
             let url = URL(string: "http://estrradodemo.com/drs/uat/storage/app/public/no-avatar.png")
             
             cell.imageUp.sd_setImage(with: URL(string: "http://estrradodemo.com/drs/uat/storage/app/public/no-avatar.png"), placeholderImage: nil)
             
             
             //                cell.imageUp!.sd_setImage(with: url, completed: nil)
             //                cell.imageUp.image = UIImage(named: "Car")
             cell.viewBG.layer.cornerRadius = 8
             tableCell = cell
             }
             
             */
        }
        tableCell.selectionStyle = .none
        return tableCell
    }
    
    
    
    
    
    //MARK: - TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //function to move view up
        //txtMessageInput
        //self.animateViewMoving(up: true, moveValue: 225.0)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //function to move view down
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.keyboardStatus == true{
            print("true")
            self.animateViewMoving(up: false, moveValue: 225)
            self.keyboardStatus = false
        } else {
            self.animateViewMoving(up: false, moveValue: 225)
        }
        textField.resignFirstResponder()
        return true
    }
    
}
