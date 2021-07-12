//
//  NewsModel.swift
//  DRS
//
//  Created by softnotions on 04/08/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let newsModelData: NewsModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        newsModelData = NewsModelData(json["data"])
    }

}

class NewsModelData {

    let newsData: NewsData?

    init(_ json: JSON) {
        newsData = NewsData(json["news_data"])
    }

}
class NewsData {

    let id: Int?
    let title: String?
    let sortDescription: String?
    let description: String?
    let image: String?
    let createdAt: String?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        sortDescription = json["sort_description"].stringValue
        description = json["description"].stringValue
        image = json["image"].stringValue
        createdAt = json["created_at"].stringValue
    }

}
