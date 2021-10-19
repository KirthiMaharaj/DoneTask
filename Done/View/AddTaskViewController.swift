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


class AddTaskViewController: UIViewController{
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var dateTaskPicker: UIDatePicker!
    @IBOutlet weak var priortyButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var reminder: UISwitch!
    @IBOutlet weak var reminderDate: UIDatePicker!
    
    var dataProvider = TaskManager()
    private var selectedPriority: Priority!
    var isUpdate: Bool = false
    var tasks : DoneTask?
    //var taskCategory: String?
    var taskCategory: Subtask?
    weak var delegate : TaskDelegate?
//    private var updateNotification = false
//    private var removeNotification = false
    private var taskksID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupButtons()
        isUpdate = (tasks != nil)
        dateTaskPicker.minimumDate = Date()
        editTasks()
    }
    
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
        if let taskDes = taskDescription.text, let taskName = taskTitle.text {
            
            let task = DoneTask(reminderDate.date, taskDes ,dateTaskPicker.date, self.taskksID ?? "id",false, taskName, Int(self.selectedPriority.rawValue), false, taskCategory!)
            //print("This is your category: \(taskCategory ?? "None received")")
           /* self.dataProvider.createTasks(task) { success in
                if success {
                    print("new Task Add")
                    self.dismiss(animated: true, completion: nil)
                   
                }
                else
                {
                    print(success)
                }
            }*/
            scheduleNotificationFor(task: task)
            createTasks(task)
            self.dataProvider.fetchTasks()
            self.dismiss(animated: true, completion: nil)
            
           /* if isUpdate {
                self.delegate?.didTapUpdate(task: task)
                print("new Task update")
            } else {
              
                self.delegate?.didTapSave(task: task)
                print("new Task Save")
            }*/
            
            
          //  self.dataProvider.fetchTasks()
            //self.dismiss(animated: true, completion: nil)
            //print("Did not add")
        }
    }
    
    
    func createTasks(_ task: DoneTask) {
        let newTask = Tasks(context: dataProvider.managedObjectContext)
        newTask.dates = task.date
        newTask.descriptions = task.descriptions
        newTask.dueDate = task.dueDate
        newTask.id = task.taskIds
        newTask.isComplete = task.isComplete
        newTask.name = task.name
        newTask.priorty = task.priorty
        newTask.notification = task.notification
        newTask.parentProject = task.category
        
        //print("This is your Category \(task.category)")
        do {
            try dataProvider.managedObjectContext.save()
        } catch {
            fatalError("Could not save context: \(error)")
        }
    }
    
    func editTasks() {
        
        guard let tasks = self.tasks else { return }
        reminderDate.date = tasks.date
        taskDescription.text = tasks.descriptions
        taskTitle.text = tasks.name
        dateTaskPicker.date = tasks.dueDate
        let priorityColor = Priority(rawValue: Int(tasks.priorty))
        self.priortyButton.setTitleColor(priorityColor?.color, for: .normal)
        self.priortyButton.setTitle(priorityColor?.text, for: .normal)
        dataProvider.saveTasks()
        dataProvider.fetchTasks()

    }
    
    @IBAction func reminderToggle(_ sender: UISwitch) {
        if sender.isOn == true {
            reminderDate.isHidden = false
            tasks?.notification = true
        }else{
            reminderDate.isHidden = true
            tasks?.notification = false
        }
    }
    
    @IBAction func reminderDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-mm-dd hh:mm"
        
        reminderButton.setTitle(dateFormatter.string(from: sender.date), for: .normal)
        tasks?.date = sender.date
        
    }
    
  
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func scheduleNotification(id: String) {
        if tasks?.notification ?? false  && tasks?.date ?? Date() > Date(){
            print("Scheduling Notification")
            let content = UNMutableNotificationContent()
            content.title = "You've a task in pending."
            content.body = taskTitle.text!
            content.sound = UNNotificationSound.default
            let calender = Calendar(identifier: .gregorian)
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute], from: dataProvider.dates )
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "task-\(id)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("added")
        }
    }
    
    
    private func check() {
        if self.taskTitle.text?.isEmpty ?? true {
            self.saveButton.isEnabled = false
        } else {
            self.saveButton.isEnabled = true
        }
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
    
    public func addRequiredData(model: TaskManager) {
        self.dataProvider = model
    }
    
    
    private func setupButtons() {
        priortyButton.layer.cornerRadius = 10
        priortyButton.backgroundColor = UIColor.clear
        priortyButton.layer.borderWidth = 2
        priortyButton.layer.borderColor = UIColor.darkGray.cgColor
        
        reminderButton.layer.cornerRadius = 10
        reminderButton.backgroundColor = UIColor.clear
        reminderButton.layer.borderWidth = 2
        reminderButton.layer.borderColor = UIColor.darkGray.cgColor
        reminderButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func scheduleNotificationFor(task: DoneTask) {
        guard let taskIDString = task.taskIds else {
            fatalError()
        }

        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = task.name
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: taskIDString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
}



