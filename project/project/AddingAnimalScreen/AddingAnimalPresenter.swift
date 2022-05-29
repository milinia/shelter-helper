//
//  AddingAnimalPresenter.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import Foundation
import UIKit

protocol AddingAnimalPresenterProtocol {
    func saveAnimal(images: [UIImage], name: String, animalInfo: String, shelter: Shelter?)
}

class AddingAnimalPresenter: AddingAnimalPresenterProtocol{
    
    private var dataManager = DataManager()
    var addingAnimalView: AddingAnimalViewProtocol?
    var alertFactory: AlertProtocol = AlertFactory()
    
    func saveAnimal(images: [UIImage], name: String, animalInfo: String, shelter: Shelter?) {
        guard let shelter = shelter else {return}
        var index = shelter.lastAnimalPhotoId ?? 0
        var imagesNames: [String] = []
        images.forEach { image in
            index += 1
            imagesNames.append(String(index))
            dataManager.uploadAnimalPhoto(image: image,
                                          shelterId: shelter.shelterId,
                                          imageName: String(index)) {[weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.addingAnimalView?.showAlert(alert: self?.alertFactory.createInformationAlert(title: "Success", description: "Need was added!") ?? UIAlertController())
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.addingAnimalView?.showAlert(alert: self?.alertFactory.createErrorAlert(
                            description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
                    }
                }
            }
        }
        let animal = Animal(title: name, imageNames: imagesNames, text: animalInfo)
        dataManager.addAnimal(animal: animal, shelterId: shelter.shelterId) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.addingAnimalView?.showAlert(alert: self?.alertFactory.createInformationAlert(title: "Success", description: "Need was added!") ?? UIAlertController())
                }
                self?.dataManager.updateShelterLastAnimalPhoto(shelterId: shelter.shelterId, number: imagesNames.count + (shelter.lastAnimalPhotoId ?? 0))
            case .failure(_):
                DispatchQueue.main.async {
                    self?.addingAnimalView?.showAlert(alert: self?.alertFactory.createErrorAlert(
                        description: "Failed to load shelter info. Please check your network connection!") ?? UIAlertController())
                }
            }
        }
    }
    
}
