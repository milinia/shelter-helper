//
//  ShelterChangingViewController.swift
//  project
//
//  Created by Evelina on 29.05.2022.
//

import UIKit

protocol ShelterChangingViewProtocol {
    func showAlert(alert: UIAlertController)
    func setShelter(shelter: Shelter?)
}

class ShelterChangingViewController: UIViewController, ShelterChangingViewProtocol{

    @IBOutlet weak var navigationBar: UINavigationItem!
    var shelterChangingPresenter: ShelterChangingPresenterProtocol!
    var shelterInfo: ShelterInfo?
    var shelter: Shelter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.title = shelter?.title
        shelterChangingPresenter.loadShelter(shelterId: shelterInfo?.shelterId ?? "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddingAnimalScreen", let shelter = sender as? Shelter,
            let destController = segue.destination as? AddingAnimalViewController {
            destController.shelter = shelter
        } else if segue.identifier == "toAddingNeedScreen", let shelter = sender as? Shelter,
                    let destController = segue.destination as? AddingNeedViewController {
            destController.shelter = shelter
        }
    }
    
    func setShelter(shelter: Shelter?) {
        self.shelter = shelter
    }
    
    @IBAction func addNeedAction(_ sender: Any) {
        performSegue(withIdentifier: "toAddingNeedScreen", sender: shelter)
    }
    
    @IBAction func addAnimalAction(_ sender: Any) {
        performSegue(withIdentifier: "toAddingAnimalScreen", sender: shelter)
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
