//
//  Tasks+CoreDataClass.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/15.
//
//

import Foundation
import CoreData

@objc(Tasks)
public class Tasks: NSManagedObject {

    func tasks() -> DoneTask {
        return DoneTask() 
    }
}
