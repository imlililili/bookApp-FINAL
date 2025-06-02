//
//  SelfInfoViewController.swift
//  bookApp
//
//  Created by rtc09 on 2023/12/5.
//

import UIKit

class SelfInfoViewController: UIViewController{
    

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userID: UILabel!
    var userAp: AccountPassword?
    var allcommodities:[Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(allcommodities)")
        userEmail.text = userAp?.Email
        userID.text = userAp?.StudentId
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadCommodityBtn(_ sender: Any) {
//        傳送個人資訊到上傳商品，取studentID
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let uploadPVC = storyboard.instantiateViewController(withIdentifier: "UploadPVC") as! UploadPViewController
        uploadPVC.userAp = self.userAp
        uploadPVC.modalPresentationStyle = .fullScreen
//        if let navigationController = self.navigationController{
//            navigationController.pushViewController(uploadPVC, animated: true)
//        } else{
//            print("當前 ViewController 不在 UINavigationController 中")
//        }
    }
    @objc func pageReturn() {
        self.navigationController?.popViewController(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = sender as! UIButton
//        get button's restoration id
        let page = button.restorationIdentifier
        if page == "UploadPBtn" {
            let controller = segue.destination as! UploadPViewController
            controller.userAp = self.userAp
        } else if page == "MyProductBtn" {
            let controller = segue.destination as! MyProductViewController
            controller.userAp = self.userAp
            controller.allcommodities = self.allcommodities
        } else if page == "HistoryBtn" {
            let controller = segue.destination as! TransactionsViewController
            controller.userAp = self.userAp
            controller.allcommodities = self.allcommodities
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
