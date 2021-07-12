//
//  NotificationListModel.swift
//  DRS
//
//  Created by softnotions on 03/08/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//


import Foundation
import SwiftyJSON

class NotificationListModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let notificationsData: NotificationsData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        notificationsData = NotificationsData(json["data"])
    }

}
class NotificationsData {

    let notificationsList: [NotificationsList]?

    init(_ json: JSON) {
        notificationsList = json["notifications"].arrayValue.map { NotificationsList($0) }
    }

}
class NotificationsList {

    let notifyOn: String?
    let notifyType: String?
    let typeId: Int?
    let title: String?
    let message: String?
    let viewStatus: String?

    init(_ json: JSON) {
        notifyOn = json["notify_on"].stringValue
        notifyType = json["notify_type"].stringValue
        typeId = json["type_id"].intValue
        title = json["title"].stringValue
        message = json["message"].stringValue
        viewStatus = json["view_status"].stringValue
    }

}
