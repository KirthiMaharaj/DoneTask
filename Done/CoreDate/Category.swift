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
    init(_ taskName:String, _ taskCount: Int) {
        name = taskName
        cateCoun = Int16(taskCount)
    }
    
    init?(taskModel: Subtask) {
        guard let taskNames = taskModel.title else { return nil }
        name = taskNames
        cateCoun = taskModel.taskCount
    }
    
}

