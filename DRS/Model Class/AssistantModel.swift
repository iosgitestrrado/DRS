//
//  AssistantModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/12/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssistantModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let assistantModelData: AssistantModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        assistantModelData = AssistantModelData(json["data"])
    }

}

class AssistantModelData {

    let assistantData: AssistantData?

    init(_ json: JSON) {
        assistantData = AssistantData(json["assistant_data"])
    }

}

class AssistantData {

    let id: Int?
    let title: String?
    let subTitle: String?
    let description: String?
    let image: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        subTitle = json["sub_title"].stringValue
        description = json["description"].stringValue
        image = json["image"].stringValue
    }

}
