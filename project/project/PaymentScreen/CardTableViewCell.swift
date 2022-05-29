//
//  CardTableViewCell.swift
//  project
//
//  Created by Evelina on 23.05.2022.
//

import Foundation
import UIKit

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    func configure(card: Card) {
        numberLabel.text = card.number
    }
}
