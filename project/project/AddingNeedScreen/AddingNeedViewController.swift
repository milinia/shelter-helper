//
//  AddingNeedViewController.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import UIKit

protocol AddingNeedViewProtocol {
    func showAlert(alert: UIAlertController)
}

class AddingNeedViewController: UIViewController, AddingNeedViewProtocol{

    @IBOutlet weak var needTitleTextField: UITextField!
    @IBOutlet weak var needMoneyAmountTextField: UITextField!
    var addingNeedPresenter: AddingNeedPresenterProtocol!
    var shelter: Shelter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveNeedAction(_ sender: Any) {
        addingNeedPresenter.saveNeed(needTitle: needTitleTextField.text ?? "",
                                     requiredAmount: Int(needMoneyAmountTextField.text ?? "0") ?? 0,
                                     shelter: shelter)
    }
}
