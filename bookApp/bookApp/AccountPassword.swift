//
//  AccountPassword.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/16.
//

import Foundation
import UIKit

struct AccPasUpload: Codable, Equatable{
    var data: [AccountPassword]
}


struct RecieveMessage: Decodable {
    var created: Int?
}

struct AccountPassword: Codable, Equatable{
    var StudentId: String?
    var Nickname: String?
    var Password: String?
    var Email: String?
    var Login_Status: String?
}


extension String{
    var bool : Bool? {
        if self == "TRUE"{
            return true
        }else if self == "FALSE"{
            return false
        }else {
            return nil
        }
    }
}

let APIUrlStr = "https://sheetdb.io/api/v1/3vq0e7vdolyhk"
