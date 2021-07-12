//
//  VoucherPointHistoryModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class VoucherPointHistoryModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let voucherPointHistoryModelData: VoucherPointHistoryModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        voucherPointHistoryModelData = VoucherPointHistoryModelData(json["data"])
    }

}

class VoucherPointHistoryModelData {

    let voucherPointHistory: [VoucherPointHistory]?

    init(_ json: JSON) {
        voucherPointHistory = json["voucher_point_history"].arrayValue.map { VoucherPointHistory($0) }
    }

}

class VoucherPointHistory {

    let date: String?
    let voucherPointHistoryValue: [VoucherPointHistoryValue]?

    init(_ json: JSON) {
        date = json["date"].stringValue
        voucherPointHistoryValue = json["value"].arrayValue.map { VoucherPointHistoryValue($0) }
    }

}

class VoucherPointHistoryValue {

    let id: String?
    let transactionId: String?
    let date: String?
    let time: String?
    let paidOn: String?
    let point: String?
    let amount: String?
    let paymentType: String?
    let status: String?

    init(_ json: JSON) {
        id = json["id"].stringValue
        transactionId = json["transaction_id"].stringValue
        date = json["date"].stringValue
        time = json["time"].stringValue
        paidOn = json["paid_on"].stringValue
        point = json["point"].stringValue
        amount = json["amount"].stringValue
        paymentType = json["payment_type"].stringValue
        status = json["status"].stringValue
    }

}
