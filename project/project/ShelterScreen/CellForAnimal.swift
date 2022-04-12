//
//  CellForAnimal.swift
//  project
//
//  Created by Evelina on 10.04.2022.
//

import UIKit

class CellForAnimal: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    
    func configure(animal: Animal) {
        titleLabel.text = animal.title
        animalImage.image = animal.image
    }
}
