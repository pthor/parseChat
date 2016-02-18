//
//  messageTableViewCell.swift
//  chat
//
//  Created by Paul Thormahlen on 2/17/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit

class messageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
