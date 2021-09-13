//
//  TaskTableViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/07.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    var dataProvider = TaskModel(completionClosure: {})
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        dataProvider.fetchTasks()
    }
    
    private func setupModel() {
        self.dataProvider = TaskModel(completionClosure: {})
        self.dataProvider.delegate = self
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  self.dataProvider.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as! TaskViewCell
        
        // Configure the cell...
        if let tasks = dataProvider.getTask(atIndex: indexPath.row) {
            cell.taskName.text = tasks.name
            cell.id = indexPath.row
            cell.completeButton.isOn = tasks.isComplete
            cell.delegate = self
            
        }
        return cell
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination .isKind(of: UINavigationController.self) {
            let navi: UINavigationController = segue.destination as! UINavigationController
            if let vc = navi.viewControllers.first as? AddTaskViewController {
                vc.addRequiredData(model: self.dataProvider)
            }
        }
    }
    
}

extension TaskTableViewController: TasksDataManagerDelegate {
    func fetchTasksSuccess(model: TaskModel, success: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension TaskTableViewController: TaskTableViewCellDelegate{
    func didSelect(taskTableViewCell: TaskViewCell, didSelect: Bool) {
        guard let index = taskTableViewCell.id else { return }
        if let old = self.dataProvider.getTask(atIndex: index) {
            let new = DoneTask(old.descriptions, true, old.name)
            self.dataProvider.updateTask(task: new, atIndex: index)
            self.dataProvider.saveTasks()
        }
    }
    
    func didDeselect(taskTableViewCell: TaskViewCell, didDeselect: Bool) {
        guard let index = taskTableViewCell.id else { return }
        if let old = self.dataProvider.getTask(atIndex: index) {
            let new = DoneTask(old.descriptions, false, old.name)
            self.dataProvider.updateTask(task: new, atIndex: index)
            self.dataProvider.saveTasks()
        }
    }
    
    
}
