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
    var isComplete:Bool
    var name:String
    var priorty:Int16 = 5
    
    init(_ taskDescriptions: String, _ taskDate:Date, _ taskComplete:Bool, _ taskName:String, _ taskPriority:Int) {
        //  color = taskColor
        descriptions = taskDescriptions
        dueDate = taskDate
        isComplete = taskComplete
        name = taskName
        priorty = Int16(taskPriority)
    }
    
    init?(taskModel: Tasks) {
        guard let taskDescriptions = taskModel.descriptions, let taskDate = taskModel.dueDate, let taskName = taskModel.name else { return nil }
        //  color = taskColor
        descriptions = taskDescriptions
        dueDate = taskDate
        isComplete = taskModel.isComplete
        name = taskName
        priorty = Int16(taskModel.priorty)
    }
}

