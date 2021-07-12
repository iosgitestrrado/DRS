
//
//  ReferralTableCell.swift
//  DRS
//
//  Created by Jibu K Thomas on 02/05/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class NotificationTableCell: UITableViewCell {
   
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
