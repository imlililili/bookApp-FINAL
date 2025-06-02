//
//  CommodityTableViewCell.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/19.
//

import UIKit

class CommodityTableViewCell: UITableViewCell {

    @IBOutlet weak var commodityImg: UIImageView!
    @IBOutlet weak var commodityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
