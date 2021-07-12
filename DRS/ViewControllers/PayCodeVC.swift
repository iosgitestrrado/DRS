//
//  PayCodeVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class PayCodeVC: UIViewController {
   
    @IBOutlet var viewDisplayQR: UIView!
   
    @IBOutlet var viewQRDisplay: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear ScanCodeVC ")
        
        self.title = "Pay Code"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        
        
        self.addBackButton()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewQRDisplay.addSubview(viewDisplayQR)
       
    }
    
   
    @IBAction func btnNextAction(_ sender: Any) {
          
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
