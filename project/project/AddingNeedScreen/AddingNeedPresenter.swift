//
//  AddingNeedPresenter.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import Foundation
import UIKit

protocol AddingNeedPresenterProtocol {
    func saveNeed(needTitle: String, requiredAmount: Int, shelter: Shelter?)
}

class AddingNeedPresenter: AddingNeedPresenterProtocol {
    
    var dataManager = DataManager()
    var addingNeedView: AddingNeedViewProtocol?
    var alertFactory: AlertProtocol = AlertFactory()
    
    func saveNeed(needTitle: String, requiredAmount: Int, shelter: Shelter?) {
        guard let shelter = shelter else {return}

        dataManager.addNeed(needTitle: needTitle,
                            requiredAmount: requiredAmount,
                            shelterId: shelter.shelterId,
                            lastNeedNumber: shelter.lastNeedNumber ?? 0) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.addingNeedView?.showAlert(alert: self?.alertFactory.createInformationAlert(title: "Success", description: "Need was added!") ?? UIAlertController())
                }
                self?.dataManager.updateShelterLastNeedNumber(shelterId: shelter.shelterId, number: shelter.lastNeedNumber ?? 0 + 1)
            case .failure(_):
                DispatchQueue.main.async {
                    self?.addingNeedView?.showAlert(alert: self?.alertFactory.createErrorAlert(
                        description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
                }
            }
        }
    }
}
