//
//  WalletVC.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class WalletVC: UIViewController ,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    let reuseIdentifier = "WalletHistoryCell"
    let reuseIdentifierheader = "SectionHeader"
    var items = ["5,000 MMK", "10,000 MMK", "20,000 MMK","50,000 MMK", "100,000 MMK", "200,000 MMK"]
    var sectionitems = ["March 2020", "February 2020"]
   
    @IBOutlet var collectionWalletHistory: UICollectionView!
    @IBOutlet var searchWalletHistory: UISearchBar!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
     return sectionitems.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        let  firstheader: SectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierheader, for: indexPath) as! SectionHeader
        firstheader.strHeader = sectionitems[indexPath.section]
            reusableview = firstheader
        return reusableview
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionWalletHistory {
            let topupCell = collectionWalletHistory.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WalletHistoryCell
            topupCell.viewBG.layer.cornerRadius = 20
            topupCell.viewBG.clipsToBounds = true
            if indexPath.row == 0 {
                topupCell.lblStatus.text = "Successful"
                  topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
            } else if indexPath.row == 1 {
                 topupCell.lblStatus.text = "Pending"
                  topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            }else if indexPath.row == 2 {
                topupCell.lblStatus.text = "Unsuccessful"
                  topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
            }
          
            if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
                topupCell.widthViewBG.constant = 340
            }
            else if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
                topupCell.widthViewBG.constant = 370
                
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max" {
                 topupCell.widthViewBG.constant = 370
            }
            else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS" {
                 topupCell.widthViewBG.constant = 370
                
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
               
                  topupCell.widthViewBG.constant = 370
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                
                  topupCell.widthViewBG.constant = 370
            }
            else {
                 topupCell.widthViewBG.constant = 370
                
            }
         //topupCell.lblAmt.text = items[indexPath.row]
         //topupCell.viewCollectionBG.layer.cornerRadius = 10
         //topupCell.viewCollectionBG.clipsToBounds = true
            cell = topupCell
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // handle tap events
           print("You selected cell #\(indexPath.item)!")
           let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionInfoVC") as! TransactionInfoVC
           //self.navigationController?.pushViewController(next, animated: true)
       }
    
    override func viewWillAppear(_ animated: Bool) {
    self.title = "Wallet History"
    self.addBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        
        collectionWalletHistory.delegate = self
        collectionWalletHistory.dataSource = self
        searchWalletHistory.barTintColor = UIColor.clear
        searchWalletHistory.backgroundColor = UIColor.red
        searchWalletHistory.isTranslucent = true
        searchWalletHistory.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: " I'm looking for date", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        
        let textFieldInsideSearchBar = searchWalletHistory.value(forKey: "searchField") as? UITextField
        let fonts = UIFont .boldSystemFont(ofSize: 16.0)
        textFieldInsideSearchBar?.font = fonts
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.borderStyle = .none
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        
        if let textField = searchWalletHistory.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        /*
        let myView = UIView(frame: CGRect(x: 0, y: (textFieldInsideSearchBar?.frame.size.height)!-1, width: (textFieldInsideSearchBar?.frame.size.width)!, height: 2))
        myView.backgroundColor = UIColor.white
        textFieldInsideSearchBar!.addSubview(myView)*/
        
        let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
        
        searchWalletHistory.delegate = self
        searchWalletHistory.showsCancelButton = true
        print(UIDevice.current.screenType.rawValue)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Search bar",searchBar.text!)
        searchWalletHistory.resignFirstResponder()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {searchWalletHistory.text = ""
        print("Search bareeeeee")
         searchWalletHistory.resignFirstResponder()
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
