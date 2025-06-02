//
//  UploadPViewController.swift
//  bookApp
//
//  Created by rtc08 on 2023/12/13.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging
import FirebaseInAppMessaging
import FirebaseStorage
import UIKit
import UniformTypeIdentifiers

class UploadPViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate{
    
    var pickerView: UIPickerView!
    var ItemInput: Item?
    var userAp: AccountPassword?
    var types = [String]() // 商品種類的宣告
    var type = "" // 顯示在textField上的變數
    var num = Int.random(in: 1...16)
    var imageData: String = "" // 圖片名稱
    var photoArray: [String] = []
    @IBOutlet weak var CommodityName: UITextField!
    @IBOutlet weak var Category: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ItemCondition: UITextField!
    @IBOutlet weak var PaymentMethod: UITextField!
    
    var pickerField:UITextField!
    var stationDictionary = [String:[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ItemInput?.StudentId = self.userAp?.StudentId
        imageData = "dongdong\(num)" // 圖片為dongdong1~16
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) { // 登出?
        if let navigationController = self.navigationController{
            navigationController.popViewController(animated: true)
        } else{
            print("當前 ViewController 不在 UINavigationController 中")
        }
    }
    
    
    @IBAction func sendBtn(_ sender: Any) { // 送出上傳
        if CommodityName.text != "" && Category.text != "" && ItemCondition.text != "" && PaymentMethod.text != "" && imageData != ""{
            let url = URL(string: ItemUrl)
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let uploadItem = Item(CommodityName: CommodityName.text, Category: Category.text, ItemCondition: ItemCondition.text, PaymentMethod: PaymentMethod.text, StudentId: self.userAp?.StudentId, ImageData: self.imageData, Sold: "FALSE")
            print(uploadItem) // 上傳商品的資訊
            let UploadData = ItemUpload(data: [uploadItem])
            if let PostData = try? JSONEncoder().encode(UploadData){
                let task = URLSession.shared.uploadTask(with: request, from: PostData) { (returndata, response, error) in
                    if let returndata = returndata, let decodedreturn = try?  JSONDecoder().decode([String:Int].self, from: returndata){
                        if decodedreturn["created"] != nil{
                            print ("Successful!")
                            //                            self.saveFile()
                        }else{
                            print ("POSTFAILED!")
                        }
                    }
                }
                task.resume()
                let alertVC = UIAlertController(title: "上傳成功", message: "回到我的商品進行觀看", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil)
                alertVC.addAction(okButton)
                self.present(alertVC, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
            updateCommodities(item: uploadItem) // 更新主頁資訊
        }
        
    }
    
    func updateCommodities(item: Item){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        homeVC.commodities.append(item)
        let selfInfoVC = storyboard.instantiateViewController(withIdentifier: "SelfInfoVC") as! SelfInfoViewController
        selfInfoVC.allcommodities.append(item)
        self.navigationController?.popViewController(animated: true) // 返回前一頁
    }
    
    @IBAction func uploadCommodity(_ sender: Any) { // 上傳商品
        present(uploadFrom(), animated: true, completion: nil)
    }
    
    @objc func pageReturn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //    func saveFile(){
    //        let urls = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)
    //        let url = urls.first
    //        let paths = url?.appendingPathComponent("bookApp-2")
    //        let path = paths?.appendingPathComponent("bookApp")
    //        let app_path = path?.appendingPathComponent("images")
    //        let file:String = "\(imageData).png"
    //        let filename = (app_path?.appendingPathComponent(file))!
    //        print("filename: \(String(describing: filename))")
    //        try? pngData.write(to: filename)
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        //        取得路徑 link:https://www.hackingwithswift.com/example-code/media/how-to-save-a-uiimage-to-a-file-using-jpegdata-and-pngdata
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    func selectPhoto() {
        let controller = UIImagePickerController()
        
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    func getPhoto() {
        let controller = UIImagePickerController()
        
        controller.sourceType = .camera
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    func uploadFrom() -> UIAlertController {
        let controller = UIAlertController(
            title: "照片",
            message: "選擇照片來源",
            preferredStyle: .alert)
        let photoGallery = UIAlertAction(
            title:"照片圖庫", style: .default) {(_) in
                print("從照片圖庫選圖片")
                self.selectPhoto()
        }
        controller.addAction(photoGallery)
        let cameraGallery = UIAlertAction(
            title:"相機", style: .default) {(_) in
            print("從相機拍攝照片")
                self.getPhoto()
        }
        controller.addAction(cameraGallery)
        return controller
    }
    
}
