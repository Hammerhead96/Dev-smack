//
//  AuthService.swift
//  Dev-smack
//
//  Created by Mac User on 5/5/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    } // end isLoggedIn
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    } // end authToken
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    } // end userEmail
}
func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
    let lowerCaseEmail = email.lowercased()
    let header = [ "Content-Type": "application/json; charset=utf-8" ]
    let body: [String: Any] = [ "email": lowerCaseEmail, "password": password ]
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
        if response.result.error == nil {
            completion(true)
        } else {
            completion(false)
            debugPrint(response.result.error as Any)
        }
    }
}

/*
 Alamofire.request("https://httpbin.org/get")
 Alamofire.request("https://httpbin.org/get").responseJSON { response in
 print("Request: \(String(describing: response.request))")   // original url request
 print("Response: \(String(describing: response.response))") // http url response
 print("Result: \(response.result)")                         // response serialization result
 
 if let json = response.result.value {
 print("JSON: \(json)") // serialized json response
 }
 
 if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
 print("Data: \(utf8Text)") // original server data as UTF8 string
 }
 }
*/
