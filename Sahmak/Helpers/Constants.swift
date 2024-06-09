//
//  Constants.swift
//  Deliy
//
//  Created by Youm7 on 10/2/17.
//  Copyright © 2017 binshakerr. All rights reserved.
//

import UIKit

public let BaseUrl = "https://uapi-sahmak.anspire.co"
public let GOOGLE_CLIENT_ID = "923927508303-2d70cgmnecqfbkrck9hdsssro1uus0s0.apps.googleusercontent.com"
public let GOOGLE = "google"
public let FACEBOOK = "facebook"
public let APPLE = "apple"
public let WAREHOUSE_MULTIRATE = "warehouse_multirate";
public let VENDOR_MULTIRATE = "vendor_multirate";
public let WAREHOUSE_LIST_ = "warehouse_list_";

let K_Device_ID = UIDevice.current.identifierForVendor!.uuidString
let K_Defaults = UserDefaults.standard
let K_Notifications = NotificationCenter.default
let K_AppDelegate = UIApplication.shared.delegate as! AppDelegate
//var K_TabBarVC: TabBarVC?
let K_Parse_Error = "Something is not correct, please try again later"
let K_Server_Error = "Something happened. Please try again later"
let K_Invalid_Access = "يرجى تسجيل الدخول اولا لاتمام العملية"
var timer:Timer?
var minutes = Array(1...59).map { "\($0)" }
var K_Network = NetworkRequest()
var K_CollectionCellWidth = (UIScreen.main.bounds.width/2)-12
var K_CollectionCellHeight = (K_CollectionCellWidth*4)/3
var K_TabCellWidth = 100
var K_TabCellHeight = 44

enum Saved { //keys of userDefaults
    static let TOKEN = "token"
    static let USER_ID = "user_id"
    static let COUNTRY_CODE = "countryCode"
    static let PHONE_NUMBER = "phone_number"
    static let USER_NAME = "user_name"
    static let DEVICE_TOKEN = "device_token"
    static let FCM_TOKEN = "fcm_token"
    static let LANGUAGE = "language"
    static let IS_VERIFIED = "isVerified"
    static let K_PopupNotifications = "K_PopupNotifications"
    static let USER_PHOTO = "user_photo"
    static let TUTORIAL_SKIPPED = "toturial_skipped"
}

enum PaymentMethods {
    static let BAZZARRY_PAYMENT = "bazzarrypayment"
    static let BANKEBDA = "bankebda"
    static let CASH_DELIVERY = "cashondelivery"
    static let BANK_DEPOSITS = "bankdeposits"
}
