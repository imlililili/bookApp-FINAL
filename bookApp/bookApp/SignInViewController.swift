//
//  SignInViewController.swift
//  bookApp
//
//  Created by rtc09 on 2023/12/5.
//

import UIKit



class SignInViewController: UIViewController, UITextFieldDelegate {
    static let shared = HomeViewController()
    public var APInput = AccountPassword( StudentId: "", Nickname: "", Password: "", Email: "", Login_Status: "FALSE")
    var currentTextField: UITextField! //宣告編輯框
    @IBOutlet weak var sid: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var email: UITextField!

    @objc func keyboardShown(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        //取得鍵盤尺寸
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //鍵盤頂部 Y軸的位置
        let keyboardY = self.view.frame.height - keyboardSize.height
        //編輯框底部 Y軸的位置
        let editingTextFieldY = currentTextField.convert(currentTextField.bounds, to: self.view).maxY
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
        sid.delegate = self
        password.delegate = self
        nickname.delegate = self
        email.delegate = self
        
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
        currentTextField = textField
    } //編輯時, 儲存實體
    

    @IBAction func cancelBtn(_ sender: Any) {
//        資料清空的回到登入介面
        sid.text = ""
        password.text = ""
        nickname.text = ""
        email.text = ""
        APInput = AccountPassword( StudentId: "", Nickname: "", Password: "", Email: "", Login_Status: "")
//        self.dismiss(animated: true)
        if let navigationController = self.navigationController{
            navigationController.popViewController(animated: true)
        } else{
            print("當前 ViewController 不在 UINavigationController 中")
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
    func createAccount(account: AccountPassword) {
//        createAlert(title: "註冊成功！", message: "歡迎！", actiontitle: "OK!") { [self]/* (UIAlertAction) in*/
            let url = URL(string: APIUrlStr)
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            self.APInput.Login_Status = "FALSE"
            let UploadData = AccPasUpload(data: [self.APInput])
            if let PostData = try? JSONEncoder().encode(UploadData){
                let task = URLSession.shared.uploadTask(with: request, from: PostData) { (returndata, response, error) in
                    if let returndata = returndata, let decodedreturn = try?  JSONDecoder().decode([String:Int].self, from: returndata){
                        if decodedreturn["created"] != nil{
                            print ("Successful!")
                        }else{
                            print ("POSTFAILED!")
                        }
                    }
                }
                task.resume()
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
//                homeVC.modalPresentationStyle = .fullScreen
//                self.present(homeVC, animated: true)
                let alertVC = UIAlertController(title: "註冊成功", message: "回到登入介面登入", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil)
                alertVC.addAction(okButton)
                self.present(alertVC, animated: true, completion: nil)
//            }
        }
//        self.delegate?.update(Info: self.APInput)
//        self.navigationController?.popViewController(animated: true)
    }
    func checkAccount(account: AccountPassword) {
        let APIURL = APIUrlStr + "/search?StudentId=\(account.StudentId!)"
        var urlRequest = URLRequest(url: URL(string: APIURL)!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: urlRequest) { [self] (Data, response, error) in
            
            if let error = error { // 這個別碰，因為我不知道怎麼破:(
                print("Error: \(error)")
                print("Task failed")
            } else if let data = Data{
                do {
                    let decodeData = try decoder.decode([AccountPassword].self, from: data)
                    print("Get succeed")
                    print(decodeData)
                    print(type(of: decodeData))
                    
                    DispatchQueue.main.sync {
                        if decodeData == [] {
                            print("NO ACCOUNT")
                            createAccount(account: account)
                            
                        } else {
                            print("ALREADY INSIDE")
                            let alertVC = UIAlertController(title: "錯誤", message: "帳號已使用，請使用其他", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil)
                            alertVC.addAction(okButton)
                            self.present(alertVC, animated: true, completion: nil)
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
    
    @IBAction func registerBtn(_ sender: Any) {
        APInput.StudentId = sid.text
        APInput.Password = password.text
        APInput.Nickname = nickname.text
        APInput.Email = email.text
        if APInput.StudentId != "" && APInput.Password != "" && APInput.Nickname != "" && APInput.Email != "" { // 四格輸入框都填完，尚未判斷是否重複以及回到主頁後可以成功登入
            checkAccount(account: APInput) // 確認帳號是否存在
            
//            self.delegate?.update(Info: self.APInput)
//            self.navigationController?.popViewController(animated: true)
        } else { // 輸入框有空值
            let alertVC = UIAlertController(title: "錯誤", message: "請將空格填完", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler: nil)
            alertVC.addAction(okButton)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    func createAlert(title: String, message: String, actiontitle: String, action: @escaping ((UIAlertAction) -> Void) ){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actiontitle, style: .default, handler: action)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
}
