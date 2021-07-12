//
//  PaymentHistoryModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/11/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaymentHistoryModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let paymentHistoryModelData: PaymentHistoryModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        paymentHistoryModelData = PaymentHistoryModelData(json["data"])
    }

}
class PaymentHistoryModelData {

    let paymentHistory: [PaymentHistory]?

    init(_ json: JSON) {
        paymentHistory = json["payment_history"].arrayValue.map { PaymentHistory($0) }
    }

}

class PaymentHistory {

    let date: String?
    let paymentHistoryValue: [PaymentHistoryValue]?

    init(_ json: JSON) {
        date = json["date"].stringValue
        paymentHistoryValue = json["value"].arrayValue.map { PaymentHistoryValue($0) }
    }

}
class PaymentHistoryValue {

    let id: String?
    let transactionId: String?
    let date: String?
    let time: String?
    let paidOn: String?
    let amount: String?
    let paymentType: String?
    let status: String?

    init(_ json: JSON) {
        id = json["id"].stringValue
        transactionId = json["transaction_id"].stringValue
        date = json["date"].stringValue
        time = json["time"].stringValue
        paidOn = json["paid_on"].stringValue
        amount = json["amount"].stringValue
        paymentType = json["payment_type"].stringValue
        status = json["status"].stringValue
    }

}
