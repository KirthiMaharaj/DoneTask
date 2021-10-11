//
//  Category.swift
//  Done1
//
//  Created by Kirthi Maharaj on 2021/10/11.
//

import Foundation
import CoreData

struct Category {
    var name: String
    
    init(_ taskName:String) {
        name = taskName
    }
    
    init?(taskModel: SubTask) {
        guard let taskNames = taskModel.title else {return nil }
        name = taskNames
    }
    
}

