//
//  Priority.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/16.
//

import Foundation
import UIKit

enum Priority:Int {
    case High
    
    case Normal
    
    case Low
    
    case None
    
    public var color: UIColor {
        get {
            switch self {
            case .High:
                return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            case .Normal:
                return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            case .Low:
                return #colorLiteral(red: 0.5518312366, green: 1, blue: 0.1424983007, alpha: 1)
            case .None:
                return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    public var text: String {
        get {
            switch self {
            case .High:
                return "High"
            case .Normal:
                return "Normal"
            case .Low:
                return "Low"
            case .None:
                return "None"
            }
        }
    }
}
