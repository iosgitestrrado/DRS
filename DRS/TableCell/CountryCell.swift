//
//  CountryCell.swift
//  DRS
//
//  Created by Jibu K Thomas on 02/06/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var lblDialCode: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
