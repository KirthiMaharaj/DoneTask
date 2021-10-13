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
    var taskss = [SubTask]()
    var lastIndexTapped : Int = 0
    var tasks : DoneTask? = nil
    public weak var delegate: TasksDataManagerDelegate?
    var selectedSortType: SortModel = .sortDateAsc
    let sorting = Sorting()
    var dates = Date()
    var reminder = false
    var selectedCategory : SubTask? {
        didSet {
            fetchTasks()
        }
    }
    
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "Done")
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
        let categoryPredicate = NSPredicate(format: "parentProject.title MATCHES %@", selectedCategory?.title ?? "")
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
    func createTasks(_ task: DoneTask ,completion: @escaping (_ success: Bool)-> ()) {
        let newTask = Tasks(context: managedObjectContext)
        newTask.date = task.date
        newTask.descriptions = task.descriptions
        newTask.dueDate = task.dueDate
        newTask.isComplete = task.isComplete
        newTask.name = task.name
        newTask.notification = task.notification
        newTask.priorty = task.priorty
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
        guard index >= 0, index < self.tasked.count else {
            return
        }
        
        let entity = self.tasked[index]
        entity.date = task.date
        entity.descriptions = task.descriptions
        entity.dueDate = task.dueDate
        entity.isComplete = task.isComplete
        entity.name = task.name
        entity.notification = task.notification
        entity.priorty = entity.priorty
        
    }
    
    //Tasks
    public func deleteTask(atIndex index: Int) {
        guard index >= 0, index < self.tasked.count, self.tasked.count > 0 else { return }
        
        let entity = self.tasked[index]
        self.managedObjectContext.delete(entity)
        
    }
    
    //Tasks
    public func getTask(atIndex index: Int) -> DoneTask? {
        guard index >= 0, index < self.tasked.count else {
            return nil
        }
        let entity = self.tasked[index]
        let tasks = DoneTask(entity.date ?? Date(), entity.descriptions ?? "empty description", entity.dueDate ?? Date(), entity.isComplete, entity.name ?? "empty name",entity.notification , Int(entity.priorty))
        return tasks
    }
    
    
    
    //Category
    
    var countCate: Int {
        get {
            self.taskss.count
        }
    }
    
    public func fetchCategory() {
        let fetchRequest: NSFetchRequest<SubTask> = SubTask.fetchRequest()
        do {
            self.taskss = try self.managedObjectContext.fetch(fetchRequest)
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        }
        catch {
            fatalError()
        }
    }
    
    func createCategoryTasks(_ task: Category ,completion: @escaping (_ success: Bool)-> ()) {
        let newTask = SubTask(context: managedObjectContext)
        
        newTask.title = task.name
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
    
    public func getCategory(atIndex index: Int) -> Category? {
        guard index >= 0, index < self.countCate else {
            return nil
        }
        let entity = self.taskss[index]
        let tasks = Category(entity.title ?? "name")
        return tasks
    }
    
}



//    public func createTask(_ task: DoneTask) {
//        let newTask = Tasks(context: self.managedObjectContext)
//        newTask.descriptions = task.descriptions
//        newTask.isComplete = task.isComplete
//        newTask.isDelete = task.isDelete
//        newTask.name = task.name
//
//    }
//        func fetchTasks(completion: @escaping (_ tasked: [DoneTask]) -> ()){
//            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
//            do {
//                let tasksData = try managedObjectContext.fetch(fetch) as! [Tasks]
//                let tasks = tasksData.compactMap { DoneTask(taskModel: $0) }
//                completion(tasks)
//            } catch {
//                fatalError("Could not save context: \(error)")
//            }
//        }
//
//    func getToday() -> DoneTask {
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
//
//    }

