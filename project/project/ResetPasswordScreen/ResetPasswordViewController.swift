//
//  ResetPasswordViewController.swift
//  project
//
//  Created by Evelina on 14.03.2022.
//

import UIKit

protocol UserResetPassword{
    func resetPassword(email: String)
    func isEmailValid(email: String?)->Bool
    func getAlertProtocolImpl()->AlertProtocol
}

class ResetPasswordViewController: UIViewController {
    
    var userPresenter: UserResetPassword!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        if (userPresenter.isEmailValid(email: emailTextField.text)){
            userPresenter.resetPassword(email: emailTextField.text!)
        }else{
            showAlert(alert: userPresenter.getAlertProtocolImpl().createErrorAlert(description: "This is not a email!"))
        }
    }
    
    public func showAlert(alert: UIAlertController){
        present(alert, animated: true, completion: nil)
    }
    
    public func goToLoginScreen(){
        performSegue(withIdentifier: "toLoginScreen", sender: nil)
    }
}
