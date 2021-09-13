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
    @IBOutlet weak var taskView: UIView!
    
    public weak var delegate: TaskTableViewCellDelegate?
    public var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
        switch completeButton.isOn {
        case true:
            self.selected()
        case false:
            self.deselected()
        }
    }
    
    private func selected(){
        if let text = self.taskName.text {
            UIView.animate(withDuration: 0.5) {
                self.taskName.attributedText = String.makeSlashText(text)
                self.taskName.alpha = 0.5
            }
            self.delegate?.didSelect(taskTableViewCell: self, didSelect: true)
        }
    }
    
    private func deselected() {
        if let text = self.taskName.text {
            UIView.animate(withDuration: 0.5) {
                self.taskName.attributedText = NSMutableAttributedString(string: text)
                self.taskName.alpha = 1.0
            }
            self.delegate?.didDeselect(taskTableViewCell: self, didDeselect: true)
        }
    }
    
    private func setup() {
        self.completeButton.checkboxLine = CheckboxLineStyle(checkBoxHeight: self.frame.height * 0.2)
        self.completeButton.delegate = self
        self.taskName.adjustsFontSizeToFitWidth = true
        self.taskName.numberOfLines = 0
    }
    
    
}

extension TaskViewCell: CheckboxButtonDelegate {
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        self.selected()
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
        self.deselected()
    }
}
