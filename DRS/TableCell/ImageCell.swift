//
//  ImageCell.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 17/06/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imageUp: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
