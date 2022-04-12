//
//  PaymentViewController.swift
//  project
//
//  Created by Evelina on 07.04.2022.
//

import UIKit
import FirebaseAuth

protocol PaymentViewProtocol: AnyObject {
    func showAlert(alert: UIAlertController)
}

class PaymentViewController: UIViewController, PaymentViewProtocol {
    
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textFieldForAmount: UITextField!
    @IBOutlet weak var cardPicker: UIButton!
    private let animationViewController = AnimationViewController()
    private var formChecker: FormChecker =  FormChecker()
    var need: Need?

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        errorLabel.isHidden = true
        paymentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTap() {
//        if formChecker.checkPaymentData(amount: errorLabel.text ?? "") {
            guard let animationViewController = UIStoryboard(name: "PaymentView", bundle: nil).instantiateViewController(withIdentifier: "AnimationViewController") as? AnimationViewController
            else { return }
            animationViewController.transitioningDelegate = self
            animationViewController.modalPresentationStyle = .fullScreen

            present(animationViewController, animated: true)
//        } else {
//            errorLabel.isHidden = false
//            errorLabel.text = "Not valid number!"
//        }
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
extension PaymentViewController: UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let fromVC = presenting as? PaymentViewController,
            let toVC = presented as? AnimationViewController else {return nil}
        return ZoomAnimator(fromViewController: fromVC, toViewController: toVC)
    }
}
