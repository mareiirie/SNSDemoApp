//
//  FirebaseModel.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/09.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    let content: String
    let postID: String
    let senderID: String
    let createdAt: Timestamp
    let updatedAt: Timestamp

    init(data: [String: Any]) {
        content = data["content"] as! String
        postID = data["postID"] as! String
        senderID = data["senderID"] as! String
        createdAt = data["createdAt"] as! Timestamp
        updatedAt = data["updatedAt"] as! Timestamp
    }
}
