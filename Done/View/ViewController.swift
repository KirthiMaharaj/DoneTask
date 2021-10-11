//
//  ViewController.swift
//  Done1
//
//  Created by Kirthi Maharaj on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {


    
    var dataProvider = TaskModel(completionClosure: {})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
 
    
    
    public func addRequiredData(model: TaskModel) {
        self.dataProvider = model
    }

    
}

//if let taskName = taskTextField.text {
//    let task = Category(taskName)
//
//    self.dataProvider.createTasks(task) { success in
//        if success {
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    self.dataProvider.saveTasks()
//    self.dataProvider.fetchCategory()
//    self.dismiss(animated: true, completion: nil)
//}
