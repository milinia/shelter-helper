//
//  Assembly.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import Foundation
import UIKit

class SignUpAssembly: NSObject {
    
    @IBOutlet weak var signUpViewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let view = signUpViewController as? SignUpViewController else{ return }
        let signUpPresenter = SignUpPresenter(formChecker: FormChecker(), alertFactory: AlertFactory(), firebaseManager: FirebaseManagerImpl())
        view.userPresenter = signUpPresenter
        signUpPresenter.signUpView = view
    }
}
