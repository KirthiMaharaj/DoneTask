//
//  ReminderViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/06.
//

import UIKit


protocol NotificationDelegate: AnyObject {
    func prepareAddNotification(with date: Date)
    func prepareRemoveNotification()
}

class ReminderViewController: UIViewController {

    @IBOutlet weak var reminderDoneButton: UIBarButtonItem!
    @IBOutlet weak var noReminderButton: UIButton!
    @IBOutlet weak var reminderDate: UIDatePicker!
    
    weak var notificationDelegate: NotificationDelegate!
    var dataProvider = TaskModel(completionClosure: {})
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func doneReminderTapped(_ sender: UIBarButtonItem) {
        notificationDelegate.prepareAddNotification(with: reminderDate.date)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func noReminderTapped(_ sender: UIButton) {
        notificationDelegate.prepareRemoveNotification()
        navigationController?.popViewController(animated: true)
    }
    
    
     @IBAction func reminderdatePicker(_ sender: UIDatePicker) {
        let components = DateComponents()
        reminderDate.setDate(Calendar(identifier: .gregorian).date(from: components)!, animated: false)
        reminderDate.minimumDate = Date()
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
