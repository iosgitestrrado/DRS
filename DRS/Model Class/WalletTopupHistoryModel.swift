//
//  WalletTopupHistoryModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class WalletTopupHistoryModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let walletTopupHistoryModelData: WalletTopupHistoryModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        walletTopupHistoryModelData = WalletTopupHistoryModelData(json["data"])
    }

}

class WalletTopupHistoryModelData {

    let walletTopupHistory: [WalletTopupHistory]?

    init(_ json: JSON) {
        walletTopupHistory = json["wallet_topup_history"].arrayValue.map { WalletTopupHistory($0) }
    }

}

class WalletTopupHistory {

    let date: String?
    let walletTopupHistoryValue: [WalletTopupHistoryValue]?

    init(_ json: JSON) {
        date = json["date"].stringValue
        walletTopupHistoryValue = json["value"].arrayValue.map { WalletTopupHistoryValue($0) }
    }

}

class WalletTopupHistoryValue {

    let id: String?
    let transactionId: String?
    let date: String?
    let time: String?
    let paidOn: String?
    let amount: String?
    let status: String?

    init(_ json: JSON) {
        id = json["id"].stringValue
        transactionId = json["transaction_id"].stringValue
        date = json["date"].stringValue
        time = json["time"].stringValue
        paidOn = json["paid_on"].stringValue
        amount = json["amount"].stringValue
        status = json["status"].stringValue
    }

}
