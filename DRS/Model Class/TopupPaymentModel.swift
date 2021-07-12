//
//  TopupPaymentModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/28/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class TopupPaymentModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let topupPaymentModelData: TopupPaymentModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        topupPaymentModelData = TopupPaymentModelData(json["data"])
    }

}

class TopupPaymentModelData {

    let action: String?

    init(_ json: JSON) {
        action = json["action"].stringValue
    }

}
