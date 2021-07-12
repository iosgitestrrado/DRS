//
//  MerchantQRModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/5/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class MerchantQRModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let merchantQRModelData: MerchantQRModelData?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        merchantQRModelData = MerchantQRModelData(json["data"])
    }

}

class MerchantQRModelData {

    let merchantQrdata: MerchantQrdata?
    let customerQrdata: CustomerQrdata?
    let drsCommission: DrsCommission?

    init(_ json: JSON) {
        merchantQrdata = MerchantQrdata(json["merchant_qrdata"])
        customerQrdata = CustomerQrdata(json["customer_qrdata"])
        drsCommission = DrsCommission(json["drs_commission"])
    }

}

class MerchantQrdata {

    let merchantId: String?
    let businessName: String?
    let category: String?
    let categoryName: String?
    let businessContactNumber: String?
    let profitShare: String?
    let serviceTax: String?
    let governmentTax: String?
    let accountBalance: String?

    init(_ json: JSON) {
        merchantId = json["merchant_id"].stringValue
        businessName = json["business_name"].stringValue
        category = json["category"].stringValue
        categoryName = json["category_name"].stringValue
        businessContactNumber = json["business_contact_number"].stringValue
        profitShare = json["profit_share"].stringValue
        serviceTax = json["service_tax"].stringValue
        governmentTax = json["government_tax"].stringValue
        accountBalance = json["account_balance"].stringValue
    }

}

class CustomerQrdata {

    let vPoints: Int?
    let wBalance: String?

    init(_ json: JSON) {
        vPoints = json["v_points"].intValue
        wBalance = json["w_balance"].stringValue
    }

}

class DrsCommission {

    let drsShare: DrsShare?
    let cashBack1: CashBack1?
    let cashBack2: CashBack2?
    let referral: Referral?
    let ratePerVoucherPoint: RatePerVoucherPoint?

    init(_ json: JSON) {
        drsShare = DrsShare(json["drs_share"])
        cashBack1 = CashBack1(json["cash_back_1"])
        cashBack2 = CashBack2(json["cash_back_2"])
        referral = Referral(json["referral"])
        ratePerVoucherPoint = RatePerVoucherPoint(json["rate_per_voucher_point"])
    }

}
class DrsShare {

    let value: String?
    let percent: Int?

    init(_ json: JSON) {
        value = json["value"].stringValue
        percent = json["percent"].intValue
    }

}
class CashBack1 {

    let value: String?
    let percent: Int?

    init(_ json: JSON) {
        value = json["value"].stringValue
        percent = json["percent"].intValue
    }

}
class CashBack2 {

    let value: String?
    let percent: Int?

    init(_ json: JSON) {
        value = json["value"].stringValue
        percent = json["percent"].intValue
    }

}

class Referral {

    let value: String?
    let percent: Int?

    init(_ json: JSON) {
        value = json["value"].stringValue
        percent = json["percent"].intValue
    }

}

class RatePerVoucherPoint {

    let value: String?
    let percent: Int?

    init(_ json: JSON) {
        value = json["value"].stringValue
        percent = json["percent"].intValue
    }

}
