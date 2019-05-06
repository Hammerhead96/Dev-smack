//
//  Constants.swift
//  Dev-smack
//
//  Created by Mac User on 5/3/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()
// URL Constants
let BASE_URL = " https://devsmack.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let BACK = "unwindToLoginVC"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
