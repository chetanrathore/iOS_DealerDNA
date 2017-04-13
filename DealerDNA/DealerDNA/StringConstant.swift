//
//  StringConstant.swift
//  DealerDNA
//
//  Created by LaNet on 4/10/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation


let isLoggedIn = "IsLoggedIn"
let isSetPasscode = "IsSetPasscode"
let appDetails = "AppDetails"

enum KLogin: String{
    case kUserName = "UserName",
    kPassword = "Password",
    kPhoneNo = "PhoneNo",
    kRemember = "Remember"
}

//Passcode
enum kPasscode {
    case kCheckPasscode,
    kCreatePasscode,
    kChangePasscode
}
