//
//  WalletHistoryCell.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/27/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class WalletHistoryCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTrans: UILabel!
    @IBOutlet var widthViewBG: NSLayoutConstraint!
    @IBOutlet var lblTransStatus: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblAmt: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var viewBG: UIView!
}
