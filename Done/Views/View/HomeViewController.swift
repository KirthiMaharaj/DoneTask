//
//  HomeViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var titles: UITextField!
    @IBOutlet weak var colorButton: UIButton!
    
    var dataProvider = TaskManager()
    var taskCo = 0
    var TodoTextColor = "Default"
    var tasks : CategoryTask?
    // let notificationManager = LocalNotificationManager()
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    override func viewDidLoad() {
        super.viewDidLoad()
        colorChoose()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if let taskName = titles.text {
            let task = CategoryTask(taskName, taskCo, TodoTextColor)
            
            self.dataProvider.createCategoryTasks(task) { success in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            self.dataProvider.saveTasks()
            self.dataProvider.fetchCategory()
            self.dismiss(animated: true, completion: nil)
        }
        
        
        self.dataProvider.saveTasks()
        self.dataProvider.fetchCategory()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        titles.resignFirstResponder()
    }
    
    @IBAction func colorTapped(_ sender: UIButton) {
        
    }
    
    public func addRequiredData(model: TaskManager) {
        self.dataProvider = model
    }
    
    private func colorChoose(){
        titles.becomeFirstResponder()
        
        if let todo = tasks {
            titles.text = todo.name
            titles.text =  todo.name
        }
        isModalInPresentation = true
        
        NotificationCenter.default.addObserver(forName: COLOR_NOTIFICATION, object: nil, queue: nil) { notification in
            self.titles.textColor = UIColor(named: notification.object as! String)
            self.TodoTextColor = notification.object as! String
        }
        if tasks?.colors == "Blue"{
            self.titles.textColor = UIColor(named: "Blue")
            TodoTextColor = "Blue"
        }
        if tasks?.colors == "Default"{
            self.titles.textColor = UIColor(named: "Default")
            TodoTextColor = "Default"
        }
        if tasks?.colors == "DarkBlue"{
            self.titles.textColor = UIColor(named: "DarkBlue")
            TodoTextColor = "DarkBlue"
        }
        if tasks?.colors == "Orange"{
            self.titles.textColor = UIColor(named: "Orange")
            TodoTextColor = "DarkBlue"
        }
        if tasks?.colors == "Pink"{
            self.titles.textColor = UIColor(named: "Pink")
            TodoTextColor = "Pink"
        }
        if tasks?.colors == "Purple"{
            self.titles.textColor = UIColor(named: "Purple")
            TodoTextColor = "Purple"
        }
        if tasks?.colors == "Teal"{
            self.titles.textColor = UIColor(named: "Teal")
            TodoTextColor = "Teal"
        }
        if tasks?.colors == "Yellow"{
            self.titles.textColor = UIColor(named: "Yellow")
            TodoTextColor = "Yellow"
        }
    }
    
    /*
     // MARK: - Navigation
     
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
