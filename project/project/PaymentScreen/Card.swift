//
//  Card.swift
//  project
//
//  Created by Evelina on 20.05.2022.
//

import Foundation

class Card: NSObject{
    var number: String
    var owner: String
    var validityPeriod: String
    var code: String
    
    init(number: String, owner: String, validityPeriod: String, code: String) {
        self.number = number
        self.owner = owner
        self.validityPeriod = validityPeriod
        self.code = code
    }
}
