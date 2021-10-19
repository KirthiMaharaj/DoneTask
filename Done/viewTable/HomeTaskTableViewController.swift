//
//  HomeTaskTableViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/06.
//

import UIKit

class HomeTaskTableViewController: UITableViewController {

    var taskss: [Subtask] = []
    //var dataProvider = TaskManager(completionClosure: {})
    var dataProvider: TaskManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        self.dataProvider.fetchCategory()
    }
    
    private func setupModel() {
        //self.dataProvider = TaskManager(completionClosure: {})
        self.dataProvider = TaskManager()
        self.dataProvider.delegate = self
    }
    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataProvider.taskss.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as!  HomeTableViewCell

        // Configure the cell...
        if let task = self.dataProvider.getCategory(atIndex: indexPath.row){
            print("Category: \(task.name)")
            cell.configures(tasks: task)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.dataProvider.deleteSubTask(atIndex: indexPath.row)
                self.dataProvider.saveTasks()
                self.dataProvider.fetchCategory()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        action.image = UIImage(systemName: "trash")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        action.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return UISwipeActionsConfiguration(actions: [action])
    }

    
    
    @IBAction func AddCategory(_ sender: UIBarButtonItem) {
       // performSegue(withIdentifier: "CateAdd", sender: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddDetails", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination .isKind(of: UINavigationController.self) {
            let navi: UINavigationController = segue.destination as! UINavigationController
            if let vc = navi.viewControllers.first as? HomeViewController {
                vc.addRequiredData(model: self.dataProvider)
            }
            
        }
        
        if let destination = segue.destination as? TaskTableViewController {
        
            destination.taskCategory = self.dataProvider.getCatName(atIndex: tableView.indexPathForSelectedRow!.row)
            
        }
        
        if let catt = segue.destination as? HomeViewController {

            catt.addRequiredData(model: dataProvider)
        }

    }
    

}


extension HomeTaskTableViewController: TasksDataManagerDelegate {
    
    func fetchTasksSuccess(model: TaskManager, success: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
