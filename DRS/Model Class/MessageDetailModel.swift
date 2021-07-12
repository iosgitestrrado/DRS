//
//  MessageDetailModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class MessageDetailModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let messageDetailModelData: MessageDetailModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        messageDetailModelData = MessageDetailModelData(json["data"])
    }

}

class MessageDetailModelData {

    let chatId: Int?
    let chatData: ChatDatas?
    let chatMessages: [ChatMessages]?

    init(_ json: JSON) {
        chatId = json["chat_id"].intValue
        chatData = ChatDatas(json["chat_data"])
        chatMessages = json["chat_messages"].arrayValue.map { ChatMessages($0) }
    }

}

class ChatDatas {

    let chatId: Int?
    let name: String?
    let avthar: String?

    init(_ json: JSON) {
        chatId = json["chat_id"].intValue
        name = json["name"].stringValue
        avthar = json["avthar"].stringValue
    }

}

class ChatMessages {

    let date: String?
    let chatMessagesValue: [ChatMessagesValue]?

    init(_ json: JSON) {
        date = json["date"].stringValue
        chatMessagesValue = json["value"].arrayValue.map { ChatMessagesValue($0) }
    }

}

class ChatMessagesValue {

    let me: Int?
    let msgId: Int?
    let userId: Int?
    let chatId: Int?
    let from: String?
    let type: String?
    let message: String?
    let date: String?
    let time: String?

    init(_ json: JSON) {
        me = json["me"].intValue
        msgId = json["msg_id"].intValue
        userId = json["user_id"].intValue
        chatId = json["chat_id"].intValue
        from = json["from"].stringValue
        type = json["type"].stringValue
        message = json["message"].stringValue
        date = json["date"].stringValue
        time = json["time"].stringValue
    }

}
