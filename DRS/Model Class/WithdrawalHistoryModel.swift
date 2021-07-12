//
//  WithdrawalHistoryModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/12/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class WithdrawalHistoryModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let withdrawalHistoryModelData: WithdrawalHistoryModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        withdrawalHistoryModelData = WithdrawalHistoryModelData(json["data"])
    }

}

class WithdrawalHistoryModelData {

    let referralWithdrawalHistory: [ReferralWithdrawalHistory]?

    init(_ json: JSON) {
        referralWithdrawalHistory = json["referral_withdrawal_history"].arrayValue.map { ReferralWithdrawalHistory($0) }
    }

}
class ReferralWithdrawalHistory {

    let date: String?
    let referralWithdrawalHistoryValue: [ReferralWithdrawalHistoryValue]?

    init(_ json: JSON) {
        date = json["date"].stringValue
        referralWithdrawalHistoryValue = json["value"].arrayValue.map { ReferralWithdrawalHistoryValue($0) }
    }

}

class ReferralWithdrawalHistoryValue {

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
