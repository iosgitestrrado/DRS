//
//  ExtensionClass.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/27/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import CoreLocation

import UIKit
/*
fileprivate var roundCornerRadius: CGFloat = 0.0
fileprivate var cornerRect: UIRectCorner = []
//fileprivate var cornerCustom: [AGCornerTypes] = []
*/
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
extension UIColor {
    static var officialApplePlaceholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
   func resizeImageWith(newSize: CGSize) -> UIImage {

   let horizontalRatio = newSize.width / size.width
   let verticalRatio = newSize.height / size.height

   let ratio = max(horizontalRatio, verticalRatio)
   let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
   UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
   draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
   let newImage = UIGraphicsGetImageFromCurrentImageContext()
   UIGraphicsEndImageContext()
   return newImage!
   }
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedTo1MB() -> UIImage? {
      
        guard let imageData = self.pngData() else { return nil }

        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB

        while imageSizeKB > 1000 { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = resizedImage.pngData()
                else { return nil }

            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }

        return resizingImage
    }


}
extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2426:
            return .iPhone_11Pro
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax_ProMax
        default:
            return .unknown
        }
    }

}
extension UIImageView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func load(url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let data = try? Data(contentsOf: url) {
                   if let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
    
        layer.mask = mask
    }
    func rotateWithAnimation(angle: CGFloat, duration: CGFloat? = nil) {
           let pathAnimation = CABasicAnimation(keyPath: "transform.rotation")
           pathAnimation.duration = CFTimeInterval(duration ?? 150.0)
           pathAnimation.fromValue = 0
           pathAnimation.toValue = angle
         pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
           self.transform = transform.rotated(by: angle)
           self.layer.add(pathAnimation, forKey: "transform.rotation")
       }
         
        func activityStartAnimating(){
                 let backgroundView = UIView()
                 backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
                 //backgroundView.alpha = 0.1
                 backgroundView.backgroundColor = UIColor.clear
                 backgroundView.tag = 475647
                 self.addSubview(backgroundView)
                 
                 let containerView = UIView()
                 containerView.frame = CGRect.init(x: 0, y: 0, width: 175, height: 160)
                 containerView.center = CGPoint(x:backgroundView.bounds.width/2,y:backgroundView.bounds.height/2)
                 containerView.layer.cornerRadius = 10
                 containerView.backgroundColor = UIColor.clear
                
                 backgroundView.addSubview(containerView)
              
               
               var testImage = UIImageView()
                 testImage = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
               testImage.image = UIImage(named: "Spinner")
               testImage.center = CGPoint(x:containerView.bounds.width/2,y:containerView.bounds.height/2)
               containerView.addSubview(testImage)
               testImage.backgroundColor = UIColor.clear
               
               
               containerView.rotateWithAnimation(angle: 360)
               
             
             }
         func activityStopAnimating() {
             if let background = viewWithTag(475647){
                 background.removeFromSuperview()
             }
             self.isUserInteractionEnabled = true
         }
}

extension UITextField {

func underlined() {

         let border = CALayer()
         let width = CGFloat(3.0)
         border.borderColor = UIColor.red.cgColor
         border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: width)
         border.borderWidth = width
         self.layer.addSublayer(border)
         self.layer.masksToBounds = true

    }
}

extension UIViewController {
    
    
    
    func addBackButton() {
        let btnLeftMenu: UIButton = UIButton()
        let image = UIImage(named: "BackNav");
        btnLeftMenu.setImage(image, for: .normal)
        btnLeftMenu.setTitle("", for: .normal);
        btnLeftMenu.sizeToFit()
        btnLeftMenu.addTarget(self, action: #selector (backButtonClick(sender:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
    }

    @objc func backButtonClick(sender : UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
     // Convert UIImage to a base64 representation
        //
        func convertImageToBase64(image: UIImage) -> String {
            let imageData = image.pngData()!
    //        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
            return imageData.base64EncodedString()
        }
    func convertImageToBase_64(image: Data) -> String {
               
       //        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
               return image.base64EncodedString()
           }
    
    
    
    // MARK: show Alert
      func showAlert(title : String,message : String) {
        let sharedDefault = SharedDefault()
        var appname = ""
        var oktitle = ""
        
        if sharedDefault.getLanguage() == 0 {
            appname = Constants.APP_NAME
            oktitle = Constants.OK_TITLE_ENG
        } else if sharedDefault.getLanguage() == 1 {
            appname = Constants.APP_NAME_BUR
            oktitle = Constants.OK_TITLE_BUR
        }
        
        
          let alert = UIAlertController(title: appname, message: message, preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: oktitle, style: UIAlertAction.Style.default, handler: { _ in
              //Cancel Action
          }))
          self.present(alert, animated: true, completion: nil)
      }
    //Function to calculate height for label based on text
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        //CGFloat.greatestFiniteMagnitude
        let label:UILabel = UILabel(frame: CGRect(x: 5, y: 0, width: width-10, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height + 20.0
    }
    
    func showToast(message : String) {
        
       // let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 70))
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        //toastLabel.font = font
        toastLabel.center = self.view.center
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        //toastLabel.sizeToFit()
        toastLabel.numberOfLines = 0
        toastLabel.frame = CGRect(x: 5, y: self.view.frame.size.height/2, width: self.view.frame.size.width-10, height:self.heightForView(text: message, font: toastLabel.font, width: self.view.frame.size.width-10))
        self.view.addSubview(toastLabel)
        
        //UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 70))
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
/*
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 70))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        //toastLabel.font = font
        toastLabel.center = self.view.center
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        //toastLabel.sizeToFit()
        toastLabel.numberOfLines = 0
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    */
}


