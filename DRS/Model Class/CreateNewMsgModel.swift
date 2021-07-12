//
//  CreateNewMsgModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class CreateNewMsgModel {
    
  

    let httpcode: String?
    let status: String?
    let message: String?
    let createNewMsgModelData: CreateNewMsgModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        createNewMsgModelData = CreateNewMsgModelData(json["data"])
    }

}

class CreateNewMsgModelData {

    let chatId: Int?
    let chatData: ChatData?

    init(_ json: JSON) {
        chatId = json["chat_id"].intValue
        chatData = ChatData(json["chat_data"])
    }

}

class ChatData {

    let chatId: Int?
    let name: String?
    let avthar: String?

    init(_ json: JSON) {
        chatId = json["chat_id"].intValue
        name = json["name"].stringValue
        avthar = json["avthar"].stringValue
    }

}
