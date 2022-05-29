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
    var images: [UIImage] = []
    var imageNames: [String]
    var text: String
    
    init(title: String, imageNames: [String], text: String) {
        self.title = title
        self.imageNames = imageNames
        self.text = text
    }
//    init(title: String, image1: UIImage, image2: UIImage?, image3: UIImage?, text: String) {
//        self.title = title
//        self.image1 = image1
//        self.image2 = image2
//        self.image3 = image3
//        self.text = text
//    }
}
