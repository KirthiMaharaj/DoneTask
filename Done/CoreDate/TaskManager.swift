//
//  TaskManager.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/15.
//

import Foundation
import CoreData

class TaskManager {
   
    
   
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DonesT")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    lazy var managedContext: NSManagedObjectContext = {
        // get location of stored core data file
        //  print(self.storeContainer.persistentStoreDescriptions.first?.url)
        return self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        
    }
    
    // currently not using to fetch projects
    func fetchAllProjects(completion: @escaping(Result<[Subtask]>) -> Void) {
        let fetchRequest: NSFetchRequest<Subtask> = Subtask.fetchRequest()
        do {
            let allProjects = try managedContext.fetch(fetchRequest)
            completion(.success(allProjects))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchTasks(with request: NSFetchRequest<Tasks> = Tasks.fetchRequest(), predicate: NSPredicate? = nil, selectedProject: Subtask, completion: @escaping(Result<[Tasks]>) -> Void) {
        
        let categoryPredicate = NSPredicate(format: "parentProject == %@", selectedProject)


        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            let tasks = try managedContext.fetch(request)
            completion(.success(tasks))
        } catch {
            completion(.failure(error))
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
