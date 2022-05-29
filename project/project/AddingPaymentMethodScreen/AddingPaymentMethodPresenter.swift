//
//  AddingPaymentMethodPresenter.swift
//  project
//
//  Created by Evelina on 25.05.2022.
//

import Foundation
import UIKit

protocol AddingPaymentMethodPresenterProtocol {
    func checkCharactersAmountInString(string: String?, neededAmountCharacters: Int) -> Bool
    func addNewCard(card: Card, userCardsNumber: Int)
}

class AddingPaymentMethodPresenter: AddingPaymentMethodPresenterProtocol{
    
    var dataManager = DataManager()
    var alertFactory: AlertProtocol = AlertFactory()
    var addingPaymentMethodView: AddingPaymentMethodViewProtocol?
    
    func addNewCard(card: Card, userCardsNumber: Int) {
        dataManager.addUserCreditCard(card: card, cardsNumber: userCardsNumber) { result in
            switch result {
            case .success(_):
                self.addingPaymentMethodView?.showAlert(alert: self.alertFactory.createInformationAlert(title: "Done", description: "New card was added successfully!"))
            case .failure(_):
                self.addingPaymentMethodView?.showAlert(alert: self.alertFactory.createErrorAlert(description: "Failed to add new card. Please check your network connection!"))
            }
        }
    }
    
    func checkCharactersAmountInString(string: String?, neededAmountCharacters: Int) -> Bool {
        if string == nil || string == "" {
            return false
        } else {
            if string?.count == neededAmountCharacters {
                return true
            } else {
                return false
            }
        }
    }
    
}
