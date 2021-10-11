//
//  HomeTaskTableViewCell.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/06.
//

import UIKit
import MBCheckboxButton

class HomeTaskTableViewCell: UITableViewCell {

   
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var complButton: CheckboxButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
