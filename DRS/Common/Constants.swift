//
//  Constants.swift
//  DRS
//
//  Created by Softnotions Technologies Pvt Ltd on 4/23/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit
class Constants{
    static let textColor =  UIColor(red: 95.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0)
    static let textRedColor =  UIColor(red: 218.0/255.0, green: 55.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    static let textBGColor =  UIColor(red: 244.0/255.0, green: 245.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    static let UI = "Payment details"
    static let NoResult = "No records found"
    // Create a password page
    static let CreatePwdName = "Enter name"
    static let CreatePwdPageHead = "Create a password"
    static let CreatePwdPageSubHead = "Create a password with 6 number to safe guard your DRS"
    static let CreatePwdPageSubHeadReg = "Complete Your Registration"
    static let CreatePwdPagePassword = "Enter password"
    static let CreatePwdPageRePassword = "Re-enter password"
    static let CreatePwdPageReferal = "Referrral ID * if Any"
    static let CreatePwdPageSubmit = "ENTER"
    // Login page
    static let LoginPageHead = "Welcome"
    static let TxtPwdPlaceholder = "Enter your password"
    static let LoginSignBtn = "SIGN IN"
    static let BtnForgotPwd = "Forgot Password"
    // Payment Detail OTP page
    static let PaymentDetailsPageTitle = "Payment details"
    static let PaymentDetailsDone = "DONE"
    static let PaymentDetailsPageMainTitle = "Verification codes"
    static let PaymentDetailsPageSubTitle = "Please ask Merchant to Key In Payment Pin Code codes"
    // Payment Detail OTP page
    static let TransactionDetPageTitle = "Transaction Details"
    static let TransactionDetPageSubTitle = "Payment Successful"
    static let TransactionDetPageSubTitleSec = "Payment Unsuccessful"
    static let TransactionDetPageTotal = "Total"
    static let TransactionDetPageMName = "Merchant Name"
    static let TransactionDetPageDate = "Date and time"
    static let TransactionDetPageTransaction = "Transaction ID"
    static let TransactionDetPageUser = "User ID"
    static let TransactionDetPageRebate = "Rebate Entitled"
    static let TransactionDetPageRebateBermese = "ပြန်ရငွေ"

    static let TransactionDetPageFailMsg = "Merchant Insufficient Credit Unable to Proceed"
    static let LOGIN_VALIDATION_MSG = "Username and Password cannot be left empty"
    //user home
    static let items = ["Top Up Wallet", "Buy Voucher Point", "Share"]
    //static let items = ["Top Up Wallet", "Buy Voucher Point"]
    
    static let updateBtnEng = "Update"
    static let updateBtnBur = "နောက်ဆုံးသတင်း"
    
    static let APP_NAME = "DRS User"
    static let APP_NAME_BUR = "DRS အသုံးပြုသူ"
     static let OK_TITLE_ENG = "OK"
     static let OK_TITLE_BUR = "ရလား"
    
    static let APP_NO_NETWORK = "Please check the network connection!"
    
    //https://estrradodemo.com/drs/api/customer/version
    //https://drssystem.co.uk/uat/api/
    
    //URL
//    static let baseURL = "https://drssystem.co.uk/uat/api/customer/" // stagging
//    static let baseChatURL = "https://drssystem.co.uk/uat/api/" //stagging
    
   static let baseChatURL = "https://drssystem.co.uk/api/" //live
   static let baseURL = "https://drssystem.co.uk/api/customer/" //live

    static let versionURL = "version"
    //static let baseURL = "https://estrradodemo.com/drs/uat/api/customer/" // stagging
    static let phoneNumberURL = "version"
    static let validateOTPURL = "otp_verify"
    static let validateMobileURL = "validatemobile"
    static let signupURL = "signup"
    static let signinURL = "signin"
    static let forgotPwdURL = "forgot_password"
    static let resetPwdURL = "reset_password"
    static let resendOTPURL = "resend_otp"
    static let settingsPageURL = "settingpage"
    static let merchantPageURL = "our_merchants"
    static let merchantShopDetailURL = "merchant_view"
    static let merchantShopListURL = "merchant_list"
    static let SignOutURL = "signout"
    static let AccountInfoURL = "account"
    static let GetCountryURL = "countries"
    
    static let DeleteURL = "support/delete"
    static let MessageDetailURL = "support/message"
    
    static let WalletTopUPAmtURL = "wallet/topup_page"
    static let TopupPaymentURL = "wallet/topup_payment"
    static let UploadProfilePicURL = "account/update/profilepic"
    static let UpdateAccountURL = "account/update/account_info"
    
    static let DashboardURL = "dashboard"
    static let VoucherTopUpURL = "voucher/topup_page"
    static let VoucherTopUpVoucherURL = "voucher/topup_payment"
    
    static let WalletHistoryURL = "wallet/history"
    static let VoucherHistoryURL = "voucher/history"
    static let MerchantQRDetailURL = "merchant/qrscan"
    
    static let PaymentURL = "merchant/payment"
    static let WithdrawPageURL = "referal/withdrawal_page"
    static let WithdrawPaymentURL = "referal/withdrawal_payment"
    
    static let ReferalInviteURL = "referal/invite"
    static let ReferalRewardURL = "referal/rewards"
    
    static let PaymentHistoryURL = "merchant/payment/history"
    static let WalletWithdrawalURL = "referal/withdrawal_history"
    static let PromotionDetailURL = "promotions/view"
    static let AssistantDetailURL = "assistant/view"
    
    static let ReviewDetailURL = "merchant/review/view"
    static let ReviewUpdateURL = "merchant/review/update"
    
    static let SupportMessageListURL = "support/list"
    static let CreateNewChatURL = "support/create"
    static let SendChatURL = "support/send/message"
    
    static let NotificationList = "notificatinos"
    static let NewsEventDetail = "news"
    
    //Messages
    
    static let updateMsgEng = "A new vesion of DRS User app is available in app store. Please update"
    static let updateMsgBur = "DRSအသုံးပြုသူအက်ပလီကေးရှင်းအသစ်ကိုရနိုင်ပါသည်။ ကျေးဇူးပြု၍အဆင့်မြှင့်တင်ပါ"
    
    static let noRecordEng = "No records found"
    static let noRecordBur = "မှတ်တမ်းမရှိသေးပါ"
    
    static let InvalidAccessEng = "Invalid access token"
    static let InvalidAccessBur = "ဆက်သွယ်မှုလက္ခဏာမမှန်ကန်ပါ"
    
    static let ReqTimedOutEng = "Request timed out! Please try again!"
    static let ReqTimedOutBur = "အချိန်ကုန်ခံတောင်းဆိုမှု! ကျေးဇူးပြု၍ ထပ်မံကြိုးစားပါ"
    
    static let ServerErrorEng = "Server error! Please contact support!"
    static let ServerErrorBur = "ဆာဗာအမှား! ထောက်ခံမှုကိုဆက်သွယ်ပါ။"
    
    static let IntServerErrorEng = "Internal server error! Please try again!!"
    static let IntServerErrorBur = "အတွင်းဆာဗာမှားယွင်းမှု! ကျေးဇူးပြု၍ ထပ်မံကြိုးစားပါ"
    
    static let selectCountryEng = "Select country"
    static let enterPhoneEng = "Enter phone number"
    static let slectTermsEng = "Select terms & condition check box"
    
    static let selectCountryBur = "နိုင်ငံကိုရွေးချယ်ပါ"
    static let enterPhoneBur = "ဖုန်းနံပါတ်ထည့်ပါ"
    static let slectTermsBur = "စည်းကမ်းချက်များနှင့်အခြေအနေ check box ကိုရွေးချယ်ပါ"
   
    
    
    static let InvalidPaymentCodeEng = "Payment code does not match"
    static let InvalidPaymentCodeBur = "ငွေပေးချေမှုကုဒ်မကိုက်ညီ"
    
    
    static let inSufficientAmountWalletENG = "Insufficient Wallet Credit.Unable to Proceed"
    static let inSufficientAmountWalletBUR = "ဆက်လက်ဆောင်ရွက်ရန်မရပါ မလုံလောက်ပိုက်ဆံအိတ်ခရက်ဒစ်"
    
    static let inSufficientAmountCreditENG = "Merchant Insufficient Credit.Unable to Proceed"
    static let inSufficientAmountCreditBUR = "ဆက်လက်ဆောင်ရွက်ရန်မရပါ မလုံလောက်သောချေးငွေ"
    
    
}


