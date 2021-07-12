//
//  InviteEarnModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/11/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class InviteEarnModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let inviteEarnModelData: InviteEarnModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        inviteEarnModelData = InviteEarnModelData(json["data"])
    }

}

class InviteEarnModelData {

    let earnings: String?
    let referalId: String?

    init(_ json: JSON) {
        earnings = json["earnings"].stringValue
        referalId = json["referal_id"].stringValue
    }

}
