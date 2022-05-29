//
//  AddingAnimalAssembly.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import UIKit

class AddingAnimalAssembly: NSObject {
    
    @IBOutlet weak var addingAnimalController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = addingAnimalController as? AddingAnimalViewController else {return}
        let addingAnimalPresenter = AddingAnimalPresenter()
        
        view.addingAnimalPresenter = addingAnimalPresenter
        addingAnimalPresenter.addingAnimalView = view
    }
}
