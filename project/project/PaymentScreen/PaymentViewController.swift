//
//  PaymentViewController.swift
//  project
//
//  Created by Evelina on 07.04.2022.
//

import UIKit
import FirebaseAuth
import SwiftUI

protocol PaymentViewProtocol: AnyObject {
    func showAlert(alert: UIAlertController)
    func makeAnimationTransition()
    func setUserCards(cards: [Card])
}

class PaymentViewController: UIViewController, PaymentViewProtocol {
    
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var filledView: UIView!
    @IBOutlet weak var textFieldForAmount: UITextField!
    private let animationViewController = AnimationViewController()
    private var formChecker: FormChecker =  FormChecker()
    var need: Need?
    var needNumber: Int = 0
    var paymentPresenter: PaymentPresenterProtocol!
    var cards: [Card] = []
    var selectedCard: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentPresenter.loadAccountCards()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        errorLabel.isHidden = true
        paymentView.addGestureRecognizer(tapGesture)
        filledView.layer.cornerRadius = 10
        textFieldForAmount.delegate = self
        cardTableView.dataSource = self
        cardTableView.delegate = self
    }
    @objc func didTap() {
        if formChecker.checkPaymentData(amount: textFieldForAmount.text ?? "") {
            if selectedCard == -1 {
                errorLabel.isHidden = false
                errorLabel.text = "Choose payment method!"
            } else {
                errorLabel.isHidden = true
                let amount: Int? = Int(textFieldForAmount.text ?? "")
                paymentPresenter.makePayment(need: need, needNumber: needNumber, amount: amount ?? 0)
            }
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Empty field or zero amount!"
        }
    }
    func makeAnimationTransition() {
        guard let animationViewController = UIStoryboard(name: "PaymentView", bundle: nil).instantiateViewController(withIdentifier: "AnimationViewController") as? AnimationViewController
        else { return }
        animationViewController.transitioningDelegate = self
        animationViewController.modalPresentationStyle = .fullScreen

        present(animationViewController, animated: true)
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func goBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewCardAction(_ sender: Any) {
        performSegue(withIdentifier: "toNewCardScreen", sender: cards.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNewCardScreen", let userCardsNumber = sender as? Int {
            guard let destController = segue.destination as? AddingPaymentMethodViewController else {return}
            destController.numberOfUserCards = userCardsNumber
        }
    }
    
    func setUserCards(cards: [Card]){
        self.cards = cards
    }
}
extension PaymentViewController: UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let fromVC = presenting as? PaymentViewController,
            let toVC = presented as? AnimationViewController else {return nil}
        return ZoomAnimator(fromViewController: fromVC, toViewController: toVC)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "1234567890"
        let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharcterSet = CharacterSet(charactersIn: string)
        return allowedCharcterSet.isSuperset(of: typedCharcterSet)
    }
}
extension PaymentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
                as? CardTableViewCell else { return CardTableViewCell()}
        cell.configure(card: cards[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCard == -1 {
            selectedCard = indexPath.row
            if let cell = tableView.cellForRow(at: indexPath) {
                UIView.animate(withDuration: 0.3, animations: {
                    cell.contentView.backgroundColor = UIColor.systemGray5
                })
            }
        } else {
            if selectedCard == indexPath.row {
                selectedCard = -1
                if let cell = tableView.cellForRow(at: indexPath) {
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.contentView.backgroundColor = UIColor.white
                    })
                }
            } else {
                if let cell = tableView.cellForRow(at: IndexPath(item: selectedCard, section: 0)) {
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.contentView.backgroundColor = UIColor.white
                    })
                }
                selectedCard = indexPath.row
                if let newCell = tableView.cellForRow(at: indexPath) {
                    UIView.animate(withDuration: 0.3, animations: {
                        newCell.contentView.backgroundColor = UIColor.systemGray5
                    })
                }
            }
        }
    }
}
