//
//  AppVersionModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON


class AccInfoModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let accInfoModelData: AccInfoModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        accInfoModelData = AccInfoModelData(json["data"])
    }

}
class AccInfoModelData {

    let generalInfo: GeneralInfo?
    let bankInfo: BankInfo?
     let message: String?

    init(_ json: JSON) {
        generalInfo = GeneralInfo(json["general_info"])
        bankInfo = BankInfo(json["bank_info"])
         message = json["message"].stringValue
    }

}

class GeneralInfo {

    let firstName: String?
    let lastName: String?
    let countryCode: String?
    let phoneNumber: String?
    let profilePic: String?
    let age: String?
    let gender: String?
    let idNo: String?
    let address: String?
    let country: String?
    let countryName: String?
    let email: String?
    let referalId: String?

    init(_ json: JSON) {
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        countryCode = json["country_code"].stringValue
        phoneNumber = json["phone_number"].stringValue
        profilePic = json["profile_pic"].stringValue
        age = json["age"].stringValue
        gender = json["gender"].stringValue
        idNo = json["id_no"].stringValue
        address = json["address"].stringValue
        country = json["country"].stringValue
        countryName = json["country_name"].stringValue
        email = json["email"].stringValue
        referalId = json["referal_id"].stringValue
    }

}
class BankInfo {

    let bankName: String?
    let branchAddress: String?
    let swiftCode: String?
    let accountHolder: String?
    let accountNumber: String?

    init(_ json: JSON) {
        bankName = json["bank_name"].stringValue
        branchAddress = json["branch_address"].stringValue
        swiftCode = json["swift_code"].stringValue
        accountHolder = json["account_holder"].stringValue
        accountNumber = json["account_number"].stringValue
    }

}
