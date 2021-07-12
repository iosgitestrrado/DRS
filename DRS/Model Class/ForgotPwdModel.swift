//
//  AppVersionModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class ForgotPwdModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let forgotPwdModelData: ForgotPwdModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        forgotPwdModelData = ForgotPwdModelData(json["data"])
    }

}
class ForgotPwdModelData {

    let otpType: String?
    let msg: String?

    init(_ json: JSON) {
        otpType = json["otp_type"].stringValue
        msg = json["msg"].stringValue
    }

}
