//
//  StartViewController.swift
//  project
//
//  Created by Evelina on 13.03.2022.
//

import UIKit
import FirebaseAuth

class StartViewController: UIViewController {
    
    var startPresenter: StartPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if startPresenter.isUserLoggedIn() {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            else{return}
            let screen = UIStoryboard(name: "SignUpView", bundle: nil)
                        .instantiateViewController(withIdentifier: "MapNavigationController")
            sceneDelegate.window?.rootViewController = screen
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    @IBAction func toSignUpPageButton(_ sender: Any) {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    @IBAction func toLoginPageButton(_ sender: Any) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
