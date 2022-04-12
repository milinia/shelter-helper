//
//  ShelterScreenViewController.swift
//  project
//
//  Created by Evelina on 07.03.2022.
//

import UIKit
import MapKit
import SwiftUI

protocol SheleterViewProtocol: AnyObject {
    func showAlert(alert: UIAlertController)
}

class ShelterViewController: UIViewController, SheleterViewProtocol {

    var shelter: Shelter?
    var needsForShelter: [Need] = []
    var animalInShelter: [Animal] = []
    var shelterPresenter: ShelterPresenterProtocol!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var vkLabel: UILabel!
    @IBOutlet weak var instaLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        needsForShelter.append(Need(title: "Покупка корма", shelterId: "1", collectedAmount: 70, requiredAmount: 100))
        needsForShelter.append(Need(title: "Покупка стирального порошка", shelterId: "1", collectedAmount: 0, requiredAmount: 100))
        needsForShelter.append(Need(title: "На лечение кошки", shelterId: "1", collectedAmount: 20, requiredAmount: 100))
        animalInShelter.append(Animal(title: "Кошка Люся", image: UIImage(named: "1")!))
        animalInShelter.append(Animal(title: "Кошка Маша", image: UIImage(named: "2")!))
        // shelterPresenter.getNeeds(shelter: shelter)
        // shelterPresenter.getAnimals(shelter: sheler)
    }
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
                titleLabel.text = shelter?.title
                tableView.isHidden = true
                titleLabel.isHidden = false
        case 1:
                tableView.isHidden = false
                titleLabel.isHidden = true
                tableView.reloadData()
        case 2:
                tableView.isHidden = false
                titleLabel.isHidden = true
                tableView.reloadData()
        default:
            break
        }
    }
    private func configure() {
        titleLabel.text = shelter?.title
//        vkLabel.isUserInteractionEnabled = true
//        instaLabel.isUserInteractionEnabled = true
//        vkLabel.text = shelter?.linkToVK
//        vkLabel.text = shelter?.linkToIntagram
        tableView.delegate = self
        tableView.dataSource = self
        segmentedControl.selectedSegmentIndex = 0
        tableView.isHidden = true
        segmentedControl.backgroundColor = UIColor(cgColor: CGColor(red: 78, green: 191, blue: 167, alpha: 0.5))
        segmentedControl.selectedSegmentTintColor = UIColor(cgColor: CGColor(red: 78, green: 191, blue: 167, alpha: 1))
        segmentedControl.setTitle("Shelter", forSegmentAt: 0)
        segmentedControl.setTitle("Needs", forSegmentAt: 1)
        segmentedControl.setTitle("Animals", forSegmentAt: 2)
    }
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
}
extension ShelterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 1 {
            return needsForShelter.count
        } else if segmentedControl.selectedSegmentIndex == 2 {
            return animalInShelter.count
        }
        return 0
        //return shelterPresenter.getNeedsAmount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "needCell", for: indexPath)
                    as? CellForNeeds else { return CellForNeeds()}
            // cell.configure(need: shelterPresenter.getNeedByNumber(number: indexPath.row))
            cell.configure(need: needsForShelter[indexPath.row])
            return cell
        } else if segmentedControl.selectedSegmentIndex == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath)
                    as? CellForAnimal else { return CellForAnimal()}
            cell.configure(animal: animalInShelter[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 1 {
            guard let paymentViewController = UIStoryboard(name: "PaymentView",
                                                           bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController")
                    as? PaymentViewController else { return }
            paymentViewController.need = needsForShelter[indexPath.row]
            paymentViewController.modalPresentationStyle = .fullScreen
            present(paymentViewController, animated: true, completion: nil)
        }
//        else if segmentedControl.selectedSegmentIndex == 2 {
//            return animalInShelter.count
//        }
    }
}
