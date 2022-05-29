//
//  PaymentAssembly.swift
//  project
//
//  Created by Evelina on 17.04.2022.
//

import Foundation
import UIKit

class PaymentAssembly: NSObject {
    @IBOutlet weak var paymentViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = paymentViewController as? PaymentViewController else {return}
        let paymentPresenter = PaymentPresenter()
        
        view.paymentPresenter = paymentPresenter
        paymentPresenter.paymentView = view
    }
}
