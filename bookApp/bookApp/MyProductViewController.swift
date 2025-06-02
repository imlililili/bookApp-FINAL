//
//  MyProductViewController.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/23.
//

import UIKit

class MyProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mycommodities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProductCell", for: indexPath) as! MyProductTableViewCell
        let commodity = mycommodities[indexPath.row]
        cell.myProductImg.image = UIImage(named: commodity.ImageData!)
        cell.myProductTextField.text = commodity.CommodityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCommodity = mycommodities[indexPath.row]
        performSegue(withIdentifier: "gotoMyDetail", sender: self)
    }
  
    var userAp: AccountPassword?
    var allcommodities:[Item] = []
    var mycommodities:[Item] = []
    var selectCommodity:Item?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<allcommodities.count{
            if allcommodities[i].StudentId == userAp?.StudentId{
                mycommodities.append(allcommodities[i])
            }
        }
        print("\(mycommodities)")
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myProductDetailVC = segue.destination as? MyProductDetailViewController{
            myProductDetailVC.myItem = selectCommodity
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
