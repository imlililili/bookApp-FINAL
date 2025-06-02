//
//  StoreItemListTableViewController.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/24.
//

import UIKit

class StoreItemListTableViewController: UITableViewController {

    var selectCommodity: Item?
    var userAp: AccountPassword?
    var items:[Item] = []
    var filterItems:[Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        filterItems = items
        print("!!!\(items)!!!")
        print("\(filterItems)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = filterItems[indexPath.row]
        cell.itemImg.image = UIImage(named: item.ImageData!)
        cell.itemLabel.text = item.CommodityName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCommodity = filterItems[indexPath.row]
        performSegue(withIdentifier: "gotoCommodity", sender: self)
    }
    func search(_ searchTerm: String) {
        if searchTerm.isEmpty {
            filterItems = items
        } else {
            filterItems = items.filter {
                $0.CommodityName!.contains(searchTerm)
            }
        }
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let CommodityDetailVC = segue.destination as? CommodityDetailViewController {
            CommodityDetailVC.item = selectCommodity
            CommodityDetailVC.userAP = self.userAp
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StoreItemListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        search(searchTerm)
        searchBar.resignFirstResponder()
    }
}
