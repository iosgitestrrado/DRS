//
//  AppVersionModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 5/18/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class MerchantDetailModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let merchantDetailData: MerchantDetailData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        merchantDetailData = MerchantDetailData(json["data"])
    }

}
class MerchantDetailData {

    let merchantData: MerchantData?

    init(_ json: JSON) {
        merchantData = MerchantData(json["merchant_data"])
    }

}
class MerchantData {

    let merchantId: String?
    let businessName: String?
    let category: String?
    let categoryName: String?
    let businessContactNumber: String?
    let rating: String?
    let cashback: String?
    let distance: String?
    let address: String?
    let country: String?
    let region: String?
    let countryName: String?
    let regionName: String?
    let openStatus: String?
    let openTime: String?
    let closeTime: String?
    let personInchargeContactNumber: String?
    let locationLat: String?
    let locationLong: String?
    let specialCondition: String?
    let businessCertificate: String?
    let logo: String?
    let offDays: String?
    let promoImages: [String]?
   

    init(_ json: JSON) {
        
        merchantId = json["merchant_id"].stringValue
        businessName = json["business_name"].stringValue
        category = json["category"].stringValue
        categoryName = json["category_name"].stringValue
        businessContactNumber = json["business_contact_number"].stringValue
        rating = json["rating"].stringValue
        cashback = json["cashback"].stringValue
        distance = json["distance"].stringValue
        address = json["address"].stringValue
        country = json["country"].stringValue
        region = json["region"].stringValue
        countryName = json["country_name"].stringValue
        regionName = json["region_name"].stringValue
        openStatus = json["open_status"].stringValue
        openTime = json["open_time"].stringValue
        closeTime = json["close_time"].stringValue
        personInchargeContactNumber = json["person_incharge_contact_number"].stringValue
        locationLat = json["location_lat"].stringValue
        locationLong = json["location_long"].stringValue
        specialCondition = json["special_condition"].stringValue
        businessCertificate = json["business_certificate"].stringValue
        logo = json["logo"].stringValue
        offDays = json["off_days"].stringValue
        promoImages = json["promo_images"].arrayValue.map { $0.stringValue }
    }

}
