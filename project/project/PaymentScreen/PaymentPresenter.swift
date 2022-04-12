//
//  PaymentPresenter.swift
//  project
//
//  Created by Evelina on 10.04.2022.
//

import Foundation
import UIKit

protocol PaymentPresenterProtocol: AnyObject {
    func isPaymentDataValid(amount: String) -> Bool
    func makePayment(need: Need, needNumber: Int, amount: Int)
    func getAlertProtocolImpl() -> AlertProtocol
}

class PaymentPresenter: PaymentPresenterProtocol {
    
    weak var paymentView: PaymentViewProtocol?
    private var formChecker: FormChecker =  FormChecker()
    private var dataManager: DataManager = DataManager()
    private var alertFactory: AlertProtocol = AlertFactory()
    
    func isPaymentDataValid(amount: String) -> Bool {
        return formChecker.checkPaymentData(amount: amount)
    }
    func makePayment(need: Need, needNumber: Int, amount: Int) {
        dataManager.updateShelterNeed(needNumber: needNumber, need: need, payment: amount) { [weak self] result in
            switch result {
            case .failure(_):
                self?.paymentView?.showAlert(alert: self?.alertFactory.createErrorAlert(description: "Failed!") ?? UIAlertController())
            case .success(_): break
            }
        }
    }
    func getAlertProtocolImpl() -> AlertProtocol {
        return alertFactory
    }
}
