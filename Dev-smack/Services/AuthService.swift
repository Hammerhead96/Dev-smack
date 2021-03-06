//
//  AuthService.swift
//  Dev-smack
//
//  Created by Mac User on 5/5/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [ "email": lowerCaseEmail, "password": password ]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON{ (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }   }   }
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [ "email": lowerCaseEmail, "password": password ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                // JSON parsing area
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                // end JSON parsing area
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }   }   }
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] =
            [ "name": name, "email": lowerCaseEmail, "avatarName": avatarName, "avatarColor": avatarColor ]
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }   }   }
    func findUserByEmail(completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }   }   }
    func setUserInfo(data: Data) {
        let json = try! JSON(data: data)
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
}

/*
******   JSON parsing
 // standard method
 if response.result.error == nil {
    if let json = response.result.value as? Dictionary<String, Any> {
        if let email = json["user"] as? String {
            self.userEmail = email
        }
        if let token = json["token"] as? String {
            self.authToken = token
        }
    }
 }
 // using SwiftyJSON
 guard let data = response.data else { return }
 let json = try! JSON(data: data)
 self.userEmail = json["user"].stringValue
 self.authToken = json["token"].stringValue
******
 see Channel and MessageService for a Swift 4 special parse
*/

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
