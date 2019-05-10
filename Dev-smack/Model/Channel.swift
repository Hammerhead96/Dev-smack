//
//  Channel.swift
//  Dev-smack
//
//  Created by Mac User on 5/8/19.
//  Copyright © 2019 Hammerhead96. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var _id: String!
} // var name here need to match source

/*
 this is the orginal version
 struct Channel {
 public private(set) var channelTitle: String!
 public private(set) var channelDescription: String!
 public private(set) var id: String!
 }
*/
