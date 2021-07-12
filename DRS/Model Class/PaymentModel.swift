//
//  PaymentModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/10/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaymentModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let paymentModelData: PaymentModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        paymentModelData = PaymentModelData(json["data"])
    }

}
class PaymentModelData {

    let action: String?
    let transactionData: TransactionData?
    let failedReason: String?

    init(_ json: JSON) {
        failedReason = json["failed_reason"].stringValue
        action = json["actions"].stringValue
        transactionData = TransactionData(json["transaction_data"])
    }

}

class TransactionData {

    let amount: String?
    let merchantName: String?
    let date: String?
    let tranId: String?
    let rebate: String?
    let userId: String?

    init(_ json: JSON) {
        amount = json["amount"].stringValue
        merchantName = json["merchant_name"].stringValue
        date = json["date"].stringValue
        tranId = json["tran_id"].stringValue
        rebate = json["rebate"].stringValue
        userId = json["user_id"].stringValue
    }

}
