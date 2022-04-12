//
//  CellForNeeds.swift
//  project
//
//  Created by Evelina on 28.03.2022.
//

import UIKit

class CellForNeeds: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    func configure(need: Need) {
        titleLabel.text = need.title
        progressView.trackTintColor = UIColor.systemGray6
        progressView.setProgress(need.progressFull / 100, animated: true)
    }
}
