//
//  ReminderViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/06.
//

import UIKit


//protocol NotificationDelegate: AnyObject {
//    func prepareAddNotification(with date: Date)
//    func prepareRemoveNotification()
//}

class ReminderViewController: UIViewController {

 
    @IBOutlet weak var setReminder: UIButton!
    @IBOutlet weak var noReminderButton: UIButton!
    @IBOutlet weak var reminderDate: UIDatePicker!
    
//    weak var notificationDelegate: NotificationDelegate!
    var dataProvider = TaskModel(completionClosure: {})
    var dates = Date()
    var reminder = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func setReminderTapped(_ sender: UIButton) {
      //  notificationDelegate.prepareAddNotification(with: reminderDate.date)
        if sender.isEnabled == true {
            reminderDate.isHidden = false
            reminder = true
        }else{
            reminderDate.isHidden = true
            reminder = false
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func noReminderTapped(_ sender: UIButton) {
       // notificationDelegate.prepareRemoveNotification()
        navigationController?.popViewController(animated: true)
    }
    
    
     @IBAction func reminderdatePicker(_ sender: UIDatePicker) {
        let components = DateComponents()
        reminderDate.setDate(Calendar(identifier: .gregorian).date(from: components)!, animated: false)
        reminderDate.minimumDate = Date()
        dataProvider.tasks?.date = sender.date
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
