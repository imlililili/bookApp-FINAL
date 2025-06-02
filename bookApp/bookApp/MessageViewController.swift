//
//  MessageViewController.swift
//  bookApp
//
//  Created by rtc08 on 2023/12/12.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContantCell", for: indexPath) as! ContantTableViewCell
        let itemUser = itemUsers[indexPath.row]
        let num = Int.random(in: 1...16)
        let image = "dongdong\(num)"
        cell.contantImg.image = UIImage(named: image)
        cell.contantName.text = itemUser
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectContant = itemUsers[indexPath.row]
        performSegue(withIdentifier: "gotoMessage", sender: self)
    }
    
    var userAp: AccountPassword?
    var itemUsers:[String] = []
    var selectContant: String?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ChatVC = segue.destination as? ChatViewController {
            ChatVC.receiverAp = selectContant
            ChatVC.senderAp = self.userAp
        }
    }
}
