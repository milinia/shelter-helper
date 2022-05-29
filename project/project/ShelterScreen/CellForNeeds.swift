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
        progressView.progressTintColor = UIColor(redN: 78, greenN: 191, blueN: 167)
    }
}

extension UIColor {
    convenience init(redN: CGFloat, greenN: CGFloat, blueN: CGFloat, alphaN: CGFloat = 1) {
        self.init(
            red: redN / 255.0,
            green: greenN / 255.0,
            blue: blueN / 255.0,
            alpha: alphaN
        )
    }
}
