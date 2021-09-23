//
//  ViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/07.
//

import UIKit
import LKAlertController


protocol TaskDelegate: AnyObject {
    func didTapSave(task : DoneTask)
    func didTapUpdate(task : DoneTask)
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var dateTaskPicker: UIDatePicker!
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var priortyButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var dataProvider = TaskModel(completionClosure: {})
    private var selectedPriority: Priority!
    weak var delegate : TaskDelegate?
    var isUpdate: Bool = false
    var tasks : DoneTask? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        isUpdate = (tasks != nil)
        editTasks()
    }
    
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
        
        if let taskDes = taskDescription.text, let taskName = taskTitle.text {
            let task = DoneTask(taskDes, dateTaskPicker.date, false, taskName, Int(self.selectedPriority.rawValue))
            
            self.dataProvider.createTasks(task) { success in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            if isUpdate {
                self.delegate?.didTapUpdate(task: task)
            } else {
                self.delegate?.didTapSave(task: task)
            }
            self.dataProvider.fetchTasks()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func editTasks() {
        
        guard let tasks = self.tasks else { return }
        
        taskDescription.text = tasks.descriptions
        taskTitle.text = tasks.name
        dateTaskPicker.date = tasks.dueDate
        let priorityColor = Priority(rawValue: Int(tasks.priorty))
        self.priortyButton.setTitleColor(priorityColor?.color, for: .normal)
        self.priortyButton.setTitle(priorityColor?.text, for: .normal)
//        self.dataProvider.saveTasks()
//        self.dataProvider.fetchTasks()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
        let sheet = ActionSheet(title: "PRIORITY".localized(), message: nil)
        sheet.setPresentingSource(self.priortyButton)
        
        sheet.addAction(Priority.High.text, style: .default) { action in
            self.selectedPriority = .High
            self.priortyButton.setTitleColor(self.selectedPriority.color, for: .normal)
            self.priortyButton.setTitle(action?.title, for: .normal)
        }
        sheet.addAction(Priority.Normal.text, style: .default) { action in
            self.selectedPriority = .Normal
            self.priortyButton.setTitleColor(self.selectedPriority.color, for: .normal)
            self.priortyButton.setTitle(action?.title, for: .normal)
        }
        sheet.addAction(Priority.Low.text, style: .default) { action in
            self.selectedPriority = .Low
            self.priortyButton.setTitleColor(self.selectedPriority.color, for: .normal)
            self.priortyButton.setTitle(action?.title, for: .normal)
        }
        sheet.addAction(Priority.None.text, style: .default) { (action) in
            self.selectedPriority = .None
            self.priortyButton.setTitle(action?.title, for: .normal)
        }
        sheet.addAction("CANCEL".localized(), style: .cancel)
        sheet.presentIn(self)
        sheet.show(animated: true)
    }
    
    
    @IBAction func nameEditTextField(_ sender: UITextField) {
        self.check()
    }
    
    public func addRequiredData(model: TaskModel) {
        self.dataProvider = model
    }
    
    
}




