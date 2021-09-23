//
//  Config.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/16.
//

//import Foundation
import UIKit

class Config: NSObject {
    
    class Features: NSObject {
        static let enablePriority = true
    }
    
    class General: NSObject {
        static let priorityColors = [Config.Colors.red, Config.Colors.yellow, Config.Colors.green]
        static let priorityTitles = [ "High".localized(), "Normal".localized(), "Low".localized(), "None".localized()]
        static let sortTitles = ["CONFIG_SORT_PREF1".localized(), "CONFIG_SORT_PREF2".localized(), "CONFIG_SORT_PREF3".localized(), "CONFIG_SORT_PREF4".localized()]
    }
    
    class Colors: NSObject {
        static let red = UIColor.red
        static let green = UIColor.green
        static let yellow = UIColor.systemYellow
        static let orange = UIColor.orange
        static let black = UIColor.black
        static let night = UIColor.black
    }
}


//            if tasks.priorty != 5 && Config.Features.enablePriority {
//                cell.priortyButton.setTitle(Config.General.priorityTitles[Int(tasks.priorty) - 1], for: .normal)
//                cell.priortyButton.setTitleColor(Config.General.priorityColors[Int(tasks.priorty) - 1], for: .normal)
//                cell.priortyButton.isHidden = false
//            } else {
//                cell.priortyButton.isHidden = true
//           }
