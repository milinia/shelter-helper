//
//  HelpingFunctions.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import Foundation
import UIKit

protocol AlertProtocol {
    func createErrorAlert(description: String) -> UIAlertController
    func createInformationAlert(title: String, description: String) -> UIAlertController
}

class AlertFactory: AlertProtocol {
    
    func createErrorAlert(description: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Close", style: .destructive) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(dismissAction)
        return alertController
    }
    
    func createInformationAlert(title: String, description: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(dismissAction)
        return alertController
    }
}
