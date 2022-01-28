//
//  TaskColorTableViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/25.
//

import UIKit

class TaskColorTableViewController: UITableViewController {

    @IBOutlet weak var colorView: UIView!
    
    var color = "Default"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorView.layer.cornerRadius = 20.0
        self.colorView.layer.cornerCurve = .continuous
        colorView.layer.masksToBounds = true
    }
    
    @IBAction func defaultColor(_ sender: Any) {
        color = "Default"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    
    @IBAction func greenColor(_ sender: Any) {
        color = "Green"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    
    @IBAction func yellowColor(_ sender: Any) {
        color = "Yellow"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    
    @IBAction func blueColor(_ sender: Any) {
        color = "Blue"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
        
    }
    
    @IBAction func darkblueColor(_ sender: Any) {
        color = "DarkBlue"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    
    @IBAction func purpleColor(_ sender: Any) {
        color = "Purple"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    
    @IBAction func orangeColor(_ sender: Any) {
        color = "Orange"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    
    @IBAction func pinkColor(_ sender: Any) {
        color = "Pink"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
