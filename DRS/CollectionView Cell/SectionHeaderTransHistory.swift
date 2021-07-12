//
//  SectionHeaderTransHistory.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/27/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class SectionHeaderTransHistory: UICollectionReusableView {

    @IBOutlet var lblHeader: UILabel!
    var strHeader:String!{
        didSet{
            lblHeader.text = strHeader
        }
    }
    
}
