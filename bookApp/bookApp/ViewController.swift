//
//  ViewController.swift
//  bookApp
//
//  Created by rtc09 on 2023/12/5.
//

import UIKit
import Firebase


class ViewController: UIViewController, UITextFieldDelegate {

    public var APInput = AccountPassword(StudentId: "", Nickname: "", Password: "",Email: "", Login_Status: "FALSE")
    var activeTextField: UITextField! //宣告編輯框
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var sid: UITextField!
    var commodityDataProvider = CommodityDataProvider()
    @objc func keyboardShown(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        //取得鍵盤尺寸
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //鍵盤頂部 Y軸的位置
        let keyboardY = self.view.frame.height - keyboardSize.height
        //編輯框底部 Y軸的位置
        let editingTextFieldY = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
        //相減得知, 編輯框有無被鍵盤擋住, > 0 有擋住, < 0 沒擋住, 即是擋住多少
        let targetY = editingTextFieldY - keyboardY
        
        //設置想要多移動的高度
        let offsetY: CGFloat = 20

        if self.view.frame.minY >= 0 {
            if targetY > 0 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.frame = CGRect(x: 0, y:  -targetY - offsetY, width: self.view.bounds.width, height: self.view.bounds.height)
                })
            }
        }
    }
    
    @objc func keyboardHidden(notification: Notification) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        sid.delegate = self
        //監聽 鍵盤顯示與隱藏
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    } //編輯時, 儲存實體

//    @objc func pageJump() {
////        into homePage
//        let homeDestinationVC = HomeViewController()
//        homeDestinationVC.userAP = APInput
//        self.present(homeDestinationVC, animated: true, completion: nil)
//    }
    
    @IBAction func signinBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC")
        signInVC.modalPresentationStyle = .fullScreen
//        self.present(signInVC, animated: true)
        //        self.present(signInVC, animated: true)
        if let navigationController = self.navigationController{
            navigationController.pushViewController(signInVC, animated: true)
        } else{
            print("當前 ViewController 不在 UINavigationController 中")
        }

    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if let studentId = sid?.text {
            APInput.StudentId = studentId
            APInput.Password = password.text
            let APIURL = APIUrlStr + "/search?StudentId=\(sid.text!)"
            var urlRequest = URLRequest(url: URL(string: APIURL)!)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let decoder = JSONDecoder()
            let task = URLSession.shared.dataTask(with: urlRequest) { (Data, response, error) in
                
                if let error = error { // 這個別碰，因為我不知道怎麼破:(
                    print("Error: \(error)")
                    print("Task failed")
                } else if let data = Data{
                    do {
                        var decodeData = try decoder.decode([AccountPassword].self, from: data)
                        print("Get succeed")
                        print(decodeData)
                        print(type(of: decodeData))
                        
                        DispatchQueue.main.sync {
                            if decodeData == [] {
                                print("NO ACCOUNT")
                                let alertVC = UIAlertController(title: "錯誤", message: "帳號或密碼有誤，請再輸入一次", preferredStyle: UIAlertController.Style.alert)
                                let okButton = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil)
                                alertVC.addAction(okButton)
                                self.present(alertVC, animated: true, completion: nil)
                            } else if decodeData[0].Password != self.APInput.Password {
                                print("WRONG PASSWORD")
                                let alertVC = UIAlertController(title: "錯誤", message: "帳號或密碼有誤，請再輸入一次", preferredStyle: UIAlertController.Style.alert)
                                let okButton = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil)
                                alertVC.addAction(okButton)
                                self.present(alertVC, animated: true, completion: nil)
                            } else if decodeData[0].StudentId == self.APInput.StudentId && decodeData[0].Password == self.APInput.Password {
                                print("succeed")
                                // 傳帳號資訊到個人介面
                                self.APInput.Email = decodeData[0].Email
                                self.APInput.Nickname = decodeData[0].Nickname
                                self.APInput.StudentId = decodeData[0].StudentId
                                let serialQueue = DispatchQueue(label: "")
                                serialQueue.sync {
                                    self.commodityDataProvider.getDB()
                                }
                                serialQueue.sync {
                                    self.commodityDataProvider.loadData()
                                }
                                serialQueue.sync {
//                                    清空欄位上的資料 
                                    self.sid.text = ""
                                    self.password.text = ""
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                                    homeVC.userAP = self.APInput
                                    for i in 0..<self.commodityDataProvider.commodities.count{
                                        homeVC.commodities.append(self.commodityDataProvider.commodities[i])
                                    }
                                    homeVC.modalPresentationStyle = .fullScreen
//                                    self.present(homeVC, animated: true)
                                    if let navigationController = self.navigationController{
                                        navigationController.pushViewController(homeVC, animated: true)
                                    } else{
                                        print("當前 ViewController 不在 UINavigationController 中")
                                    }
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

        } else {
            // 如果 sid 為 nil，可能需要採取相應的處理方法
            print("Student ID is nil.")
        }
    }
    func createAlert(title: String, message: String, actiontitle: String, action: @escaping ((UIAlertAction) -> Void) ){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actiontitle, style: .default, handler: action)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
}

