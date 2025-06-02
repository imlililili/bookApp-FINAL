//
//  HistoryTableViewCell.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var historyImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
