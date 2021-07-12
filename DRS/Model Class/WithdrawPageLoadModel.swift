//
//  WithdrawPageLoadModel.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 6/10/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

class WithdrawPageLoadModel {

    let httpcode: String?
    let status: String?
    let message: String?
    let withdrawPageLoadModeldata: WithdrawPageLoadModelDatas?

    init(_ json: JSON) {
        httpcode = json["httpcode"].stringValue
        status = json["status"].stringValue
        message = json["message"].stringValue
        withdrawPageLoadModeldata = WithdrawPageLoadModelDatas(json["data"])
    }

}
class WithdrawPageLoadModelDatas {

    let referalAccountBalance: String?
    let drsBankDataWithdraw: DrsBankDataWithdraw?
    let minTopupAmount: Int?
    let processingFee: Int?

    init(_ json: JSON) {
        referalAccountBalance = json["referal_account_balance"].stringValue
        drsBankDataWithdraw = DrsBankDataWithdraw(json["drs_bank_data"])
        minTopupAmount = json["min_topup_amount"].intValue
        processingFee = json["processing_fee"].intValue
    }

}
class DrsBankDataWithdraw {

    let bankName: String?
    let branchAddress: String?
    let swiftCode: String?
    let accountHolder: String?
    let accountNumber: String?
    let bankBook: String?

    init(_ json: JSON) {
        bankName = json["bank_name"].stringValue
        branchAddress = json["branch_address"].stringValue
        swiftCode = json["swift_code"].stringValue
        accountHolder = json["account_holder"].stringValue
        accountNumber = json["account_number"].stringValue
        bankBook = json["bank_book"].stringValue
    }

}
