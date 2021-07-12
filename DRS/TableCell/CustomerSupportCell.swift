
//
//  CustomerSupportCell.swift
//  DRS
//
//  Created by Jibu K Thomas on 02/05/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class CustomerSupportCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewCustBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
