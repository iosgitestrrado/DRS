//
//  SharedDefault.swift
//  iDesigner
//
//  Created by Softnotions Technologies Pvt Ltd on 2/19/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class SharedDefault: UIViewController {
    func setLanguage(language:Int)
    {
        UserDefaults.standard.set(language, forKey: "Language")
        UserDefaults.standard.synchronize()
    }
    
    func getLanguage()-> Int
    {
        return UserDefaults.standard.integer(forKey: "Language")
        
    }
    func setLatitude(latitude:String)
    {
        UserDefaults.standard.set(latitude, forKey: "Latitude")
        UserDefaults.standard.synchronize()
    }
    func setLongitude(longitude:String)
    {
        UserDefaults.standard.set(longitude, forKey: "Longitude")
        UserDefaults.standard.synchronize()
    }
    func getLatitude()-> String
    {
        return UserDefaults.standard.value(forKey: "Latitude")! as! String
        
    }
    func getLongitude()-> String
    {
        return UserDefaults.standard.value(forKey: "Longitude")! as! String
        
    }
    func setLoginStatus(loginStatus:Bool)
    {
        UserDefaults.standard.set(loginStatus, forKey: "LoginStatus")
        UserDefaults.standard.synchronize()
    }
    
    func getLoginStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "LoginStatus")
    }
    
    func setPhoneNumber(loginStatus:String)
    {
        UserDefaults.standard.set(loginStatus, forKey: "PhoneNumber")
        UserDefaults.standard.synchronize()
    }
    func getPhoneNumber()-> String
    {
        return UserDefaults.standard.value(forKey: "PhoneNumber")! as! String
        
    }
    
    func setDialCode(dialCode:String)
    {
        UserDefaults.standard.set(dialCode, forKey: "DialCode")
        UserDefaults.standard.synchronize()
    }
    func getDialCode()-> String
    {
        return UserDefaults.standard.value(forKey: "DialCode")!
            
            as! String}
    
    func setAccessToken(token:String)
    {
        UserDefaults.standard.set(token, forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    func getAccessToken()-> String
    {
        return UserDefaults.standard.value(forKey: "access_token")! as! String
        
    }
    func clearAccessToken()
    {
//        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.setValue("", forKey: "access_token")

    }
    
    
    func setFcmToken(token:String)
       {
           UserDefaults.standard.set(token, forKey: "fcm_token")
           UserDefaults.standard.synchronize()
       }
       func getFcmToken()-> String
       {
           return UserDefaults.standard.value(forKey: "fcm_token")! as! String
           
       }
    func setNewFcmToken(token:String)
    {
        UserDefaults.standard.set(token, forKey: "new_fcm_token")
        UserDefaults.standard.synchronize()
    }
    func getNewFcmToken()-> String
    {
        return UserDefaults.standard.value(forKey: "new_fcm_token")! as! String
        
    }
    func clearFcmToken()
       {
           UserDefaults.standard.removeObject(forKey: "fcm_token")
           UserDefaults.standard.synchronize()
       }
    
}
