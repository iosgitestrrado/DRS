//
//  OKDollarVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/2/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import WebKit
import SwiftyXMLParser
class OKDollarVC: UIViewController,WKNavigationDelegate,WKScriptMessageHandler {
    
    //MARK: - Outlets
    @IBOutlet weak var webKitOkDollar: WKWebView!
    
    //MARK: - Variables
    
    var urlString = String()
    var dataToSend = String()
    var strTitle:String = String()
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Top_Up_Wallet_ok_dollar.text {
                    strTitle = text
                    self.title = strTitle
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
                
                if let text = xml.resource.Top_Up_Wallet_ok_dollar.text {
                    strTitle = text
                    self.title = strTitle
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.changeLanguage()
        self.title = strTitle
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addBackButton()
        webKitOkDollar.navigationDelegate = self
        print("urlString",urlString)
        let url = URL(string: urlString)
        webKitOkDollar.load(URLRequest(url: url!))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        self.view.activityStopAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.view.activityStopAnimating()
        print("didFail",error)
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message",message)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            //urlStr is what you want
            
            if let range3 = (navigationAction.request.url?.absoluteString)!.range(of: "https://drssystem.co.uk/uat/api/okdoller/payment_result?tranid=", options: .caseInsensitive){
                print("urlStr 111111 ----- 55",urlStr)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.addCustomBackButton()
                }
            }
            
        }
        
        decisionHandler(.allow)
    }
    
    func addCustomBackButton() {
        let btnLeftMenu: UIButton = UIButton()
        let image = UIImage(named: "BackNav");
        btnLeftMenu.setImage(image, for: .normal)
        btnLeftMenu.setTitle("", for: .normal);
        btnLeftMenu.sizeToFit()
        btnLeftMenu.addTarget(self, action: #selector (backButtonsClick(sender:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
    }
    
    @objc func backButtonsClick(sender : UIButton) {
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
        
        let customViewControllersArray : NSArray = [newViewController]
        self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
        self.navigationController?.popToRootViewController(animated: true)
    }
    /**
     Response:***: success({
     data =     {
     action = "ok_dollar";
     "okdollar_data" =         {
     EncryptedText = "Au3f0cJnBmSLy3jlBzUbIR4MiFV8X+ZFFQ8NogN6ZgQC2ilEXfvzWbY3Okvq6Ht36Dr+WXFeByQXhnXI9xOQgzweXzgU8Pe4DtMle3w+sNX0z64g8Azetbh6A+J2oy2oUyrYJ6gsTRx1athqsfgYXYzy0Ss3tfSrPO3tpLRrQ5UhboSQ3AiUjKcuxSNRYMEm8wu/mqZKyKMEftZFCa3PjA==";
     MerchantNumber = 00959222222224;
     "iVector " = od9so4663r81k475;
     "post_url" = "http://69.160.4.151:8082/";
     requestToJson = "Au3f0cJnBmSLy3jlBzUbIR4MiFV8X+ZFFQ8NogN6ZgQC2ilEXfvzWbY3Okvq6Ht36Dr+WXFeByQXhnXI9xOQgzweXzgU8Pe4DtMle3w+sNX0z64g8Azetbh6A+J2oy2oUyrYJ6gsTRx1athqsfgYXYzy0Ss3tfSrPO3tpLRrQ5UhboSQ3AiUjKcuxSNRYMEm8wu/mqZKyKMEftZFCa3PjA==,od9so4663r81k475,00959222222224";
     };
     };
     httpcode = 200;
     message = "please finish payment with okdollar";
     status = success;
     })
     
     
     */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
