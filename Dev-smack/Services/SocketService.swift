//
//  SocketService.swift
//  Dev-smack
//
//  Created by Mac User on 5/8/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    override init() {
        super.init()
    }
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    lazy var socket: SocketIOClient = manager.defaultSocket
    func establishConnection() {
        socket.connect()
    }
    func closeConnection() {
        socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            print("\(channelName) - \(channelDesc) - \(channelId)")
            let newChannel = Channel(name: channelName, description: channelDesc, _id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }   }
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
}
