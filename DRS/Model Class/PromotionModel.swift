//
//  PromotionModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/12/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class PromotionModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let promotionModelData: PromotionModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        promotionModelData = PromotionModelData(json["data"])
    }

}
class PromotionModelData {

    let promotionData: PromotionData?

    init(_ json: JSON) {
        promotionData = PromotionData(json["promotion_data"])
    }

}

class PromotionData {

    let id: Int?
    let title: String?
    let description: String?
    let image: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        image = json["image"].stringValue
    }

}
