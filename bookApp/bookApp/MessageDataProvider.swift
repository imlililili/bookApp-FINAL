//
//  MessageDataProvider.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/23.
//

import UIKit

class MessageDataProvider: NSObject {
    var messages:[Message] = []
    func loadData(){
        messages = []
        let receiverMsg = Message(sender: "d0948405", body: "你好！可以用微積分跟你換計算機概論嗎？", receiver: "123")
        messages.append(receiverMsg)
        let senderMsg = Message(sender: "123", body: "不好意思！換書的話我會想要程式的", receiver: "d0948405")
        messages.append(senderMsg)
        let receiverYes = Message(sender: "d0948405", body: "我有！", receiver: "123")
        messages.append(receiverYes)
        let receiverEnd = Message(sender: "d0948405", body: "那這樣的話，星期一中午可以面交嗎？", receiver: "123")
        messages.append(receiverEnd)
    }
}
