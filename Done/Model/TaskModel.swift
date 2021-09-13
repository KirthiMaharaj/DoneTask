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

class TaskModel {
    
    var managedObjectContext: NSManagedObjectContext { persistentContainer.viewContext }
    private var persistentContainer: NSPersistentContainer
    private var task: [Tasks] = []
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
    
    //    func fetchTasks(completion: @escaping (_ employee: [DoneTask]) -> ()){
    //        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
    //        do {
    //            let tasksData = try managedObjectContext.fetch(fetch) as! [Tasks]
    //            let tasks = tasksData.compactMap { DoneTask(taskModel: $0) }
    //            completion(tasks)
    //        } catch {
    //            fatalError("Could not save context: \(error)")
    //        }
    //    }
    public func fetchTasks() {
        do {
            self.task = try self.managedObjectContext.fetch(Tasks.fetchRequest())
            self.delegate?.fetchTasksSuccess(model: self, success: true)
        }
        catch {
            fatalError()
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
    
    func createTasks(_ task: DoneTask, completion: @escaping (_ success: Bool)-> ()) {
        let newTask = Tasks(context: managedObjectContext)
        // newTask.colors =  task.color
        newTask.descriptions = task.descriptions
        // newTask.dueDate = task.dueDate
        // newTask.id = task.id
        //        newTask.isComplete = task.isComplete
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
    
    public func updateTask(task: DoneTask, atIndex index: Int) {
        guard index >= 0, index < self.count else {
            return
        }
        
        let entity = self.task[index]
        // entity.colors = task.color
        entity.descriptions = task.descriptions
        // entity.dueDate = task.dueDate
        // entity.id = task.id
        // entity.isComplete = task.isComplete
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
        let tasks = DoneTask(entity.descriptions ?? "empty description", entity.name ?? "empty name")
        //Task(isDone: entity.isDone,name: entity.name ?? "empty name", priority: entity.priority)
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
    
}
