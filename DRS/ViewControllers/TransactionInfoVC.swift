//
//  TransactionInfoVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class TransactionInfoVC: UIViewController {

    @IBOutlet var lblRefNo: UILabel!
    @IBOutlet var lblVPTBal: UILabel!
    @IBOutlet var viewPomts: UIView!
    @IBOutlet var lblTransDetail: UILabel!
    @IBOutlet var lblTransStatus: UILabel!
    @IBOutlet var imgPage: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
    self.title = "Transaction Information"
    self.addBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewPomts.layer.cornerRadius = 15
        viewPomts.clipsToBounds = true
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
