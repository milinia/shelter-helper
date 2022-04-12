//
//  Animal.swift
//  project
//
//  Created by Evelina on 10.04.2022.
//

import Foundation
import SwiftUI

class Animal: NSObject {
    var title: String
    var image: UIImage
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }
}
