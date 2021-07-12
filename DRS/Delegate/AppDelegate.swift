//
//  AppDelegate.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/21/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import CoreLocation
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIViewController, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
var window: UIWindow?
var versionModel: VersionModel?
    let sharedData = SharedDefault()
     let sharedDefault = SharedDefault()
var locationManager = CLLocationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locationManager.requestWhenInUseAuthorization()
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        
        Messaging.messaging().delegate = self
        
        
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            //print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            //print("Remote instance ID token: \(result.token)")
            //self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
          }
        }
        
       
      
        
        self.getVersion()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var initialPage = UIViewController()
           
      
        print("getLoginStatus ----",sharedDefault.getLoginStatus())
        if sharedDefault.getLoginStatus() == true {
            initialPage = mainStoryboard.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
        } else {
             initialPage = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        }
        
        let navigationController = UINavigationController(rootViewController: initialPage)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    func getVersion() {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.versionURL
        print("loginURL: ",loginURL)
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.versionModel = VersionModel(response)
                    //print("self.versionModel ",self.versionModel!)
                    //print("self.versionModel ",self.versionModel?.httpcode!)
                    //print("self.loginResponse ",self.forgotPwdResponse?.forgotPwdData.)
                    
                    let statusCode = Int((self.versionModel?.httpcode)!)
                    if statusCode == 200{
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                            let serviceAppVersion = self.versionModel?.versionModelData?.version!
                            let iosInitial:String = (self.versionModel?.versionModelData?.iosInitialUpdate!)!
                           // print("currentAppVersion === = ",NumberFormatter().number(from: currentAppVersion!)!.doubleValue)
                           // print("serviceAppVersion === = ",NumberFormatter().number(from: serviceAppVersion!)!.doubleValue)
                           // print("iosInitial === = ",iosInitial)
                            if Int(iosInitial) != 1
                            {
                                if NumberFormatter().number(from: serviceAppVersion!)!.doubleValue <
                                    NumberFormatter().number(from: currentAppVersion!)!.doubleValue {
                                    let sharedDefault = SharedDefault()
                                    var appName = String()
                                    var appMsg = String()
                                    var updateBt = String()
                                    
                                    if sharedDefault.getLanguage() == 1 {
                                        appName = Constants.APP_NAME_BUR
                                        appMsg = Constants.updateMsgBur
                                        updateBt = Constants.updateBtnBur
                                    } else  if sharedDefault.getLanguage() == 0 {
                                        appName = Constants.APP_NAME
                                        appMsg = Constants.updateMsgEng
                                        updateBt = Constants.updateBtnEng
                                    }
                                    
                                    
                                    let alertController = UIAlertController (title: appName, message: appMsg, preferredStyle: .alert)
                                    
                                    
                                    alertController.addAction(UIAlertAction(title: updateBt, style: .default, handler: { action in
                                        if let url = URL(string: "https://apps.apple.com/us/app/id1516639728") {
                                            UIApplication.shared.open(url)
                                        }
                                    }))
                                    
                                    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                                    
                                    alertWindow.rootViewController = UIViewController()
                                    alertWindow.windowLevel = UIWindow.Level.alert + 1;
                                    alertWindow.makeKeyAndVisible()
                                    
                                    alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
                                    
                                }
                                
                            }
                            
                           
                            
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        
                        self.showAlert(title: Constants.APP_NAME, message: (self.versionModel?.message)!)
                        
                        
                    }
                    
                    self.view.activityStopAnimating()
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0,*)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0,*)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")
       sharedDefault.setNewFcmToken(token: fcmToken)
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: "fcm_token")
        {
           print("savedValue fcm_token ----- ",savedValue)
        } else {
          sharedDefault.setFcmToken(token: fcmToken)
        }
        
      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

            print(error.localizedDescription)
            print("Not registered notification")
    }
    /*
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
      Messaging.messaging().apnsToken = deviceToken
    }
*/
}
