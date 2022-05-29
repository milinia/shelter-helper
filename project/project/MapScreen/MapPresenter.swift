//
//  MapPresenter.swift
//  project
//
//  Created by Evelina on 07.03.2022.
//

import Foundation
import MapKit

class MapPresenter: MapPresenterProtocol {
    
    weak var mapView: MapViewProtocol!
    var alertFactory: AlertProtocol = AlertFactory()
    var shelters: [Shelter] = []
    var dataManager: DataManager = DataManager()
    
    func loadShelters() {
        dataManager.getShelters { [weak self] result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.mapView.showAlert(alert: self?.alertFactory.createErrorAlert(description:
                                            "Failed to load map. Please check your network connection!") ?? UIAlertController())
                }
            case .success(let querySnapshot):
                for document in querySnapshot!.documents {
                    let data = document.data() as NSDictionary
                    self?.shelters.append(Shelter(title: data.value(forKey: "title") as? String,
                                                  coordinate: CLLocationCoordinate2D(
                                                        latitude: data.value(forKey: "latitude") as? Double ?? 0,
                                                        longitude: data.value(forKey: "longitude") as? Double ?? 0),
                                                  linkToVK: data.value(forKey: "vk_link") as? String,
                                                  linkToSite: data.value(forKey: "site_link") as? String,
                                                  shelterId: data.value(forKey: "id") as? String ?? "",
                                                  phoneNumber: data.value(forKey: "phone_number") as? String,
                                                  about:  data.value(forKey: "about") as? String ?? ""))
                }
                DispatchQueue.main.async {
                    self?.mapView.addShelterAnnotations(shelters: self?.shelters ?? [])
                }
            }
        }
    }
    func getAlertProtocolImpl() -> AlertProtocol {
        return alertFactory
    }
    func getShelters() -> [Shelter] {
        return shelters
    }
    func getShelterByLocation(view: MKAnnotationView) -> Shelter? {
        let shelter = shelters.first { shelter in
            shelter.coordinate.latitude == view.annotation?.coordinate.latitude
            && shelter.coordinate.longitude == view.annotation?.coordinate.longitude
        }
        return shelter
    }
}
