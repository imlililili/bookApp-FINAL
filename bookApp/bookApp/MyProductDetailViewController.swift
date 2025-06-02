//
//  MyProductDetailViewController.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/23.
//

import UIKit

class MyProductDetailViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet weak var myPayment: UILabel!
    @IBOutlet weak var myCondition: UILabel!
    @IBOutlet weak var myType: UILabel!
    @IBOutlet weak var myName: UILabel!
    var myItem:Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let itemObj = myItem{
            myImg.image = UIImage(named: itemObj.ImageData!)
            myName.text = "商品: " + itemObj.CommodityName!
            myType.text = "種類: " + itemObj.Category!
            myCondition.text = "物品狀態: " + itemObj.ItemCondition!
            myPayment.text = "交易方式:  " + itemObj.PaymentMethod!
        }
        if myItem?.Sold == "TRUE" {
            myButton.isHidden = true //  已交易
            myPayment.text = "交易方式: 已售"
        }
    }
    
    @IBAction func soldBtn(_ sender: Any) {
        let item = Item(CommodityName: myItem?.CommodityName, Category: myItem?.Category, ItemCondition: myItem?.ItemCondition, PaymentMethod: "已售",StudentId: myItem?.StudentId, ImageData: myItem?.ImageData, Sold: "TRUE")
        let itemUpload = ItemUpload(data: [item])
        let URLStr = ItemUrl + "/CommodityName/\(item.CommodityName!)?"
        var UploadRequest = URLRequest(url: URL(string: URLStr)!)
        UploadRequest.httpMethod = "PUT"
        UploadRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let data = try? JSONEncoder().encode(itemUpload){
            let task = URLSession.shared.uploadTask(with: UploadRequest, from: data) { (returndata, response, error) in
                if let returndata = returndata, let decodedreturn = try?  JSONDecoder().decode([String:Int].self, from: returndata){
                    print(decodedreturn)
                    if decodedreturn["updated"] != nil{
                        print ("Successful!")
                    }else{
                        print ("POSTFAILED!")
                    }
                }            }
            task.resume()
        }
        updateCell(item:item)
        self.navigationController?.popViewController(animated: true) // 返回前一頁
    }
    func updateCell(item: Item){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selfInfoVC = storyboard.instantiateViewController(withIdentifier: "SelfInfoVC") as! SelfInfoViewController
        for i in 0..<selfInfoVC.allcommodities.count{
            if selfInfoVC.allcommodities[i].CommodityName == item.CommodityName && selfInfoVC.allcommodities[i].Category == item.Category && selfInfoVC.allcommodities[i].ItemCondition == item.ItemCondition && selfInfoVC.allcommodities[i].StudentId == item.StudentId{
                selfInfoVC.allcommodities[i].PaymentMethod = item.PaymentMethod
                selfInfoVC.allcommodities[i].Sold = "TRUE"
                break
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
