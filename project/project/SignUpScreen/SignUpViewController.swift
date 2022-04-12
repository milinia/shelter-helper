//
//  SignUpViewController.swift
//  project
//
//  Created by Evelina on 12.03.2022.
//

import UIKit
import FirebaseAuth

protocol SignUpPresenterProtocol: AnyObject {
    func signUp(email: String, password :String)
    func isEmailValid(email: String?) -> Bool
    func isPasswordValid(password: String?) -> Bool
    func getAlertProtocolImpl() -> AlertProtocol
}

protocol SignUpViewProtocol: AnyObject {
    func showAlert(alert: UIAlertController)
    func goToMapScreen()
}

class SignUpViewController:UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationErrorLabel: UILabel!
    
    var userPresenter: SignUpPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func signUp(_ sender: Any) {
        if !emailTextField.hasText || !passwordTextField.hasText {
            present(userPresenter.getAlertProtocolImpl().createErrorAlert(description: "Please fill both fiels!"), animated: true, completion: nil)
        } else {
            userPresenter.signUp(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    func goToMapScreen() {
        performSegue(withIdentifier: "showApp", sender: nil)
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    private func configure() {
        validationErrorLabel.isHidden = true;
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}
extension SignUpViewController: UITextFieldDelegate, SignUpViewProtocol {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailTextField:
            if !userPresenter.isEmailValid(email: textField.text) {
                validationErrorLabel.text = "This is not email"
                validationErrorLabel.isHidden = false
            }
            else{
                validationErrorLabel.isHidden = true
            }
        case passwordTextField:
            if !userPresenter.isPasswordValid(password: textField.text) {
                validationErrorLabel.text = "Password must contain 6 characters,at least one number and one letter"
                validationErrorLabel.isHidden = false
            } else {
                validationErrorLabel.isHidden = true
            }
        default:
            return true
        }
        return true
    }
}
