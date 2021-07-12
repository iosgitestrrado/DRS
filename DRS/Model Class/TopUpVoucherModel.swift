//
//  TopUpVoucherModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/29/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class TopUpVoucherModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let topUpVoucherModelData: TopUpVoucherModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        topUpVoucherModelData = TopUpVoucherModelData(json["data"])
    }

}



class TopUpVoucherModelData {

    let voucherList: [VoucherList]?
    let drsBankData: DrsBankData?
    let currency: String?

    init(_ json: JSON) {
        voucherList = json["voucher_list"].arrayValue.map { VoucherList($0) }
        drsBankData = DrsBankData(json["drs_bank_dat"])
        currency = json["currency"].stringValue
    }

}

class VoucherList {

    let id: Int?
    let title: String?
    let points: Int?
    let amount: Int?
    let image: String?
    let status: Int?
    let price: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        points = json["points"].intValue
        amount = json["amount"].intValue
        image = json["image"].stringValue
        status = json["status"].intValue
        price = json["price"].stringValue
    }

}

class DrsBankData {

    let bankName: String?
    let accountNumber: String?
    let holderName: String?
    let swiftCode: String?
    let branch: String?

    init(_ json: JSON) {
        bankName = json["bank_name"].stringValue
        accountNumber = json["account_number"].stringValue
        holderName = json["holder_name"].stringValue
        swiftCode = json["swift_code"].stringValue
        branch = json["branch"].stringValue
    }

}
