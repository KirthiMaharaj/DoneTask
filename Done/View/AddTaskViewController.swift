//
//  ViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/07.
//

import UIKit
import LKAlertController

protocol TaskDelegate: AnyObject {
    func didTapSave(task : Tasks)
    func didTapUpdate(task : Tasks)
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
    
    private var dateComponents: DateComponents!
    var dataProvider = TaskModel(completionClosure: {})
    private var selectedPriority: Priority!
  //  var isUpdate: Bool = false
    var tasks : Tasks?
    weak var delegate : TaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupButtons()
      //  isUpdate = (tasks != nil)
        dateTaskPicker.minimumDate = Date()
        editTasks()
    }
    
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
       
        if tasks != nil {

            reminderDate.date = tasks?.dates ?? Date()
            taskDescription.text = tasks?.descriptions
            dateTaskPicker.date = tasks?.dueDate ?? Date()
            tasks?.isComplete = false
            taskTitle.text = tasks?.name
            //dataProvider.scheduleNotificationFor(task: tasks!)
            scheduleNotification(id: tasks?.id ?? "")
            tasks?.parentProject = dataProvider.parentObject
            tasks?.parentProject?.taskCount += 1
            dataProvider.saveTasks()
            
        } else{
            createTasks()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func editTasks() {
       
        if tasks != nil {
            reminderDate.date = tasks?.dates ?? Date()
            taskDescription.text = tasks?.descriptions
            dateTaskPicker.date = tasks?.dueDate ?? Date()
            taskTitle.text = tasks?.name
          //  reminder.isOn = ((tasks?.notification) != nil)
        }

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
        tasks?.dates = sender.date
        
    }
    
    func  createTasks() {
        let task = Tasks(context: dataProvider.managedObjectContext)
        task.dates = reminderDate.date
        task.descriptions =  taskDescription.text
        task.dueDate = dateTaskPicker.date
        task.isComplete = false
        task.name = taskTitle.text
        task.notification = false
        scheduleNotification(id:task.id ?? "")
        task.priorty = Int16(Int(self.selectedPriority.rawValue))
        task.parentProject = dataProvider.parentObject
        self.dataProvider.saveTasks()
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func scheduleNotification(id: String) {
        if tasks?.notification ?? false  && tasks?.dates ?? Date() > Date(){
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
    
    public func addRequiredData(model: TaskModel) {
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
    
    
    
}




// remindersVc.notificationDelegate = self
//  self.navigationController?.pushViewController(remindersVc, animated: true)

//        let remindersVC = Utils().getViewController(viewController: .reminders) as! RemindersViewController
//        remindersVC.currentTask = self.tempTask
//        remindersVC.onCompletion = {
//            self.updateRemindersButton()
//            self.taskTitleTextView.becomeFirstResponder()
//        }
//
//        self.present(UINavigationController(rootViewController: remindersVC), animated: true) {
//            self.taskTitleTextView.resignFirstResponder()
//        }




//        if let taskDes = taskDescription.text, let taskName = taskTitle.text {
//
//          //  scheduleNotificationFor(task: )
//            //            let task = DoneTask(dateTaskPicker.date,taskDes ,dateTaskPicker.date, false, taskName, reminderButton.isEnabled, Int(Int16(Int(self.selectedPriority.rawValue))))
//            //           // scheduleNotification(id:0)
//            //            self.dataProvider.createTasks(task) { success in
//            //                if success {
//            //                    self.dismiss(animated: true, completion: nil)
//            //                }
//            //            }
//            //            let task = Tasks(context: dataProvider.managedObjectContext)
//            //            //task.dates = gg.reminderDate.date
//            //            task.descriptions = taskDes
//            //            task.dueDate = dateTaskPicker.date
//            //            task.isComplete = false
//            //            task.name = taskName
//            //            task.notification = false
//            //            task.priorty = Int16(Int(self.selectedPriority.rawValue))
//
//            //            if isUpdate {
//            //                self.delegate?.didTapUpdate(task: task)
//            //               // self.dataProvider.updateTask(task: task, atIndex: 0)
//            //            } else {
//            //               // self.dataProvider.saveTasks()
//            //               self.delegate?.didTapSave(task: task)
//            //            }
//            self.dataProvider.fetchTasks()
//            self.dismiss(animated: true, completion: nil)
//        }
