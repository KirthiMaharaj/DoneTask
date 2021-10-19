//
//  Subtask+CoreDataProperties.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/10/15.
//
//

import Foundation
import CoreData


extension Subtask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subtask> {
        return NSFetchRequest<Subtask>(entityName: "Subtask")
    }

    @NSManaged public var title: String?
    @NSManaged public var taskCount: Int16
    @NSManaged public var colors: String?
    @NSManaged public var status: String?
    @NSManaged public var subtask: NSSet?

}

// MARK: Generated accessors for subtask
extension Subtask {

    @objc(addSubtaskObject:)
    @NSManaged public func addToSubtask(_ value: Tasks)

    @objc(removeSubtaskObject:)
    @NSManaged public func removeFromSubtask(_ value: Tasks)

    @objc(addSubtask:)
    @NSManaged public func addToSubtask(_ values: NSSet)

    @objc(removeSubtask:)
    @NSManaged public func removeFromSubtask(_ values: NSSet)

}

extension Subtask : Identifiable {

}
