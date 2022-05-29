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
    func setAnimals(animals: [Animal])
    func setNeeds(needs: [Need])
}

class ShelterViewController: UIViewController, SheleterViewProtocol {
    
    @IBOutlet weak var vkLink: UIImageView!
    @IBOutlet weak var siteLink: UIImageView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var aboutShelterTextView: UITextView!
    
    var shelter: Shelter?
    var needsForShelter: [Need] = []
    var animalInShelter: [Animal] = []
    var shelterPresenter: ShelterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        shelterPresenter.loadNeeds(shelter: shelter)
        shelterPresenter.loadAnimals(shelter: shelter)
    }
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
                tableView.isHidden = true
                vkLink.isHidden = false
                siteLink.isHidden = false
                phoneLabel.isHidden = false
                aboutShelterTextView.isHidden = false
        case 1:
                tableView.isHidden = false
                vkLink.isHidden = true
                siteLink.isHidden = true
                phoneLabel.isHidden = true
                aboutShelterTextView.isHidden = true
                tableView.reloadData()
        case 2:
                tableView.isHidden = false
                vkLink.isHidden = true
                siteLink.isHidden = true
                phoneLabel.isHidden = true
                aboutShelterTextView.isHidden = true
                tableView.reloadData()
        default:
            break
        }
    }
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        segmentedControl.selectedSegmentIndex = 0
        tableView.isHidden = true
        phoneLabel.text = shelter?.phoneNumber
        navigationBar.title = shelter?.title
        aboutShelterTextView.text = shelter?.about
        //navigationBar.backBarButtonItem?.tintColor = UIColor(.gray)
        
        let tapForVkLink = UITapGestureRecognizer(target: self, action: #selector(goToShelterVk))
        let tapForSiteLink = UITapGestureRecognizer(target: self, action: #selector(goToShelterSite))
        let tapForPhoneNumber = UITapGestureRecognizer(target: self, action: #selector(goToPhoneNumber))
        
        vkLink.isUserInteractionEnabled = true
        siteLink.isUserInteractionEnabled = true
        phoneLabel.isUserInteractionEnabled = true
        
        vkLink.addGestureRecognizer(tapForVkLink)
        siteLink.addGestureRecognizer(tapForSiteLink)
        phoneLabel.addGestureRecognizer(tapForPhoneNumber)
        
        segmentedControl.selectedSegmentTintColor = UIColor(redN: 78, greenN: 191, blueN: 167, alphaN: 0.5)
        
        segmentedControl.setTitle("Shelter", forSegmentAt: 0)
        segmentedControl.setTitle("Needs", forSegmentAt: 1)
        segmentedControl.setTitle("Animals", forSegmentAt: 2)
    }
    @objc func goToPhoneNumber() {
        let number = getPhoneNumbers(number: shelter?.phoneNumber)
        if let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
    }
    @objc func goToShelterVk(){
        if let url = URL(string: shelter?.linkToVK ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
    }
    @objc func goToShelterSite(){
        if let url = URL(string: shelter?.linkToSite ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
    }
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    func setAnimals(animals: [Animal]) {
        animalInShelter = animals
    }
    
    func setNeeds(needs: [Need]) {
        needsForShelter = needs
    }
    private func getPhoneNumbers(number: String?) -> String {
        var formatedNumber: String = ""
        if number == nil {
            return ""
        } else {
            number?.forEach({ char in
                if char.isNumber {
                    formatedNumber.append(char)
                }
            })
        }
        if formatedNumber.count == 11 {
            return formatedNumber
        } else {
            return ""
        }
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
                                                           bundle: nil)
                    .instantiateViewController(withIdentifier: "PaymentViewController")
                    as? PaymentViewController else { return }
            paymentViewController.need = needsForShelter[indexPath.row]
            paymentViewController.needNumber = indexPath.row + 1
            paymentViewController.modalPresentationStyle = .fullScreen
            present(paymentViewController, animated: true, completion: nil)
        } else if segmentedControl.selectedSegmentIndex == 2 {
            guard let animalDetailViewController = UIStoryboard(name: "SignUpView",
                                                           bundle: nil)
                    .instantiateViewController(withIdentifier: "AnimalDetailViewController")
                    as? AnimalDetailViewController else { return }
            animalDetailViewController.animal = animalInShelter[indexPath.row]
            animalDetailViewController.modalPresentationStyle = .fullScreen
            present(animalDetailViewController, animated: true, completion: nil)
        }
    }
}
