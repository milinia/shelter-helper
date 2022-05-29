//
//  Shelter.swift
//  project
//
//  Created by Evelina on 17.03.2022.
//

import Foundation
import MapKit

class Shelter: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var shelterId: String
    var linkToVK: String?
    var linkToSite: String?
    var phoneNumber: String?
    var about: String
    var lastAnimalPhotoId: Int?
    var lastNeedNumber: Int?
    
    init(title: String?, coordinate: CLLocationCoordinate2D, linkToVK: String?,
         linkToSite: String?, shelterId: String, phoneNumber: String?, about: String, lastAnimalPhotoId: Int?, lastNeedNumber: Int?) {
        self.title = title
        self.coordinate = coordinate
        self.linkToVK = linkToVK
        self.linkToSite = linkToSite
        self.shelterId = shelterId
        self.phoneNumber = phoneNumber
        self.about = about
        self.lastAnimalPhotoId = lastAnimalPhotoId
        self.lastNeedNumber = lastNeedNumber
    }
    init(title: String?, coordinate: CLLocationCoordinate2D, linkToVK: String?,
         linkToSite: String?, shelterId: String, phoneNumber: String?, about: String) {
        self.title = title
        self.coordinate = coordinate
        self.linkToVK = linkToVK
        self.linkToSite = linkToSite
        self.shelterId = shelterId
        self.phoneNumber = phoneNumber
        self.about = about
    }
}
