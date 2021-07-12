//
//  ResentOTPModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//


import Foundation
import SwiftyJSON

class ResentOTPModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let desentOTPModelData: ResentOTPModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        desentOTPModelData = ResentOTPModelData(json["data"])
    }

}


class ResentOTPModelData {

    let action: String?
    let phoneNumber: String?
    let customerName: String?

    init(_ json: JSON) {
        action = json["action"].stringValue
        phoneNumber = json["phone_number"].stringValue
        customerName = json["customer_name"].stringValue
    }

}
