//
//  TermsVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/22/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import WebKit
import SwiftyXMLParser

class TermsVC: UIViewController, WKNavigationDelegate {
    var strTitle:String = ""
    @IBOutlet var webKitData: WKWebView!
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            
            let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Terms_and_Conditions_Title.text {
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
                
               if let text = xml.resource.Terms_and_Conditions_Title.text {
                    strTitle = text
                 self.title = strTitle
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.changeLanguage()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.addBackButton()
        self.title = strTitle
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webKitData.isUserInteractionEnabled = true
        webKitData.navigationDelegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: "https://drs-asia.com/privacy-policy/")
        //let url = URL(string: "https://en.wiktionary.org/wiki/Wiktionary:Main_Page")
        
        webKitData.load(URLRequest(url: url!))
        self.view.activityStartAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.activityStopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.view.activityStartAnimating()
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
