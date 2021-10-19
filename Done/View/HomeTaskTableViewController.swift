//
//  HomeTaskTableViewController.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/06.
//

import UIKit

class HomeTaskTableViewController: UITableViewController {

    var dataProvider = TaskModel(completionClosure: {})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        self.dataProvider.fetchCategory()
    }

    private func setupModel() {
        self.dataProvider = TaskModel(completionClosure: {})
        self.dataProvider.delegate = self
    }
    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataProvider.taskss.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: " HomeTableViewCell", for: indexPath) as!  HomeTableViewCell

        // Configure the cell...
         let task = self.dataProvider.taskss[indexPath.row]
        cell.configures(tasks: task)
        
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
        performSegue(withIdentifier: "CateAdd", sender: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  performSegue(withIdentifier: "AddTasks", sender: self)
    }
    
    
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
            if let vc = navi.viewControllers.first as? HomeViewController {
                vc.addRequiredData(model: self.dataProvider)
            }
            if let taskVv = navi.viewControllers.first as? TaskTableViewController {
                 let indexPath = tableView.indexPathForSelectedRow
                taskVv.dataProvider.selectedCategory = dataProvider.taskss[indexPath!.row]
                taskVv.dataProvider = dataProvider
                tableView.deselectRow(at: indexPath!, animated: true)
            }
        }
    }
    

}


extension HomeTaskTableViewController: TasksDataManagerDelegate {
    
    func fetchTasksSuccess(model: TaskModel, success: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
