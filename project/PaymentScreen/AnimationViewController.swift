//
//  PaymentViewController.swift
//  project
//
//  Created by Evelina on 07.04.2022.
//

import Foundation
import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var operationInProgressAnimator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMarkImage.isHidden = true
        statusLabel.isHidden = true
        setUpAnimations()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        paymentView.layer.cornerRadius = paymentView.layer.bounds.width / 2
        paymentView.layer.masksToBounds = true
    }
    func stopAnimations() {
        if operationInProgressAnimator.isRunning {
            operationInProgressAnimator.stopAnimation(true)
        }
    }
    private func setUpAnimations() {
        operationInProgressAnimator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2.0, delay: 4.0, options: .repeat, animations: {
            self.paymentView.transform = CGAffineTransform(scaleX: 12, y: 12)
            self.paymentView.alpha = 0
        }, completion: { _ in
            self.paymentView.alpha = 1
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn) {
                self.paymentView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.midY + 100)
            } completion: { _ in
                self.checkMarkImage.isHidden = false
                self.paymentView.isHidden = true
                self.statusLabel.isHidden = false
            }
        })
    }
}
