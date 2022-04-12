//
//  ResetPasswordAssembly.swift
//  project
//
//  Created by Evelina on 14.03.2022.
//

import Foundation
import UIKit

class ResetPasswordAssembly: NSObject{
    
    @IBOutlet weak var resetPasswordViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = resetPasswordViewController as? ResetPasswordViewController else{ return }
        let resetPasswordPresenter = ResetPasswordPresenter()
        resetPasswordPresenter.resetPasswordView = view
        view.userPresenter = resetPasswordPresenter
    }
}
