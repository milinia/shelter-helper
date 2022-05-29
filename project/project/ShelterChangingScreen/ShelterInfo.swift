//
//  ShelterInfo.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import Foundation

class ShelterInfo{
    var shelterId: String
    var lastAnimalPhotoId: String?
    var lastNeedNumber: String?
    
    init(shelterId: String) {
        self.shelterId = shelterId
    }
}
