//
//  AppVersionModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON
class SettingsModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let settingsModelData: SettingsModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        settingsModelData = SettingsModelData(json["data"])
    }

}
class SettingsModelData {

    let customerData: CustomerData?

    init(_ json: JSON) {
        customerData = CustomerData(json["customer_data"])
    }

}
class CustomerData {

    let firstName: String?
    let lastName: String?
    let countryCode: String?
    let phoneNumber: String?
    let profilePic: String?
    let accountNo: String?
    let accountBalance: String?
    let voucherPoints: String?
    let notificationCount: Int?

    init(_ json: JSON) {
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        countryCode = json["country_code"].stringValue
        phoneNumber = json["phone_number"].stringValue
        profilePic = json["profile_pic"].stringValue
        accountNo = json["account_no"].stringValue
        accountBalance = json["account_balance"].stringValue
        voucherPoints = json["voucher_points"].stringValue
        notificationCount = json["notification_count"].intValue
    }

}
