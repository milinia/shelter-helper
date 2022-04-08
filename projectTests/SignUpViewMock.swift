//
//  SignUpMock.swift
//  projectTests
//
//  Created by Evelina on 27.03.2022.
//

import Foundation
import UIKit
@testable import project

class SignUpViewMock: SignUpViewProtocol {
    
    var isNewScreenHadBeenPerfomed: Bool = false
    var isAlertHadBeenShowed: Bool = false
    
    func showAlert(alert: UIAlertController) {
        isAlertHadBeenShowed = true
    }
    
    func goToMapScreen() {
        isNewScreenHadBeenPerfomed = true
    }
}
