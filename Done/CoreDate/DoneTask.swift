import Foundation
import CoreData

struct DoneTask {
 
    var date: Date
    var descriptions:String
    var dueDate:Date
    var taskIds:String?
    var isComplete:Bool
    var name:String
    var priorty:Int16
    var notification :Bool = false
    var category: Subtask
    
    init( _ taskDate:Date, _ taskDescriptions: String, _ taskdueDate:Date, _ taskId:String ,_ taskComplete:Bool, _ taskName:String, _ taskPriority:Int, _ taskNotification: Bool, _ taskCategory: Subtask) {
      
        date = taskDate
        descriptions = taskDescriptions
        dueDate = taskdueDate
        taskIds = taskId
        isComplete = taskComplete
        name = taskName
        priorty = Int16(taskPriority)
        notification = taskNotification
        category = taskCategory
        
        print("Add cat to CD: \(taskCategory)")
    }
    
   /* init?(taskModel: Tasks) {
        guard let taskDate = taskModel.date,let taskDescriptions = taskModel.decriptions, let taskdueDate = taskModel.duedate, let taskName = taskModel.name , let taskCategory = taskModel.parentCategory else { return nil }
     
        date = taskDate
        descriptions = taskDescriptions
        dueDate = taskdueDate
        isComplete = taskModel.isComplete
        name = taskName
        priorty = Int16(taskModel.priority)
        notification = taskModel.reminder
        category = taskCategory.title ?? "No category"
        print("Add cat to CD: \(category)")
    }*/
}

