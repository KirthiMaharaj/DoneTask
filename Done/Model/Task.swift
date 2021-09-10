//
//  Task.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/08.
//

import Foundation

struct Tasks {
    var priorty: Int16
    var name: String
    var isDone: Bool
    var isDelete: Bool
    var id: UUID
    var descriptions: String
    var date: Date
    var color: String
    
    init(_ taskpriorty: Int16, _ taskName: String, _ taskDone: Bool, _ taskDelete: Bool, _ taskId: UUID, _ taskDescription: String, _ taskDates: Date, _ taskColor: String) {
        priorty = taskpriorty
        name = taskName
        isDone = taskDone
        isDelete = taskDelete
        id = taskId
        descriptions = taskDescription
        date = taskDates
        color = taskColor
    }
    
    init?(taskModel: Task) {
        guard let taskpriorty = taskModel.priorty, let taskName = taskModel.name, let taskDone = taskModel.isDone, let taskDelete = taskModel.isDelete, let taskId = taskModel.id, let taskDescription = taskModel.descriptions, let taskDate = taskModel.date, let taskColor = taskModel.color else { return nil }
        priorty = taskpriorty
        name = taskName
        isDone = taskDone
        isDelete = taskDelete
        id = taskId
        descriptions = taskDescription
        date = taskDate
        color = taskColor
    }
}
