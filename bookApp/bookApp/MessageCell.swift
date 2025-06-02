//
//  MessageCell.swift
//  charting
//
//  Created by Leo on 2021/1/27.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rightImageView.layer.cornerRadius = 30
        leftImageView.layer.cornerRadius = 30
        rightView.clipsToBounds = true
        rightView.layer.cornerRadius = label.frame.width / 3
        leftView.clipsToBounds = true
        leftView.layer.cornerRadius = leftLabel.frame.width / 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
        
}
