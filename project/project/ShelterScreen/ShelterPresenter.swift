//
//  ShelterPresenter.swift
//  project
//
//  Created by Evelina on 28.03.2022.
//

import Foundation
import UIKit

protocol ShelterPresenterProtocol {
    func getNeeds(shelter: Shelter?)
    func getAnimals(shelter: Shelter?)
    func getNeedsAmount() -> Int
    func getNeedByNumber(number: Int) -> Need
}

class ShelterPresenter: ShelterPresenterProtocol {
    
    var needs: [Need] = []
    var animals: [Animal] = []
    var dataManager: DataManager = DataManager()
    weak var shelterView: SheleterViewProtocol!
    var alertFactory: AlertProtocol = AlertFactory()
    
    func getNeeds(shelter: Shelter?) {
        dataManager.getShelterNeeds(shelterId: shelter?.shelterId ?? "") { [weak self] result in
            switch result {
            case .failure(_):
                self?.shelterView.showAlert(alert: self?.alertFactory.createErrorAlert(description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
            case .success(let querySnapshot):
                for document in querySnapshot!.documents {
                    let data = document.data() as NSDictionary
                    self?.needs.append(Need(title: data.value(forKey: "title") as? String ?? "",
                                            shelterId: shelter?.shelterId ?? "",
                                            collectedAmount: data.value(forKey: "collected_amount") as? Int ?? 0,
                                            requiredAmount: data.value(forKey: "required_amount") as? Int ?? 0))
                }
            }
        }
    }
    func getAnimals(shelter: Shelter?) {
        dataManager.getShelterAnimals(shelterId: shelter?.shelterId ?? "") { [weak self] result in
            switch result {
            case .failure(_):
                self?.shelterView.showAlert(alert: self?.alertFactory.createErrorAlert(description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
            case .success(let querySnapshot):
                for document in querySnapshot!.documents {
                    let data = document.data() as NSDictionary
                    self?.animals.append(Animal(title: data.value(forKey: "title") as? String ?? "",
                                                image: UIImage(named: data.value(forKey: "title") as? String ?? "")!))
                }
            }
        }
    }
    func getNeedsAmount() -> Int {
        return needs.count
    }
    func getNeedByNumber(number: Int) -> Need {
        return needs[number]
    }
}
