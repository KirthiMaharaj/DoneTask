//
//  HomeTableViewCell.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/13.
//

import UIKit
import MBCheckboxButton

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var compButton: CheckboxButton!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configures(tasks: CategoryTask){
        if compButton.isOn {
            self.title.text = tasks.name
        }else{
            self.title.text = tasks.name
        }
        
    }

}
