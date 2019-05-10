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
    var selectedChannel : Channel?
    var messages = [Message]()
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }   }   }
    func clearChannels() {
        channels.removeAll()
    }
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }   }
                print(self.messages)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }   }   }
    func clearMessages() {
        messages.removeAll()
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
