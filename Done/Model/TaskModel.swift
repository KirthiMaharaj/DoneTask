//
//  TaskModel.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/09.
//

import Foundation
import CoreData

protocol TasksDataManagerDelegate: AnyObject {
    func fetchTasksSuccess(model: TaskModel, success: Bool)
}

protocol TaskTableViewCellDelegate: AnyObject {
    
    func didSelect(taskTableViewCell: TaskViewCell, didSelect: Bool)
    
    func didDeselect(taskTableViewCell: TaskViewCell, didDeselect: Bool)
}


class TaskModel {
    
    var managedObjectContext: NSManagedObjectContext { persistentContainer.viewContext }
    private var persistentContainer: NSPersistentContainer
    private var task: [Tasks] = []
    
    var lastIndexTapped : Int = 0
    public weak var delegate: TasksDataManagerDelegate?
    
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "Done")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
    
    var doneTaskEntities: [Tasks] {
        get {
            self.task.filter { taskEntity in
                taskEntity.isComplete
            }
        }
    }
    
    var count: Int {
        get {
            self.task.count
        }
    }
    
    public var doneCount: Int {
        get {
            self.doneTaskEntities.count
        }
    }
    
    
    public func fetchTasks() {
        do {
            self.task = try self.managedObjectContext.fetch(Tasks.fetchRequest())
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        }
        catch {
            fatalError()
        }
    }
    
    
    func createTasks(_ task: DoneTask, completion: @escaping (_ success: Bool)-> ()) {
        let newTask = Tasks(context: managedObjectContext)
        // newTask.colors =  task.color
        newTask.descriptions = task.descriptions
        newTask.dueDate = task.dueDate
        // newTask.id = task.id
        newTask.isComplete = task.isComplete
        //        newTask.isDelete = task.isDelete
        newTask.name = task.name
        //  newTask.priorty = task.priorty
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Could not save context: \(error)")
        }
    }
    
    public func saveTasks() {
        do {
            try self.managedObjectContext.save()
        }
        catch {
            fatalError()
        }
    }
    
    
    public func updatedTasks(task: DoneTask) {
        
        let update = Tasks(context: managedObjectContext)
        
        // update.colors =  task.color
        update.descriptions = task.descriptions
        update.dueDate = task.dueDate
        // update.id = task.id
        update.isComplete = task.isComplete
        //  update.isDelete = task.isDelete
        update.name = task.name
        //  update.priorty = task.priorty
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Could not save context: \(error)")
        }
    }
    
    public func updateTask(task: DoneTask, atIndex index: Int) {
        guard index >= 0, index < self.count else {
            return
        }
        
        let entity = self.task[index]
        // entity.colors = task.color
        entity.descriptions = task.descriptions
        entity.dueDate = task.dueDate
        // entity.id = task.id
        entity.isComplete = task.isComplete
        //  entity.isDelete = task.isDelete
        entity.name = task.name
        // entity.priorty = entity.priorty
    }
    
    
    public func deleteTask(atIndex index: Int) {
        guard index >= 0, index < self.count, self.count > 0 else {
            return
        }
        
        let entity = self.task[index]
        self.managedObjectContext.delete(entity)
    }
    
    public func getTask(atIndex index: Int) -> DoneTask? {
        guard index >= 0, index < self.count else {
            return nil
        }
        let entity = self.task[index]
        let tasks = DoneTask(entity.descriptions ?? "empty description", entity.dueDate ?? Date(), entity.isComplete, entity.name ?? "empty name", entity.priorty)
        return tasks
    }
    
    
    public func removeAllDoneTasks() {
        var index: Int = 0
        for entity in self.task {
            if entity.isComplete {
                self.deleteTask(atIndex: index)
            }
            index += 1
        }
    }
    
//    public func changeTaskPriority(task: DoneTask, priority: Int) {
//        let update = Tasks(context: managedObjectContext)
//        update.priorty = task.priorty
//
//    }
    
}









//    public func createTask(_ task: DoneTask) {
//        let newTask = Tasks(context: self.managedObjectContext)
//        newTask.descriptions = task.descriptions
//        newTask.isComplete = task.isComplete
//        newTask.isDelete = task.isDelete
//        newTask.name = task.name
//
//    }
//    func fetchTasks(completion: @escaping (_ tasked: [DoneTask]) -> ()){
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
//        do {
//            let tasksData = try managedObjectContext.fetch(fetch) as! [Tasks]
//            let tasks = tasksData.compactMap { DoneTask(taskModel: $0) }
//            completion(tasks)
//        } catch {
//            fatalError("Could not save context: \(error)")
//        }
//    }
//    func getToday() -> DoneTask {
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
//
//    }

