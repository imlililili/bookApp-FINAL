//
//  MyProductTableViewCell.swift
//  bookApp
//
//  Created by Yu Lu on 2023/12/23.
//

import UIKit

class MyProductTableViewCell: UITableViewCell {

    @IBOutlet weak var myProductTextField: UILabel!
    @IBOutlet weak var myProductImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
