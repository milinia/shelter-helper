//
//  LoginViewController.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import UIKit

protocol LoginPresenerProtocol{
    func login(email: String, password: String)
    func getAlertProtocolImpl() -> AlertProtocol
}

protocol LoginViewProtocol{
    func showAlert(alert: UIAlertController)
    func goToScreen(identifier: String, shelter: ShelterInfo)
}

class LoginViewController: UIViewController, LoginViewProtocol {
    
    var loginPresenter: LoginPresenerProtocol!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        
        if !emailTextField.hasText || !passwordTextField.hasText {
            present(loginPresenter.getAlertProtocolImpl().createErrorAlert(description: "Please fill both fiels!"), animated: true, completion: nil)
        }
        else {
            loginPresenter.login(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    func showAlert(alert: UIAlertController){
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShelterAccount", let shelter = sender as? ShelterInfo,
            let destController  = segue.destination as? ShelterChangingViewController {
            destController.shelterInfo = shelter
        }
    }
    
    func goToScreen(identifier: String, shelter: ShelterInfo){
        performSegue(withIdentifier: identifier, sender: shelter)
    }
}
