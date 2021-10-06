//
//  TaskTableViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/07.
//

import UIKit
import CoreData
import LKAlertController

class TaskTableViewController: UITableViewController {
    
    
    var dataProvider = TaskModel(completionClosure: {})
    
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
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
    
/*
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Progress"
            }
    
            return "Completed"
        }
    
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
  
*/
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        self.sortButton.isEnabled = self.dataProvider.count > 0
       return self.dataProvider.count
       // return self.dataProvider.numberOfItemsFor(section: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as! TaskViewCell
        // Configure the cell...
        let complete = self.dataProvider.getTask(atIndex: indexPath.row)!
        cell.id = indexPath.row
        
       /*
        if indexPath.section == 0 && !complete.isComplete {
            cell.id = indexPath.row
            cell.configures(tasks: complete, completed: false)
        }else if indexPath.section == 1 && complete.isComplete {
            cell.id = indexPath.row
            cell.configures(tasks: complete, completed: true)
        }
        */
        
        cell.configures(tasks: complete)
        cell.delegate = self
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataProvider.lastIndexTapped = indexPath.row
        let detail = dataProvider.getTask(atIndex: indexPath.row)
        performSegue(withIdentifier: "Add", sender: detail)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.dataProvider.deleteTask(atIndex: indexPath.row)
                self.dataProvider.saveTasks()
                self.dataProvider.fetchTasks()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        action.image = UIImage(systemName: "trash")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        action.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return UISwipeActionsConfiguration(actions: [action])
    }
   
    /*
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: // handling the delete action
            let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.dataProvider.deleteTask(atIndex: indexPath.row)
                self.dataProvider.saveTasks()
                self.dataProvider.fetchTasks()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        default:
            break
        }
    }
    */
    
    @IBAction func sortTypeTapped(_ sender: UIBarButtonItem) {
        let sortSheet = ActionSheet(title: "Sort Types".localized(), message: nil)
        SortModel.allCases.forEach { (sortType) in
            sortSheet.addAction(sortType.getSortTitle(), style: .default) { (_) in
                self.dataProvider.selectedSortType = sortType
                self.dataProvider.fetchTasks()
            }
        }
        sortSheet.addAction("CANCEL".localized(), style: .cancel)
        sortSheet.presentIn(self)
        sortSheet.show(animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
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
                vc.tasks = sender  as? DoneTask
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

extension TaskTableViewController: TaskTableViewCellDelegate {
    
    func didSelect(taskTableViewCell: TaskViewCell, didSelect: Bool) {
        guard let index = taskTableViewCell.id else { return }
        if let old = self.dataProvider.getTask(atIndex: index) {
            let new = DoneTask(old.descriptions, old.dueDate,true, old.name, Int(old.priorty))
            self.dataProvider.updateTask(task: new, atIndex: index)
            self.dataProvider.saveTasks()
         // self.dataProvider.fetchTasks()
        }
    }
    
    func didDeselect(taskTableViewCell: TaskViewCell, didDeselect: Bool) {
        guard let index = taskTableViewCell.id else { return }
        if let old = self.dataProvider.getTask(atIndex: index) {
            let new = DoneTask(old.descriptions, old.dueDate, false, old.name, Int(old.priorty))
            self.dataProvider.updateTask(task: new, atIndex: index)
            self.dataProvider.saveTasks()
         // self.dataProvider.fetchTasks()
        }
    }
    
    
}



extension TaskTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            break
        @unknown default:
            break
        }
    }
}

