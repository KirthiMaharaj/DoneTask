//
//  HomeModel.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/14.
//

import Foundation

class HomeModel: NSObject {
    var title:String
    var icon:String
    var listType: ListType = .All
    var count: Int
    
    enum ListType: String {
        case All = "all"
        case Today = "today"
        case Tomorrow = "tomorrow"
        case Week = "week"
        case Completed = "completed"
        case Delete = "deleted"
    }
    
   init(title: String, icon: String, listType: ListType, count: Int) {
        self.title = title
        self.icon = icon
        self.listType = listType
        self.count = count
    }
    
   
}

