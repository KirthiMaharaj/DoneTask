//
//  Alert.swift
//  Done
//
//  Created by Kirthi Maharaj on 2021/09/23.
//

import UIKit

struct Alert {
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    
    static func showInfo(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "😧 Uh Oh", message: "It's empty!")
    }
}
