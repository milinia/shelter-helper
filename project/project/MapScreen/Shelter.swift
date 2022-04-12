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
    var linkToIntagram: String?
    
    init(title: String?, coordinate: CLLocationCoordinate2D, linkToVK: String?, linkToIntagram: String?, shelterId: String) {
        self.title = title
        self.coordinate = coordinate
        self.linkToVK = linkToVK
        self.linkToIntagram = linkToIntagram
        self.shelterId = shelterId
    }
}
