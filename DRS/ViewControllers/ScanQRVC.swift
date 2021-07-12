//
//  ScanQRVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import AVFoundation
class ScanQRVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession:AVCaptureSession?
     var videoPreviewLayer:AVCaptureVideoPreviewLayer?
     var qrCodeFrameView:UIView?
    let supportedCodeTypes = [AVMetadataObject.ObjectType.qr]
    var resultString = ""
    override func viewWillAppear(_ animated: Bool) {
           print("viewWillAppear ScanCodeVC 111111")
           
           
           self.title = "Scan Code"
           self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        
        
        self.addBackButton()
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
             videoPreviewLayer?.frame = view.layer.bounds
             view.layer.addSublayer(videoPreviewLayer!)
             
             captureSession?.startRunning()
             
             qrCodeFrameView = UIView()
             
             if let qrCodeFrameView = qrCodeFrameView {
                 qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                 qrCodeFrameView.layer.borderWidth = 2
                 self.view.addSubview(qrCodeFrameView)
                 self.view.bringSubviewToFront(qrCodeFrameView)
             }
             
             captureSession?.startRunning()
             
         } catch {
             // If any error occurs, simply print it out and don't continue any more.
             print(error)
             return
         }
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
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                self.view.addSubview(qrCodeFrameView)
                self.view.bringSubviewToFront(qrCodeFrameView)
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
                  // found(code: stringValue)
               }

               dismiss(animated: true)
           
        
        /*
        
           if metadataObjects.count == 0 {
               qrCodeFrameView?.frame = CGRect.zero
               //messageLabel.text = "No QR/barcode is detected"
               print("No QR/barcode is detected")
               return
           }

           let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

           if supportedCodeTypes.contains(metadataObj.type) {

               let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
               qrCodeFrameView?.frame = barCodeObject!.bounds

               if metadataObj.stringValue != nil {


                   print(metadataObj.stringValue!)
                
                   
               }
           }
        */
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
