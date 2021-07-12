//
//  OTPVerification.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class OTPVerification {

    let httpcode: String?
    let status: String?
    let message: String?
    let oTPVerificationData: OTPVerificationData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        oTPVerificationData = OTPVerificationData(json["data"])
    }

}


class OTPVerificationData {

    let action: String?
    let verifyData: VerifyData?

    init(_ json: JSON) {
        action = json["action"].stringValue
        verifyData = VerifyData(json["verify_data"])
    }

}

class VerifyData {

    let otpToken: String?
    let phoneNumber: String?
    let countryCode: String?

    init(_ json: JSON) {
        otpToken = json["otp_token"].stringValue
        phoneNumber = json["phone_number"].stringValue
        countryCode = json["country_code"].stringValue
    }

}
