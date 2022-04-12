//
//  ShelterAssembly.swift
//  project
//
//  Created by Evelina on 03.04.2022.
//

import Foundation
import UIKit

class ShelterAssembly: NSObject {
    
    @IBOutlet weak var shelterViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let view = shelterViewController as? ShelterViewController else {return}
        let shelterPresenter = ShelterPresenter()
        view.shelterPresenter = shelterPresenter
        shelterPresenter.shelterView = view
    }
}
