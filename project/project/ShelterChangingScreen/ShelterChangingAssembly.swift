//
//  ShelterChangingAssembly.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import UIKit

class ShelterChangingAssembly: NSObject {

    @IBOutlet weak var shelterChangingMethodController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = shelterChangingMethodController as? ShelterChangingViewController else {return}
        let shelterChangingPresenter = ShelterChangingPresenter()
        
        view.shelterChangingPresenter = shelterChangingPresenter
        shelterChangingPresenter.shelterView = view
    }
}
