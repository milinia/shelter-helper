//
//  PhotoCollectionViewCell.swift
//  project
//
//  Created by Evelina on 19.05.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    func configure(animalPhoto: UIImage) {
        animalImageView.image = animalPhoto
    }
}
