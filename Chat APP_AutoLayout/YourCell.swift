//
//  YourCell.swift
//  Chat APP_AutoLayout
//
//  Created by 박균호 on 2020/03/05.
//  Copyright © 2020 박균호. All rights reserved.
//

import UIKit

class YourCell: UITableViewCell {

    @IBOutlet weak var yourCellTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
