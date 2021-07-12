//
//  PromotionListVC.swift
//  DRS
//
//  Created by softnotions on 23/06/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class PromotionListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let sharedDefault = SharedDefault()
    
    var items = ["Top Up Wallet", "Buy Voucher Point", "Share","Top Up Wallet", "Buy Voucher Point", "Share"]
        var promotionArray = [Promotions]()
    let reuseIdentifierPrice = "PromotionListCell"
    @IBOutlet weak var tablePromotion: UITableView!
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
         return promotionArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // Make the background color show through
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tablePromotion {
            let cellBal = tablePromotion.dequeueReusableCell(withIdentifier: reuseIdentifierPrice, for: indexPath) as! PromotionListCell
            cellBal.backgroundColor = UIColor.white
            cellBal.selectionStyle = .none
            cellBal.layer.cornerRadius = 10
            cellBal.clipsToBounds  = true
            cellBal.lblHeader.text = promotionArray[indexPath.section].title
            cellBal.imagePromotion.roundCorners(corners: [.topLeft,.topRight], radius: 10)
            cellBal.imagePromotion.sd_setImage(with: URL(string: self.promotionArray[indexPath.section].image!), placeholderImage: nil)
            //promotionCell.imgviewCollection.sd_setImage(with: URL(string: self.promotionArray[indexPath.row].image!), placeholderImage: nil)
            
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableNotification ",indexPath.row)
        print("tableNotification section ",indexPath.section)
        let next = self.storyboard?.instantiateViewController(withIdentifier: "PromotionDetail") as! PromotionDetail
        next.promotionID = String(self.promotionArray[indexPath.section].id!)
        next.pagetype = true
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if sharedDefault.getLanguage() == 0 {
             self.title = "Promotions"
        } else if sharedDefault.getLanguage() == 1 {
             self.title = "ပရိုမိုးရှင်းများ"
        }
        
        
         self.addBackButton()
        
        
        tablePromotion.delegate = self
        tablePromotion.dataSource = self
        
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
