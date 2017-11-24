//
//  Constants.swift
//  RandomUsers
//
//  Created by Hristina Bailova on 11/24/17.
//  Copyright © 2017 Hristina Bailova. All rights reserved.
//

import Foundation
import UIKit

struct Constansts {
    // Get 10 users with each request
    // so that the data to be loaded step by step
    static let APIURL = "https://randomuser.me/api/?results=10"
    
    static let noEmailTitle = "Cannot send email"
    static let noEmailMessage = "You cannot send email, because the device does not support Mail App."
    static let invalidPhoneNumberTitle = "Cannot make a call"
    static let invalidPhoneNumberMessage = "You cannot make a call, because this number is invalid."
    
    static let heightForHeader: CGFloat = 35
}
