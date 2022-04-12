//
//  StartAssembly.swift
//  project
//
//  Created by Evelina on 04.04.2022.
//

import Foundation
import UIKit

class StartAssembly: NSObject {
    
    @IBOutlet weak var startViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let view = startViewController as? StartViewController else {return}
        let startPresenter = StartPresenter()
        view.startPresenter = startPresenter
    }
}
