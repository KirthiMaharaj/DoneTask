//
//  TaskManager.swift
//  DoneTask
//
//  Created by Kirthi Maharaj on 2021/10/14.
//

import Foundation
import CoreData
import UserNotifications
import UIKit

protocol TasksDataManagerDelegate: AnyObject {
    func fetchTasksSuccess(model: TaskManager, success: Bool)
}



class TaskManager  {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //private var persistentContainer: NSPersistentContainer
    var tasked: [Tasks] = []
    var taskss: [Subtask] = []
    var lastIndexTapped : Int = 0
    public weak var delegate: TasksDataManagerDelegate?
    var selectedSortType: SortModel = .sortDateAsc
    let sorting = Sorting()
    var dates = Date()
    var reminder = false
    var selectedCategory : Subtask?
    
    //Tasks
    var count: Int {
        get {
            self.tasked.count
        }
    }
    
    //Tasks
    func numberOfItemsFor(section: Int) -> Int {
        switch section {
        case 0:
            return tasked.filter({!$0.isComplete}).count
        case 1:
            return tasked.filter({$0.isComplete}).count
        default:
            fatalError("Too many sections")
        }
    }
    
    
    
    //Tasks
    public func fetchTasks(with fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest(), predicate: NSPredicate? = nil) {
        
        print("Your selected category is: \(selectedCategory?.title ?? "N/A")")
        
        fetchRequest.sortDescriptors = sorting.selectedSort + selectedSortType.getSortDescriptor()
        let categoryPredicate = NSPredicate(format: "parentProject.title MATCHES %@", selectedCategory?.title ?? "")

        if let additionalPredicate = predicate {
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate, categoryPredicate])
        } else {
            fetchRequest.predicate = categoryPredicate
        }
        do {
            
            self.tasked = try self.managedObjectContext.fetch(fetchRequest)
            print("tasks:\(self.tasked)")
            
           for i in 0 ..< tasked.count {
            print("Task: \(i + 1): \(tasked[i].name ?? "No Name")  Category: \(tasked[i].parentProject?.title ?? "No category")")
            }
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        }
        catch {
            fatalError()
        }
    }
    
    
    
    //Tasks
    func createTasks(_ task: DoneTask ,completion: @escaping (_ success: Bool)-> ()) {
        let newTask = Tasks(context: managedObjectContext)
        newTask.dates = task.date
        newTask.descriptions = task.descriptions
        newTask.dueDate = task.dueDate
        newTask.isComplete = task.isComplete
        newTask.name = task.name
        newTask.priorty = task.priorty
        newTask.notification = task.notification
        newTask.parentProject = task.category
        
        //print("This is your Category \(task.category)")
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Could not save context: \(error)")
        }
    }
    
    
    public func saveTasks() {
        do {
            try self.managedObjectContext.save()
        }catch {
            fatalError()
        }
    }
    
    //Tasks
    public func updatedTasks(_ task: DoneTask) {
        
        do {
            try self.managedObjectContext.save()
        }catch {
            fatalError()
        }
        fetchTasks()
    }
    
    
    //Tasks
    public func updateTask(task: DoneTask, atIndex index: Int) {
        guard index >= 0, index < self.count else {
            return
        }
        
        let entity = self.tasked[index]
        entity.dates = task.date
        entity.descriptions = task.descriptions
        entity.dueDate = task.dueDate
        entity.isComplete = task.isComplete
        entity.name = task.name
        entity.priorty = entity.priorty
        entity.notification = task.notification
        entity.parentProject = task.category
    }
    
    //Tasks
    public func deleteTask(atIndex index: Int) {
        guard index >= 0, index < self.count, self.count > 0 else { return }
        
        let entity = self.tasked[index]
        self.managedObjectContext.delete(entity)
        
    }
    
    //Tasks
    public func getTask(atIndex index: Int) -> DoneTask? {
        guard index >= 0, index < self.count else {
            return nil
        }
        let entity = self.tasked[index]
        let tasks = DoneTask(entity.dates ?? Date(), entity.descriptions ?? "empty description", entity.dueDate ?? Date(), entity.id ?? "",entity.isComplete, entity.name ?? "empty name" , Int(entity.priorty),entity.notification, entity.parentProject ?? Subtask())
        return tasks
    }
    
    
    
    //Category
    
    var countCate: Int {
        get {
            self.taskss.count
        }
    }
    
    public func fetchCategory() {
        let fetchRequest: NSFetchRequest<Subtask> = Subtask.fetchRequest()
        do {
            self.taskss = try self.managedObjectContext.fetch(fetchRequest)
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        }
        catch {
            fatalError()
        }
    }
    
    func createCategoryTasks(_ task: CategoryTask ,completion: @escaping (_ success: Bool)-> ()) {
        let newTask = Subtask(context: managedObjectContext)
        
        newTask.title = task.name
        newTask.taskCount = task.cateCoun
        newTask.colors = task.colors
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Could not save context: \(error)")
        }
    }
    
    public func deleteSubTask(atIndex index: Int) {
        guard index >= 0, index < self.countCate, self.countCate > 0 else { return }
        
        let entity = self.taskss[index]
        self.managedObjectContext.delete(entity)
        
    }
    
    public func getCategory(atIndex index: Int) -> CategoryTask? {
        guard index >= 0, index < self.countCate else {
            return nil
        }
        let entity = self.taskss[index]
        let tasks = CategoryTask(entity.title ?? "name", Int(entity.taskCount), entity.colors ?? "colors")
        return tasks
    }
    
    public func getCatName(atIndex index: Int) -> Subtask?
    {
        guard index >= 0, index < self.countCate else {
            return nil
        }
        let entity = self.taskss[index]
        
        return entity
    }
    
     func scheduleNotificationFor(task: DoneTask) {
        guard let taskIDString = task.taskIds else {
            fatalError()
        }

        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = task.name
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: taskIDString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
     func cancelNotificationFor(task: DoneTask) {
        guard let taskID = task.taskIds else { return }

        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [taskID])
    }
}
