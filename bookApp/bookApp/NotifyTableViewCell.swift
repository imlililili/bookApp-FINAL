//
//  NotifyTableViewCell.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/24.
//

import UIKit

class NotifyTableViewCell: UITableViewCell {

    @IBOutlet weak var notifyLabel: UILabel!
    @IBOutlet weak var notifyImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
