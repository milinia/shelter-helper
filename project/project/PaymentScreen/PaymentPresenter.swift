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
    func makePayment(need: Need?, needNumber: Int, amount: Int)
    func getAlertProtocolImpl() -> AlertProtocol
    func loadAccountCards()
}

class PaymentPresenter: PaymentPresenterProtocol {
    
    weak var paymentView: PaymentViewProtocol!
    private var formChecker: FormChecker =  FormChecker()
    private var dataManager: DataManager = DataManager()
    private var alertFactory: AlertProtocol = AlertFactory()
    private var firebaseManager: FirebaseManager = FirebaseManagerImpl()
    var userCards: [Card] = []
    
    func isPaymentDataValid(amount: String) -> Bool {
        return formChecker.checkPaymentData(amount: amount)
    }
    func makePayment(need: Need?, needNumber: Int, amount: Int) {
        if (need != nil && amount != 0) {
            dataManager.updateShelterNeed(needNumber: needNumber, need: need!, payment: amount) { [weak self] result in
                switch result {
                case .failure(_):
                    self?.paymentView?.showAlert(alert: self?.alertFactory.createErrorAlert(description: "Failed!") ?? UIAlertController())
                case .success(_):
                    self?.paymentView?.makeAnimationTransition()
                }
            }
        }
    }
    func getAlertProtocolImpl() -> AlertProtocol {
        return alertFactory
    }
    
    func loadAccountCards() {
        firebaseManager.getAccountCardsInfo(completion: { [weak self] result in
            switch result {
            case .success(let snapshot):
                let data = snapshot.value as? NSArray
                if data?.count != 0 && data != nil {
                    self?.userCards.removeAll()
                    for index in 1...data!.count - 1 {
                        guard let cardDictionary = data![index] as? NSDictionary else {return}
                        self?.userCards.append(Card(number: cardDictionary.value(forKey: "number") as? String ?? "",
                                                    owner: cardDictionary.value(forKey: "owner") as? String ?? "",
                                                    validityPeriod: cardDictionary.value(forKey: "validityPeriod") as? String ?? "",
                                                    code: String(cardDictionary.value(forKey: "code") as? Int ?? 0)))
                    }
                }
                DispatchQueue.main.async {
                    self?.paymentView.setUserCards(cards: self?.userCards ?? [])
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.paymentView.showAlert(alert:
                                                self?.alertFactory.createErrorAlert(
                                                    description: "Failed to log in! Please try again later!") ?? UIAlertController())
                }
            }
        })
    }
}
