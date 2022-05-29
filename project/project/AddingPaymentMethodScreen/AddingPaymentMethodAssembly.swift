//
//  AddingPaymentMethodAssembly.swift
//  project
//
//  Created by Evelina on 26.05.2022.
//

import UIKit

class AddingPaymentMethodAssembly: NSObject {
    
    @IBOutlet weak var addingPaymentMethodController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = addingPaymentMethodController as? AddingPaymentMethodViewController else {return}
        let addingPaymentMethodPresenter = AddingPaymentMethodPresenter()
        
        view.addingPaymentMethodPresenter = addingPaymentMethodPresenter
        addingPaymentMethodPresenter.addingPaymentMethodView = view
    }
}
