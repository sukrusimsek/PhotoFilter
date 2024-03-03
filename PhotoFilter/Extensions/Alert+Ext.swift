//
//  Alert+Ext.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 3.03.2024.
//

import Foundation

import UIKit

extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func alertNoAction(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
            alertController.dismiss(animated: true)
        }
    }
}
