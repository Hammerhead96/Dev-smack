//
//  MessageService.swift
//  Dev-smack
//
//  Created by Mac User on 5/8/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MessageService {
    static let instance = MessageService()
    var channels = [Channel]()
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                print("\(data)")
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                print(self.channels)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
/*
 this is what was originally shown but never tested
 if let json = try! JSON(data: data).array {
 for item in json {
 print("we in the for item in json of messenger service")
 let name = item["name"].stringValue
 let channelDescription = item["description"].stringValue
 let id = item["_id"].stringValue
 let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
 self.channels.append(channel)
 }
 print(self.channels)
 }
 */
