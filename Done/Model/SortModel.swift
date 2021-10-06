//
//  SortModel.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/21.
//

import Foundation

enum SortModel: CaseIterable {
    case sortNameAsc
    case sortNameDesc
    case sortDateAsc
    case sortDateDesc
    case sortPriorityAsc
    case sortPriorityDesc
    
    func getSortTitle() -> String {
        var titleString = ""
        switch self {
        case .sortNameAsc:
            titleString = "Name (Ascending)"
        case .sortNameDesc:
            titleString = "Name (Descending)"
        case .sortDateAsc:
            titleString = "Date (Earliest)"
        case .sortDateDesc:
            titleString = "Date (Latest)"
        case .sortPriorityAsc:
            titleString = "Priority (Ascending)"
        case .sortPriorityDesc:
            titleString = "Priority (Descending)"
            
        }
        return titleString
    }
    
    func getSortDescriptor() -> [NSSortDescriptor] {
        switch self {
        case .sortNameAsc:
            return [NSSortDescriptor(key: "name", ascending: true)]
        case .sortNameDesc:
            return [NSSortDescriptor(key: "name", ascending: false)]
        case .sortDateAsc:
            return [NSSortDescriptor(key: "dueDate", ascending: true)]
        case .sortDateDesc:
            return [NSSortDescriptor(key: "dueDate", ascending: false)]
        case .sortPriorityAsc:
            return [NSSortDescriptor(key: "priorty", ascending: true), NSSortDescriptor(key: "dueDate", ascending: true)]
        case .sortPriorityDesc:
            return [NSSortDescriptor(key: "priorty", ascending: false), NSSortDescriptor(key: "dueDate", ascending: true)]
        }
    }
}


class Sorting {
    
    let sortOnNotComplete = NSSortDescriptor(key: "isComplete", ascending: true)
    let sortOnCompleted = NSSortDescriptor(key: "isComplete", ascending: false)
    lazy var selectedSort = [sortOnNotComplete, sortOnCompleted]
    
    func sortCompleted() {
        selectedSort = [sortOnCompleted, sortOnNotComplete]
    }
    
    func sortNotCompleted() {
        selectedSort = [sortOnNotComplete, sortOnNotComplete]
    }
}
