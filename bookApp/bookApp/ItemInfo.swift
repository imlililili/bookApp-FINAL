//
//  ItemInfo.swift
//  bookApp
//
//  Created by rtc09 on 2023/12/18.
//

import UIKit
import Foundation
import FirebaseFirestoreSwift

struct ItemUpload: Codable, Equatable{
    var data: [Item]
}

struct Item: Codable, Equatable{
    var CommodityName: String?
    var Category: String?
    var ItemCondition: String?
    var PaymentMethod: String?
    var StudentId: String?
    var ImageData: String?
    var Sold: String?
}

struct Post
{
    var postID: String
    var imageFileURL: String
    var timestamp: Int
}

let ItemUrl = "https://sheetdb.io/api/v1/oc98w0jvu3yno"
