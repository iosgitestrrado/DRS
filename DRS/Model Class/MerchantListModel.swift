//
//  AppVersionModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class MerchantListModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let merchantListModelData: MerchantListModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        merchantListModelData = MerchantListModelData(json["data"])
    }

}
class MerchantListModelData {

    let listFilter: ListFilter?
    let merchantList: [MerchantList]?

    init(_ json: JSON) {
        listFilter = ListFilter(json["list_filter"])
        merchantList = json["merchant_list"].arrayValue.map { MerchantList($0) }
    }

}

class ListFilter {

    let category: String?
    let categoryName: String?
    let searchKey: String?

    init(_ json: JSON) {
        category = json["category"].stringValue
        categoryName = json["category_name"].stringValue
        searchKey = json["search_key"].stringValue
    }

}


class MerchantList {

    let merchantId: String?
    let businessName: String?
    let category: String?
    let categoryName: String?
    let businessContactNumber: String?
    let rating: String?
    let distance: String?
    let cashback: String?
    let country: String?
    let region: String?
    let countryName: String?
    let regionName: String?
    let openStatus: String?
    let openTime: String?
    let closeTime: String?
    let logo: String?

    init(_ json: JSON) {
        merchantId = json["merchant_id"].stringValue
        businessName = json["business_name"].stringValue
        category = json["category"].stringValue
        categoryName = json["category_name"].stringValue
        businessContactNumber = json["business_contact_number"].stringValue
        rating = json["rating"].stringValue
        distance = json["distance"].stringValue
        cashback = json["cashback"].stringValue
        country = json["country"].stringValue
        region = json["region"].stringValue
        countryName = json["country_name"].stringValue
        regionName = json["region_name"].stringValue
        openStatus = json["open_status"].stringValue
        openTime = json["open_time"].stringValue
        closeTime = json["close_time"].stringValue
        logo = json["logo"].stringValue
    }

}
