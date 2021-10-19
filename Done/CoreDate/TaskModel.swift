//
//  TaskModel.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/09.
//

import Foundation
import CoreData
import UserNotifications

protocol TasksDataManagerDelegate: AnyObject {
    func fetchTasksSuccess(model: TaskModel, success: Bool)
}



class TaskModel {

    var managedObjectContext: NSManagedObjectContext { persistentContainer.viewContext }
    private var persistentContainer: NSPersistentContainer
    var tasked: [Tasks] = []
    var taskss = [Subtask]()
    var lastIndexTapped : Int = 0
    public weak var delegate: TasksDataManagerDelegate?
    var selectedSortType: SortModel = .sortDateAsc
    let sorting = Sorting()
    var dates = Date()
    var reminder = false
    var parentObject: Subtask!
    var selectedCategory : Subtask? {
        didSet {
            fetchTasks()
        }
    }

    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "DonesT")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }


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

        fetchRequest.sortDescriptors = sorting.selectedSort + selectedSortType.getSortDescriptor()
        let categoryPredicate = NSPredicate(format: "parentProject == %@", selectedCategory ?? "")
//        let categoryPredicate = NSPredicate(format: "parentProject.title MATCHES %@", selectedCategory)
//
        if let additionalPredicate = predicate {
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate, categoryPredicate])
        } else {
            fetchRequest.predicate = categoryPredicate
        }
        do {
            self.tasked = try self.managedObjectContext.fetch(fetchRequest)
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        }
        catch {
            fatalError()
        }
    }

    //Tasks
//    func createTasks(_ task: DoneTask ,completion: @escaping (_ success: Bool)-> ()) {
//        let newTask = Tasks(context: managedObjectContext)
//        newTask.dates = task.date
//        newTask.descriptions = task.descriptions
//        newTask.dueDate = task.dueDate
//        newTask.isComplete = task.isComplete
//        newTask.name = task.name
//        newTask.notification = task.notification
//        newTask.priorty = task.priorty
//        do {
//            try managedObjectContext.save()
//        } catch {
//            fatalError("Could not save context: \(error)")
//        }
//    }
//
    func removeAllPendingNotifications() {
        tasked.forEach(self.cancelNotificationFor)
    }

    func scheduleAllNotifications() {
        tasked.filter({
            $0.dates?.compare(Date()) == .orderedDescending
        }).filter({
            !$0.isComplete
        }).forEach(self.scheduleNotificationFor)
    }
    
    func getTaskFor(indexPath: IndexPath) -> Tasks {
        switch indexPath.section {
        case 0:
            return tasked.filter({!$0.isComplete})[indexPath.row]
        case 1:
            return tasked.filter({$0.isComplete})[indexPath.row]
        default:
            fatalError("Too many sections")
        }
    }
    
     func scheduleNotificationFor(task: Tasks) {
//        guard let taskIDString = task.id else {
//            fatalError()
//        }

        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = task.name ?? ""
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.dates ?? Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: task.id ?? "", content: content, trigger: trigger)
        center.add(request)
    }

    private func cancelNotificationFor(task: Tasks) {
        guard let taskID = task.id else { return }

        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [taskID])
    }


    public func saveTasks() {
        do {
            try self.managedObjectContext.save()
        }catch {
            fatalError()
        }
    }
    
//    func createNew(task: Tasks) throws {
////        guard task.parentProject?.title != nil else {
////            fatalError("Missing TaskID or CategoryID")
////        }
//
//        let managedObject = Tasks(context: managedObjectContext)
//       // try managedObject.replaceWith(task: task)
//        try self.managedObjectContext.save()
//
//        if managedObject.notification {
//            scheduleNotificationFor(task: managedObject)
//        }
//    }

   
    
    
    //Tasks
//    public func updatedTasks(_ task: DoneTask) {
//
//        do {
//            try self.managedObjectContext.save()
//        }catch {
//            fatalError()
//        }
//        fetchTasks()
//    }


    //Tasks
//    public func updateTask(task: DoneTask, atIndex index: Int) {
//        guard index >= 0, index < self.tasked.count else {
//            return
//        }
//
//        let entity = self.tasked[index]
//        entity.dates = task.date
//        entity.descriptions = task.descriptions
//        entity.dueDate = task.dueDate
//        entity.isComplete = task.isComplete
//        entity.name = task.name
//        entity.notification = task.notification
//        entity.priorty = entity.priorty
//
//    }

    //Tasks
    public func deleteTask(atIndex index: Int) {
        guard index >= 0, index < self.tasked.count, self.tasked.count > 0 else { return }

        let entity = self.tasked[index]
        self.managedObjectContext.delete(entity)

    }

    //Tasks
//    public func getTask(atIndex index: Int) -> DoneTask? {
//        guard index >= 0, index < self.tasked.count else {
//            return nil
//        }
//        let entity = self.tasked[index]
//       // let tasks = DoneTask(entity.dates ?? Date(), entity.descriptions ?? "empty description", entity.dueDate ?? Date(), entity.isComplete, entity.name ?? "empty name",entity.notification , Int(entity.priorty))
//        return tasks
//    }



    //Category


    public func fetchCategory() {
        let fetchRequest: NSFetchRequest<Subtask> = Subtask.fetchRequest()
        do {
            self.taskss = try self.managedObjectContext.fetch(fetchRequest)
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        } catch {
            fatalError()
        }
    }



    public func deleteSubTask(atIndex index: Int) {
        guard index >= 0, index < self.taskss.count, self.taskss.count > 0 else { return }

        let entity = self.taskss[index]
        self.managedObjectContext.delete(entity)

    }



}




