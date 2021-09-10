//
//  ViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/07.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var dateTask: UITextField!
    @IBOutlet weak var priortyTask: UITextField!
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var priortyButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var taskDescription: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var dataProvider = TaskModel(completionClosure: {})
    private var taskName: String?
    private var taskDes: String?
    var tasked: [DoneTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        let task = DoneTask(self.taskDes ?? "", false, false, self.taskName ?? "")
        
        
        self.dataProvider.createTasks(task) { success in
            if success {
                self.dismiss(animated: true)
            }
            
        }
        self.dataProvider.saveTasks()
        self.dataProvider.fetchTasks { tas in
            self.tasked = tas
        }
        
    }
    private func check() {
        if self.taskTitle.text?.isEmpty ?? true {
            self.saveButton.isEnabled = false
        } else {
            self.saveButton.isEnabled = true
        }
    }
    @IBAction func colorPickerTapped(_ sender: Any) {
    }
    @IBAction func reminderTapped(_ sender: Any) {
    }
    
    @IBAction func priortyTapped(_ sender: Any) {
    }
    
    @IBAction func nameEditTextField(_ sender: UITextField) {
        self.check()
        self.taskName = sender.text
        
    }
    
    public func addRequiredData(model: TaskModel) {
        self.dataProvider = model
    }
    
    
}

