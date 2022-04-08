//
//  SignUpPresenter.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import Foundation
import FirebaseAuth
import SwiftUI

class SignUpPresenter: SignUpPresenterProtocol {

    weak var signUpView: SignUpViewProtocol?
    private var formChecker: FormChecker
    private var alertFactory: AlertProtocol
    private var firebaseManager: FirebaseManager
    
    init(formChecker: FormChecker, alertFactory: AlertProtocol, firebaseManager: FirebaseManager) {
        self.formChecker = formChecker
        self.alertFactory = alertFactory
        self.firebaseManager = firebaseManager
    }
    
    func signUp(email: String, password: String) {
        if formChecker.checkEmail(email: email) && formChecker.checkPassword(password: password) {
            firebaseManager.signUp(email: email, password: password) { [self] result in
                switch result{
                case .success(_):
                    signUpView?.goToMapScreen()
                case .failure(_):
                    signUpView?.showAlert(
                        alert: alertFactory.createErrorAlert(
                            description: "Failed to register! Please try again later!"))
                }
            }
        } else {
            signUpView?.showAlert(alert: alertFactory.createErrorAlert(description: "Please check fields!"))
        }
    }
    
    func isEmailValid(email: String?) -> Bool {
        return formChecker.checkEmail(email: email ?? "")
    }
    
    func isPasswordValid(password: String?) -> Bool {
        return formChecker.checkPassword(password: password ?? "")
    }
    func getAlertProtocolImpl() -> AlertProtocol {
        return alertFactory
    }
}
