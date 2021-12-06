//
//  Category.swift
//  Done1
//
//  Created by Kirthi Maharaj on 2021/10/11.
//

import Foundation
import CoreData

struct CategoryTask {
    var name: String
    var cateCoun: Int16
    var colors:String
    init(_ taskName:String, _ taskCount: Int, _ taskColor: String) {
        name = taskName
        cateCoun = Int16(taskCount)
        colors = taskColor
    }
    
    init?(taskModel: Subtask) {
        guard let taskNames = taskModel.title , let taskColor = taskModel.colors else { return nil }
        name = taskNames
        cateCoun = taskModel.taskCount
        colors = taskColor
    }
    
}

