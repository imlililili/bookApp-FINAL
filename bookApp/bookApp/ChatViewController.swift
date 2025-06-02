//
//  ChatViewController.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/22.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        if message.sender == self.senderAp?.StudentId && message.receiver == self.receiverAp{ //判斷目前發送者是誰
            cell.label.text = messages.messages[indexPath.row].body
            cell.leftImageView.isHidden = true
            cell.leftView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.rightView.isHidden = false
            cell.label.textColor = .black
            cell.rightView.backgroundColor = .green
        }else if message.receiver == self.senderAp?.StudentId && message.sender == self.receiverAp{
            cell.leftLabel.text = messages.messages[indexPath.row].body
            cell.leftImageView.isHidden = false
            cell.leftView.isHidden = false
            cell.rightView.isHidden = true
            cell.rightImageView.isHidden = true
            cell.leftView.backgroundColor = .white
            cell.leftLabel.textColor = .black
         
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var ReceiverName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var senderAp: AccountPassword?
    var receiverAp: String?
    var messages = MessageDataProvider()
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.loadData()
        tableView.dataSource = self
        tableView.delegate = self
        title = self.receiverAp
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendPressed(_ sender: Any) {
        if let messageBody = messageTextField.text, let receiver = receiverAp{
            let newMessage = Message(sender: (senderAp?.StudentId)!, body: messageBody, receiver: receiver)
            loadMessages(msg: newMessage)
            self.messageTextField.text = ""// 送出後自動消掉原本
        }
    }
    
    func loadMessages(msg: Message){
//        db.collection(keys.FStore.collectionName)
//            .order(by: keys.FStore.dateField)//用order排序順序
//            .addSnapshotListener { (querySnapshot, error) in
//                self.messages = [] //因addSnapshotListener是即時收聽因此若陣列未清空會導致重複對話出現
//                if let e = error{
//                    print("get error \(e)")
//                }else{
//                    if let snapshotDocuments = querySnapshot?.documents{
//                        for doc in snapshotDocuments{
//                            let data = doc.data()
//                            if let messageSender = data[keys.FStore.senderField] as? String ,let messageBody = data[keys.FStore.bodyField] as? String{
//                                let newMessage = Message(sender: messageSender, body: messageBody, receiver: (self.receiverAp)!)
//                                self.messages.append(newMessage)
//                                DispatchQueue.main.async {
//                                    self.tableView.reloadData()
//                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true) //自動滑到最底層
//                                }
//                            }
//                            
//                        }
//                    }
//                }
//            }
        self.messages.messages.append(msg)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.messages.messages.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
