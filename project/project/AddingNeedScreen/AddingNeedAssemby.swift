//
//  AddingNeedAssemby.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import UIKit

class AddingNeedAssemby: NSObject {
    
    @IBOutlet weak var addingNeedController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = addingNeedController as? AddingNeedViewController else {return}
        let addingNeedPresenter = AddingNeedPresenter()
        
        view.addingNeedPresenter = addingNeedPresenter
        addingNeedPresenter.addingNeedView = view
    }
}
