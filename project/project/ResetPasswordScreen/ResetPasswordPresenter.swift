//
//  ResetPasswordPresenter.swift
//  project
//
//  Created by Evelina on 14.03.2022.
//

import Foundation
import UIKit

class ResetPasswordPresenter: UserResetPassword{
    
    weak var resetPasswordView:ResetPasswordViewController!
    var formChecker: FormChecker = FormChecker()
    var alertFactory: AlertProtocol = AlertFactory()
    var firebaseManager: FirebaseManager = FirebaseManagerImpl()
    
    func resetPassword(email: String){
        firebaseManager.resetPassword(email: email) { [weak self] result in
            switch result{
                case .success(_):
                self?.resetPasswordView.showAlert(alert: self?.alertFactory.createInformationAlert(title: "Completed", description: "Mail with reset password link send") ?? UIAlertController())
                case .failure(_):
                self?.resetPasswordView.showAlert(alert: self?.alertFactory.createErrorAlert(description: "No user with such email") ?? UIAlertController())
            }
        }
    }
    func isEmailValid(email: String?)->Bool{
        return formChecker.checkEmail(email: email ?? "")
    }
    
    func getAlertProtocolImpl() -> AlertProtocol {
        return alertFactory
    }
}
