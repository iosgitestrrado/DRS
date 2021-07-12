//
//  ScanCodeVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class ScanCodeVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var strTitle:String = String()
     var merchantQRModel:MerchantQRModel?
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedCodeTypes = [AVMetadataObject.ObjectType.qr]
    var resultString = ""
    var countV: Int = 0
    @IBOutlet var viewQR: UIView!
    @IBOutlet var viewScanCodeBg: UIView!
    let maskLayer = CAShapeLayer()
    
    @IBOutlet weak var lblHeader: UILabel!
    
    
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.scan_code_scan_code.text {
                    strTitle = text
                 self.title = strTitle
                }
                if let text = xml.resource.scan_code_move_camera_see_QR_code_confirm_payment.text {
                    lblHeader.text = text
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
                
                if let text = xml.resource.scan_code_scan_code.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.scan_code_move_camera_see_QR_code_confirm_payment.text {
                    lblHeader.text = text
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear ScanCodeVC app page")
        
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
       
        maskLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.view.bounds
        //borderLayer.path = maskLayer.CGPath
        maskLayer.path = UIBezierPath(roundedRect: viewQR.bounds, byRoundingCorners: [.topLeft,.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
        borderLayer.mask = maskLayer
        borderLayer.lineWidth = 5.0
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.strokeColor = UIColor.clear.cgColor
        viewQR.layer.addSublayer(borderLayer)
        
        
        self.addBackButton()
        self.StartQrCodeScan()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLanguage()
        // Do any additional setup after loading the view.
        // self.StartQrCodeScan()
        
    }
    
    func StartQrCodeScan(){
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            //videoPreviewLayer?.frame = view.layer.bounds
            videoPreviewLayer?.frame = viewQR.layer.bounds
            
            viewQR.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                //self.view.addSubview(qrCodeFrameView)
                //self.view.bringSubviewToFront(qrCodeFrameView)
                
                //viewQR.addSubview(qrCodeFrameView)
                viewQR.bringSubviewToFront(qrCodeFrameView)
            }
            
            captureSession?.startRunning()
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        captureSession!.stopRunning()
        
         if let metadataObject = metadataObjects.first {
         guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
         guard let stringValue = readableObject.stringValue else { return }
         AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        self.getPaymentDetails(stringQR: stringValue)
         /*
          let next = self.storyboard?.instantiateViewController(withIdentifier: "PayDetailsVC") as! PayDetailsVC

            next.stringQR = stringValue
        
         self.navigationController?.pushViewController(next, animated: true)
 */
         }
         
         dismiss(animated: true)
         
        
       
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "PayCodeVC") as! PayCodeVC
        
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func getPaymentDetails(stringQR:String)
    {
           let sharedData = SharedDefault()
           self.view.activityStartAnimating()
           var postDict = Dictionary<String,String>()
           postDict = ["access_token":sharedData.getAccessToken(),
                       "qr_code":stringQR
           ]
           
           print("PostData: ",postDict)
           let loginURL = Constants.baseURL+Constants.MerchantQRDetailURL
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
                       self.merchantQRModel = MerchantQRModel(response)
                       print("self.merchantQRModel ",self.merchantQRModel!)
                       print("self.merchantQRModel ",self.merchantQRModel?.httpcode!)
                       
                       let statusCode = Int((self.merchantQRModel?.httpcode)!)
                       if statusCode == 200{
                        let textValue:String = (self.merchantQRModel?.merchantQRModelData?.merchantQrdata!.merchantId)!
                        
                        //var mID:Int! = Int(textValue)
                        if textValue.count > 0 {

                             let next = self.storyboard?.instantiateViewController(withIdentifier: "PayDetailsVC") as! PayDetailsVC

                                 next.stringQR = stringQR
                            
                              self.navigationController?.pushViewController(next, animated: true)
                        } else
                        {
                            //QRCode သည်မမှန်ကန်ပါ
                           
                            let sharedDefault = SharedDefault()

                            if sharedDefault.getLanguage() == 0
                            {
                                 self.showToast(message: "Invalid QR Code")
                            }
                            else if sharedDefault.getLanguage() == 1
                            {
                                 self.showToast(message: "မမှန်ကန်သော QR Code")
                            }
                            
                            self.captureSession?.stopRunning()
                            
                            self.StartQrCodeScan()
                            
                            
                        }
                        
                        
                        
                        
                        
                       }
                    if statusCode == 400{
                        
                        
                        if let range3 = (self.merchantQRModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_NAME, message: (self.merchantQRModel?.message)!)
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
    func isValid(_ object:MerchantQrdata!) -> Bool
    {
        if let _:MerchantQrdata = object
        {
            return true
        }

        return false
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
