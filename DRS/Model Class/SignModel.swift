//
//  SignModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/20/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class SignModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let signModelData: SignModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        signModelData = SignModelData(json["data"])
    }

}

class SignModelData {

    let accessToken: String?
    let msg: String?

    init(_ json: JSON) {
        accessToken = json["access_token"].stringValue
         msg = json["msg"].stringValue
    }

}
