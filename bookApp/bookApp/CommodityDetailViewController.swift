//
//  CommodityDetailViewController.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/19.
//

import UIKit

class CommodityDetailViewController: UIViewController {

    @IBOutlet weak var itemOwner: UILabel!
    @IBOutlet weak var itemPayment: UILabel!
    @IBOutlet weak var itemCondition: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var itemImg: UIImageView!
    var item: Item?
    var userAP: AccountPassword?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("!!!")
        print("\(item)")
        if let itemObj = item {
            itemOwner.text = "賣家:"+itemObj.StudentId!
            itemPayment.text = "交易方式:"+itemObj.PaymentMethod!
            itemCondition.text = "商品狀況:"+itemObj.ItemCondition!
            itemCategory.text = "種類:"+itemObj.Category!
            itemName.text = "商品:"+itemObj.CommodityName!
            itemImg.image = UIImage(named: itemObj.ImageData!)
        }
        print("!!!!\(String(describing: itemPayment.text))")
        if item?.StudentId == userAP?.StudentId{
            messageBtn.isHidden = true // 隱藏自己的聊聊按鈕去規避與自己聊天
        } else if item?.Sold == "TRUE" {
            messageBtn.isHidden = true
        }
        // Do any additional setup after loading the view.
        messageBtn.addTarget(self, action: #selector(chatBtn), for: .touchUpInside)
    }
    
    @IBAction func chatBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let chatVC = storyboard.instantiateViewController(withIdentifier: "ChatVC") as! ChatViewController
        chatVC.senderAp = self.userAP
        chatVC.receiverAp = self.item?.StudentId
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
