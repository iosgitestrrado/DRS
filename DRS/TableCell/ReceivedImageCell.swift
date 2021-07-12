
//
//  ReceivedImageCell.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 10/06/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class ReceivedImageCell: UITableViewCell {

    @IBOutlet var imgReceived: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
