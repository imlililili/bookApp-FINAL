//
//  NotifyDataProvider.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/24.
//

import UIKit

class NotifyDataProvider: NSObject {
    var messages:[String] = []
    func loadData(){
        let first = "d0948405向你傳送一則訊息"
        for i in 0..<5 {
            messages.append(first)
        }
    }
}
