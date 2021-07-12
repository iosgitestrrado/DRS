//
//  AssistantListCellTableViewCell.swift
//  DRS
//
//  Created by softnotions on 23/06/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class AssistantListCellTableViewCell: UITableViewCell {
    @IBOutlet weak var imgAssistant: UIImageView!
    
    @IBOutlet weak var lblHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
