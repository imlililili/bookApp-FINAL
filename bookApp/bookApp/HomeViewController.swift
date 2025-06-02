//
//  HomeViewController.swift
//  bookApp
//
//  Created by rtc09 on 2023/12/5.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commodities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommodityCell", for: indexPath) as! CommodityTableViewCell
        let commodity = commodities[indexPath.row]
        cell.commodityImg.image = UIImage(named: commodity.ImageData!)
        cell.commodityLabel.text = commodity.CommodityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCommodity = commodities[indexPath.row]
        performSegue(withIdentifier: "gotoDetail", sender: self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    var userAP: AccountPassword?
    var commodities:[Item] = []
//    var commodityDataProvider = CommodityDataProvider()
    var selectCommodity: Item?
    var refreshControl:UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(userAP!)
        refreshControl = UIRefreshControl()
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @objc func refreshData(){
        tableView.reloadData()
        let indexPath = IndexPath(row: self.commodities.count-1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let CommodityDetailVC = segue.destination as? CommodityDetailViewController {
            CommodityDetailVC.item = selectCommodity
            CommodityDetailVC.userAP = self.userAP
        } else {
            let button = sender as! UIButton
    //        get button's restoration id
    //        print(button)
            let page = button.restorationIdentifier
            if page == "SelfInfoBtn" {
                let controller = segue.destination as! SelfInfoViewController
                controller.userAp = self.userAP
                controller.allcommodities = self.commodities
            } else if page == "MessageBtn" {
                let controller = segue.destination as! MessageViewController
                controller.userAp = self.userAP
//                unique the user
                var set = Set<String>()
                for i in 0..<self.commodities.count{
//                    排除使用者
                    if self.commodities[i].StudentId != userAP?.StudentId{
                        set.insert(self.commodities[i].StudentId!)
                    }
                }
//                set 轉 array
                let itemUsers = [String](set)
                controller.itemUsers = itemUsers
            } else if page == "SearchBtn" {
                let controller = segue.destination as! StoreItemListTableViewController
                controller.userAp = self.userAP
                controller.items = self.commodities
            }
        }
    }

    @IBAction func logoutBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
