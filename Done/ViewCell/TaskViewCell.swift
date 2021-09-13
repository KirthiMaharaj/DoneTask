//
//  TaskViewCell.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/07.
//

import UIKit
import MBCheckboxButton

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var completeButton: CheckboxButton!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var priortyButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public var taskNames: String? {
        get {
            return self.taskDate.text
        }
        set {
            self.taskDate.attributedText = nil
            self.taskDate.text = newValue
        }
    }
    
    @IBAction func completeBtnTapped(_ sender: Any) {
        
    }
}
