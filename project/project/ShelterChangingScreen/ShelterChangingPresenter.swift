//
//  ShelterChangingPresenter.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import Foundation
import UIKit
import MapKit

protocol ShelterChangingPresenterProtocol {
    func loadShelter(shelterId: String)
}

class ShelterChangingPresenter: ShelterChangingPresenterProtocol {
    
    var dataManager = DataManager()
    var shelter: Shelter?
    var shelterView: ShelterChangingViewProtocol?
    var alertFactory: AlertProtocol = AlertFactory()
    
    func loadShelter(shelterId: String) {
        
        dataManager.getShelter(shelterId: shelterId) { [weak self] result in
            switch result {
            case .success(let docSnapshot):
                guard let data: NSDictionary = docSnapshot?.data() as? NSDictionary else { return }
                self?.shelter = Shelter(title: data.value(forKey: "title") as? String,
                                        coordinate: CLLocationCoordinate2D(
                                            latitude: data.value(forKey: "latitude") as? Double ?? 0,
                                            longitude: data.value(forKey: "longitude") as? Double ?? 0),
                                        linkToVK: data.value(forKey: "vk_link") as? String,
                                        linkToSite: data.value(forKey: "site_link") as? String,
                                        shelterId: data.value(forKey: "id") as? String ?? "",
                                        phoneNumber: data.value(forKey: "phone_number") as? String,
                                        about:  data.value(forKey: "about") as? String ?? "",
                                        lastAnimalPhotoId: data.value(forKey: "lastAnimalPhotoId") as? Int ?? 0,
                                        lastNeedNumber: data.value(forKey: "lastNeedNumber") as? Int ?? 0)
                DispatchQueue.main.async {
                    self?.shelterView?.setShelter(shelter: self?.shelter)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.shelterView?.showAlert(alert: self?.alertFactory.createErrorAlert(description:
                                            "Failed to load map. Please check your network connection!") ?? UIAlertController())
                }
            }
        }
    }
    
}
