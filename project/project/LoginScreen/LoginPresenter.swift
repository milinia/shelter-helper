//
//  LoginPresenter.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import Foundation
import FirebaseAuth
import UIKit

class LoginPresenter: LoginPresenerProtocol{

    weak var loginView: LoginViewController!
    var formChecker: FormChecker = FormChecker()
    var firebaseManager: FirebaseManager = FirebaseManagerImpl()
    var alertFactory: AlertProtocol = AlertFactory()
    
    func login(email: String, password: String){
        if (formChecker.checkEmail(email: email) && formChecker.checkPassword(password: password)){
            firebaseManager.login(email: email, password: password) { [weak self] result in
                switch result{
                case .success(_):
                    self?.loginView.goToMapScreen()
                case .failure(_):
                    self?.loginView.showAlert(alert:
                                            self?.alertFactory.createErrorAlert(description: "Failed to log in! Please try again later!") ?? UIAlertController())
                }
            }
        }
        else{
            if (!formChecker.checkEmail(email: email)){
                loginView.showAlert(alert: alertFactory.createErrorAlert(description: "This is not email!"))
            }else if (!formChecker.checkPassword(password: password)){
                loginView.showAlert(alert: alertFactory.createErrorAlert(description: "Password must contain 6 characters,at least one number and one letter!"))
            }
        }
    }
    
    func isEmailValid(email: String?)->Bool{
        return formChecker.checkEmail(email: email ?? "")
    }
    
    func isPasswordValid(password: String?)->Bool{
        return formChecker.checkPassword(password: password ?? "")
    }
    func getAlertProtocolImpl() -> AlertProtocol {
        return alertFactory
    }
}
