//
//  ChatListModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/17/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChatListModel {

    let status: String?
    let message: String?
    let chatListModelData: ChatListModelData?

    init(_ json: JSON) {
        status = json["status"].stringValue
        message = json["message"].stringValue
        chatListModelData = ChatListModelData(json["data"])
    }

}
class ChatListModelData {

    let chatList: [ChatList]?
    let offset: Int?

    init(_ json: JSON) {
        chatList = json["chat_list"].arrayValue.map { ChatList($0) }
        offset = json["offset"].intValue
    }

}

class ChatList {

    let chatId: Int?
    let name: String?
    let avthar: String?
    let unread: Int?
    let chatMsg: String?
    let msgType: String?
    let date: String?

    init(_ json: JSON) {
        chatId = json["chat_id"].intValue
        name = json["name"].stringValue
        avthar = json["avthar"].stringValue
        unread = json["unread"].intValue
        chatMsg = json["chat_msg"].stringValue
        msgType = json["msg_type"].stringValue
        date = json["date"].stringValue
    }

}
