//
//  CommissionHistoryModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/15/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommissionHistoryModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let commissionHistoryModelData: CommissionHistoryModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        commissionHistoryModelData = CommissionHistoryModelData(json["data"])
    }

}

class CommissionHistoryModelData {

    let referralRewards: [ReferralRewards]?

    init(_ json: JSON) {
        referralRewards = json["referral_rewards"].arrayValue.map { ReferralRewards($0) }
    }

}

class ReferralRewards {

    let id: String?
    let title: String?
    let date: String?
    let discription: String?
    let amount: String?
    let currency: String?
    let status: String?

    init(_ json: JSON) {
        id = json["id"].stringValue
        title = json["title"].stringValue
        date = json["date"].stringValue
        discription = json["discription"].stringValue
        amount = json["amount"].stringValue
        currency = json["currency"].stringValue
        status = json["status"].stringValue
    }

}
