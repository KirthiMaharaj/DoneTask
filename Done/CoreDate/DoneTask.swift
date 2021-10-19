////
////  DoneTask.swift
////  Done
////
////  Created by Kirthi Maharaj on 2021/09/09.
////
//
//import Foundation
//import CoreData
//
//struct DoneTask {
//    //var color:String
//    var date: Date
//    var descriptions:String
//    var dueDate:Date
//    var id:String?
//    var isComplete:Bool
//    var name:String
//    var notification :Bool = false
//    var priorty:Int16
//   // var category:Category
//
//
//    init( _ taskDate:Date, _ taskDescriptions: String, _ taskdueDate:Date, _ taskComplete:Bool, _ taskName:String, _ taskNotification: Bool, _ taskPriority:Int) {
//        //  color = taskColor
//
//        date = taskDate
//        descriptions = taskDescriptions
//        dueDate = taskdueDate
//        isComplete = taskComplete
//        name = taskName
//        notification = taskNotification
//        priorty = Int16(taskPriority)
//    }
//
//    init?(taskModel: Tasks) {
//        guard let taskDate = taskModel.dates, let taskDescriptions = taskModel.descriptions, let taskdueDate = taskModel.dueDate, let taskName = taskModel.name else { return nil }
//        //  color = taskColor
//        date = taskDate
//        descriptions = taskDescriptions
//        dueDate = taskdueDate
//        isComplete = taskModel.isComplete
//        name = taskName
//        notification = taskModel.notification
//        priorty = Int16(taskModel.priorty)
//    }
//}
//
