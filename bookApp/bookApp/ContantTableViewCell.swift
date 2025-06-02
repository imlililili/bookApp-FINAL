//
//  ContantTableViewCell.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/22.
//

import UIKit

class ContantTableViewCell: UITableViewCell {

    @IBOutlet weak var contantImg: UIImageView!
    @IBOutlet weak var contantName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
