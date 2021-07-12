//
//  CountryResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/7/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class OKDollarModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let oKDollarModelData: OKDollarModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        oKDollarModelData = OKDollarModelData(json["data"])
    }

}
class OKDollarModelData {

    let action: String?
    let okdollarData: OkdollarData?

    init(_ json: JSON) {
        action = json["action"].stringValue
        okdollarData = OkdollarData(json["okdollar_data"])
    }

}

class OkdollarData {

    let EncryptedText: String?
    let iVector: String?
    let MerchantNumber: String?
    let postUrl: String?
    let requestToJson: String?

    init(_ json: JSON) {
        EncryptedText = json["EncryptedText"].stringValue
        iVector = json["iVector "].stringValue
        MerchantNumber = json["MerchantNumber"].stringValue
        postUrl = json["post_url"].stringValue
        requestToJson = json["requestToJson"].stringValue
    }

}
