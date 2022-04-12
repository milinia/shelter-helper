//
//  StartPresenter.swift
//  project
//
//  Created by Evelina on 04.04.2022.
//

import Foundation
import FirebaseAuth

protocol StartPresenterProtocol {
    func isUserLoggedIn() -> Bool
}

class StartPresenter: StartPresenterProtocol {
    
    func isUserLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
}
