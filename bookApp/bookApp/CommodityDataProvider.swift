//
//  CommodityDataProvider.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/19.
//

import UIKit

class CommodityDataProvider: NSObject {
    var commodities:[Item] = []
    var itemInput:[Item] = []
    func getDB(){
        let url = URL(string: ItemUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { (Data, response, error) in
            
            if let error = error { // 這個別碰，因為我不知道怎麼破:(
                print("Error: \(error)")
                print("Task failed")
            } else if let data = Data{
                do {
                    let decodeData = try decoder.decode([Item].self, from: data)
                    print("Get succeed")
                    print(decodeData)
                    print(type(of: decodeData))
                    
                    DispatchQueue.main.sync {
                        if decodeData == [] {
                            print("NO ITEM")
                        } else {
                            var count = (decodeData.count)
                            count = count - 1
                            self.itemInput = []
                            for i in 0...count{
                                self.itemInput.append(decodeData[i])
                            }
                        }
                        
                    }
                } catch let decodingError {
                    print("JSON decoding failed with error: \(decodingError)")
                    print("Task failed")
                }
            } else { // 這個別碰，因為我不知道怎麼破:(
                print("Task failed")
            }
        }

        task.resume()
    }
    func loadData(){
        commodities = []
        for i in stride(from:0, to: itemInput.count, by:1){
            commodities.append(itemInput[i])
        }
    }
}
