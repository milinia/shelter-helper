//
//  LoginAssably.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import Foundation

import UIKit

class LoginAssembly: NSObject{
    
    @IBOutlet weak var loginViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = loginViewController as? LoginViewController else{ return }
        let loginPresenter = LoginPresenter()
        loginPresenter.loginView = view
        view.loginPresenter = loginPresenter
    }
}
