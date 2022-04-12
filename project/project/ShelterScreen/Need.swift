//
//  Need.swift
//  project
//
//  Created by Evelina on 28.03.2022.
//

import Foundation

class Need: NSObject {
    var title: String
    var progressFull: Float
    var shelterId: String
    var collectedAmount: Int
    var requiredAmount: Int
    
    init(title: String, shelterId: String, collectedAmount: Int, requiredAmount: Int) {
        self.title = title
        self.progressFull = Float(collectedAmount * 100 / requiredAmount)
        self.shelterId = shelterId
        self.requiredAmount = requiredAmount
        self.collectedAmount = collectedAmount
    }
    init(title: String, shelterId: String, requiredAmount: Int) {
        self.title = title
        self.shelterId = shelterId
        self.requiredAmount = requiredAmount
        self.collectedAmount = 0
        self.progressFull = 0
    }
}
