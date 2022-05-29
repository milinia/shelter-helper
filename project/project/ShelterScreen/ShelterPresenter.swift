//
//  ShelterPresenter.swift
//  project
//
//  Created by Evelina on 28.03.2022.
//

import Foundation
import UIKit

protocol ShelterPresenterProtocol {
    func loadNeeds(shelter: Shelter?)
    func loadAnimals(shelter: Shelter?)
    func getNeedsAmount() -> Int
    func getNeeds() -> [Need]
    func getNeedByNumber(number: Int) -> Need
}

class ShelterPresenter: ShelterPresenterProtocol {
  
    var needs: [Need] = []
    var animals: [Animal] = []
    var dataManager: DataManager = DataManager()
    weak var shelterView: SheleterViewProtocol!
    var alertFactory: AlertProtocol = AlertFactory()
    
    func loadNeeds(shelter: Shelter?) {
        dataManager.getShelterNeeds(shelterId: shelter?.shelterId ?? "") { [weak self] result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.shelterView.showAlert(alert: self?.alertFactory.createErrorAlert(description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
                }
            case .success(let querySnapshot):
                for document in querySnapshot!.documents {
                    let data = document.data() as NSDictionary
                    self?.needs.append(Need(title: data.value(forKey: "title") as? String ?? "",
                                            shelterId: shelter?.shelterId ?? "",
                                            collectedAmount: data.value(forKey: "collected_amount") as? Int ?? 0,
                                            requiredAmount: data.value(forKey: "required_amount") as? Int ?? 0))
                }
                DispatchQueue.main.async {
                    self?.shelterView.setNeeds(needs: self?.needs ?? [])
                }
            }
        }
    }
    func loadAnimals(shelter: Shelter?) {
        dataManager.getShelterAnimals(shelterId: shelter?.shelterId ?? "") { [weak self] result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.shelterView.showAlert(alert: self?.alertFactory.createErrorAlert(description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
                }
            case .success(let querySnapshot):
                for document in querySnapshot!.documents {
                    let data = document.data() as NSDictionary
                    self?.animals.append(Animal(title: data.value(forKey: "title") as? String ?? "",
                                                imageNames: data.value(forKey: "image_id") as? [String] ?? [],
                                                text: data.value(forKey: "about") as? String ?? ""))
                }
                self?.setPhotoToAnimals(shelterId: shelter?.shelterId ?? "")
            }
        }
    }
    private func setPhotoToAnimals(shelterId: String) {
        animals.forEach { animal in
            for name in animal.imageNames {
                self.dataManager.getShelterAnimalPhoto(shelterId: shelterId,
                                                       imageName: name, completion: { [weak self] result in
                    switch result {
                    case .failure(_):
                        DispatchQueue.main.async {
                            self?.shelterView.showAlert(alert: self?.alertFactory.createErrorAlert(
                                description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
                        }
                    case .success(let animalImage):
                        animal.images.append(animalImage ?? UIImage())
                    }
                })
            }
        }
        DispatchQueue.main.async {
            self.shelterView.setAnimals(animals: self.animals ?? [])
        }
    }
    func getNeeds() -> [Need] {
        return needs
    }
    func getNeedsAmount() -> Int {
        return needs.count
    }
    func getNeedByNumber(number: Int) -> Need {
        return needs[number]
    }
}
