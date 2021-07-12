//
//  AboutUsVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import SwiftyXMLParser

class AboutUsVC: UIViewController {
    
    var strTitle:String = String()
    
    @IBOutlet var viewContent: UIView!
    
    @IBOutlet var viewBg: UIView!
    
    
    func changeLanguage() {
           let sharedDefault = SharedDefault()
           
           if sharedDefault.getLanguage() == 1 {
               print("Bermese")
               
               let path = Bundle.main.path(forResource: "mer_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                   
                   if let text = xml.resource.About.text {
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
                   
                  if let text = xml.resource.About.text {
                       strTitle = text
                    self.title = strTitle
                   }
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
               self.addBackButton()
               self.title = strTitle
        viewBg.layer.cornerRadius = 10.0
        self.changeLanguage()
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
