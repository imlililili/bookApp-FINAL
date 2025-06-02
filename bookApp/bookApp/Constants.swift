//
//  Constants.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/19.
//

import Foundation

struct keys {
   static let registerSegue = "RegisterToChart"
    static let loginSegue = "LoginTochart"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let receiverField = "receiver"
    }
}
