//
//  DashdoardModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/29/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//
import Foundation
import SwiftyJSON

class DashdoardModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let dashdoardModelData: DashdoardModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        dashdoardModelData = DashdoardModelData(json["data"])
    }

}

class DashdoardModelData {

    let greetingMsg: String?
    let customerData: CustomerDatas?
   let promotions: [Promotions]?
    let tutorials: [Tutorials]?

    init(_ json: JSON) {
        greetingMsg = json["greeting_msg"].stringValue
        customerData = CustomerDatas(json["customer_data"])
        promotions = json["promotions"].arrayValue.map { Promotions($0) }
        tutorials = json["tutorials"].arrayValue.map { Tutorials($0) }
    }

}

class CustomerDatas {

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

class Promotions {

    let id: Int?
    let title: String?
    let image: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        image = json["image"].stringValue
    }

}

class Tutorials {

    let id: Int?
    let title: String?
    let subTitle: String?
    let image: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        subTitle = json["sub_title"].stringValue
        image = json["image"].stringValue
    }

}
