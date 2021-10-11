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
    
    var dataProvider = TaskModel(completionClosure: {})
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if let taskName = titles.text {
            let task = Category(taskName)
            
            self.dataProvider.createCategoryTasks(task) { success in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            self.dataProvider.saveTasks()
            self.dataProvider.fetchCategory()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func colorTapped(_ sender: UIButton) {
        
    }
    
    public func addRequiredData(model: TaskModel) {
        self.dataProvider = model
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
