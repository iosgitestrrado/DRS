//
//  CountryResponse.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/7/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class CountryResponse {

    let httpcode: String?
    let status: String?
    let message: String?
    let countryData: CountryData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        countryData = CountryData(json["data"])
    }

}

class CountryData {

    let countryList: [CountryList]?

    init(_ json: JSON) {
        countryList = json["country_list"].arrayValue.map { CountryList($0) }
    }

}
class CountryList {

    let id: Int?
    let name: String?
    let status: Int?

    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        status = json["status"].intValue
    }

}

