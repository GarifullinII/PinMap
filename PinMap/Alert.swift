//
//  Alert.swift
//  PinMap
//
//  Created by Ildar Garifullin on 02/11/2022.
//

import UIKit

extension UIViewController {
    
    func alertAddAddress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert)
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        
        let alertOk = UIAlertAction(
            title: "Ok",
            style: .default) { (action) in
                
                let tfText = alertController.textFields?.first
                guard let text = tfText?.text else {return}
                completionHandler(text)
            }
        
        let alertCancel = UIAlertAction(
            title: "Cancel",
            style: .default) { (_) in }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func alertError(title: String, message: String) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let alertOk = UIAlertAction(
            title: "Ok",
            style: .default)

        alertController.addAction(alertOk)

        present(alertController, animated: true, completion: nil)
    }
}
