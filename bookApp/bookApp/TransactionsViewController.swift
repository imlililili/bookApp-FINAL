//
//  TransactionsViewController.swift
//  bookApp
//
//  Created by rtc08 on 2023/12/12.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soldCommodities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
        let commodity = soldCommodities[indexPath.row]
        cell.historyImg.image = UIImage(named: commodity.ImageData!)
        cell.historyLabel.text = commodity.CommodityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    var userAp: AccountPassword?
    var allcommodities:[Item] = []
    var soldCommodities:[Item] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<allcommodities.count{
            if allcommodities[i].StudentId == userAp?.StudentId && allcommodities[i].Sold == "TRUE"{
                soldCommodities.append(allcommodities[i])
            }
        }
        print("!!!")
        print("\(soldCommodities)")
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

