//
//  PaymentViewController.swift
//  project
//
//  Created by Evelina on 07.04.2022.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var paymentView: UIView!
    private let animationViewController = AnimationViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        paymentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTap() {
        guard let animationViewController = UIStoryboard(name: "PaymentView", bundle: nil).instantiateViewController(withIdentifier: "AnimationViewController") as? AnimationViewController
        else { return }
        animationViewController.transitioningDelegate = self
        animationViewController.modalPresentationStyle = .fullScreen

        present(animationViewController, animated: true)
    }
    
    // MARK: - Navigation
}
extension PaymentViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let fromVC = presenting as? PaymentViewController,
                     let toVC = presented as? AnimationViewController else {return nil}
        return ZoomAnimator(fromViewController: fromVC, toViewController: toVC)
    }
}
