//
//  SignUpModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class SignUpModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let signUpModelData: SignUpModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        signUpModelData = SignUpModelData(json["data"])
    }

}
class SignUpModelData {

    let message: String?
    let customer_name: String?

    init(_ json: JSON) {
        message = json["message"].stringValue
        customer_name = json["customer_name"].stringValue

    }

}
