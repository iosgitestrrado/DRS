//
//  TopupModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/28/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class TopupModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let topupModelData: TopupModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        topupModelData = TopupModelData(json["data"])
    }

}
class TopupModelData {

    let walletAmounts: [WalletAmounts]?
    let drsBankDat: DrsBankDat?
    let minTopupAmount: String?
    let currency: String?

    init(_ json: JSON) {
        walletAmounts = json["wallet_amounts"].arrayValue.map { WalletAmounts($0) }
        drsBankDat = DrsBankDat(json["drs_bank_dat"])
        minTopupAmount = json["min_topup_amount"].stringValue
        currency = json["currency"].stringValue
    }

}
class WalletAmounts {

    let id: Int?
    let amount: Int?
    let description: String?
    let status: Int?
    let title: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        amount = json["amount"].intValue
        description = json["description"].stringValue
        status = json["status"].intValue
        title = json["title"].stringValue
    }

}
class DrsBankDat {

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
