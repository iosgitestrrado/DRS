//
//  MerchantReviewPageLoadModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/16/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class MerchantReviewPageLoadModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let merchantReviewPageLoadModelData: MerchantReviewPageLoadModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        merchantReviewPageLoadModelData = MerchantReviewPageLoadModelData(json["data"])
    }

}

class MerchantReviewPageLoadModelData {

    let reviewPage: ReviewPage?

    init(_ json: JSON) {
        reviewPage = ReviewPage(json["review_page"])
    }

}

class ReviewPage {

    let priceRangeList: [PriceRangeList]?
    let reviewData: ReviewData?

    init(_ json: JSON) {
        priceRangeList = json["price_range_list"].arrayValue.map { PriceRangeList($0) }
        reviewData = ReviewData(json["review_data"])
    }

}

class PriceRangeList {

    let id: Int?
    let title: String?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        status = json["status"].intValue
    }

}

class ReviewData {

    let priceRangeId: Int?
    let rating: Int?
    let review: String?
    let status: Int?
    let lastUpdated: String?

    init(_ json: JSON) {
        priceRangeId = json["price_range_id"].intValue
        rating = json["rating"].intValue
        review = json["review"].stringValue
        status = json["status"].intValue
        lastUpdated = json["last_updated"].stringValue
    }

}
