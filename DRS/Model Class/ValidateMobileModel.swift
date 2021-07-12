//
//  ValidateMobileModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class ValidateMobileModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let validateMobileModelData: ValidateMobileModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        validateMobileModelData = ValidateMobileModelData(json["data"])
    }

}
class ValidateMobileModelData {

    
    let action: String?
    let phoneNumber: String?
    let countryCode: String?
    let otpType: String?
    let customerName: String?
    init(_ json: JSON) {
        action = json["action"].stringValue
        phoneNumber = json["phone_number"].stringValue
        countryCode = json["country_code"].stringValue
        otpType = json["otp_type"].stringValue
        customerName = json["customer_name"].stringValue
        
    }

}
