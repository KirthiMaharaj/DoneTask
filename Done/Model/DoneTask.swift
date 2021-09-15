//
//  DoneTask.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/09.
//

import Foundation
import CoreData

struct DoneTask {
    //var color:String
    var descriptions:String
    var dueDate:Date
    // var id:UUID
    var isComplete:Bool
    //    var isDelete:Bool
    var name:String
    // var priorty:Int64
    
    init(_ taskDescriptions: String, _ taskDate:Date, _ taskComplete:Bool, _ taskName:String) {
        //  color = taskColor
        descriptions = taskDescriptions
        dueDate = taskDate
        //  id = taskId
        isComplete = taskComplete
        //   isDelete = taskDelete
        name = taskName
        //  priorty = taskPriorty
    }
    
    init?(taskModel: Tasks) {
        guard let taskDescriptions = taskModel.descriptions, let taskDate = taskModel.dueDate, let taskName = taskModel.name else { return nil }
        //  color = taskColor
        descriptions = taskDescriptions
        dueDate = taskDate
        //   id = taskId
        isComplete = taskModel.isComplete
        //    isDelete = taskModel.isDelete
        name = taskName
        //  priorty = taskModel.priorty
    }
}

