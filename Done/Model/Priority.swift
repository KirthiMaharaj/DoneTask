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
                return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            case .Normal:
                return #colorLiteral(red: 0.9877689481, green: 0.6459127069, blue: 0.01194186509, alpha: 1)
            case .Low:
                return #colorLiteral(red: 0.155171901, green: 0.7097317576, blue: 0.08393248171, alpha: 1)
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
