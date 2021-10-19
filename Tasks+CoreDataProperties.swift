//
//  Tasks+CoreDataProperties.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/15.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var name: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var dates: Date?
    @NSManaged public var descriptions: String?
    @NSManaged public var id: String?
    @NSManaged public var priorty: Int16
    @NSManaged public var isComplete: Bool
    @NSManaged public var isDelete: Bool
    @NSManaged public var notification: Bool
    @NSManaged public var parentProject: Subtask?

}

extension Tasks : Identifiable {

}
