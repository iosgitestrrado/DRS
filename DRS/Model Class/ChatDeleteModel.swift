//
//  ChatDeleteModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChatDeleteModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let chatDeleteModelData: ChatDeleteModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        chatDeleteModelData = ChatDeleteModelData(json["data"])
    }

}
class ChatDeleteModelData {

    let message: String?

    init(_ json: JSON) {
        message = json["message"].stringValue
    }

}
