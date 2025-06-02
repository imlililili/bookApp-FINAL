//
//  NotifyViewController.swift
//  bookApp
//
//  Created by rtc08 on 2023/12/13.
//

import UIKit

class NotifyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifyDataProvider.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifyCell", for: indexPath) as! NotifyTableViewCell
        let msg = notifyDataProvider.messages[indexPath.row]
        cell.notifyLabel.text = msg
        cell.notifyImg.image = UIImage(named: "you")
        return cell
    }
    

    var notifyDataProvider = NotifyDataProvider()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        notifyDataProvider.loadData()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
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
