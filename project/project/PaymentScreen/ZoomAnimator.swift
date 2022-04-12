//
//  Animator.swift
//  project
//
//  Created by Evelina on 08.04.2022.
//

import Foundation
import UIKit

final class ZoomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let fromViewController: UIViewController
    private let toViewController: UIViewController
    private let duration: TimeInterval = 1
    
    init(fromViewController: UIViewController, toViewController: UIViewController) {
        self.fromViewController = fromViewController
        self.toViewController = toViewController
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = toViewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        guard let fromVC = fromViewController as? PaymentViewController else {
            transitionContext.completeTransition(false)
            return
        }
        toView.alpha = 0
        containerView.addSubview(toView)
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear) {
            fromVC.paymentView.transform = CGAffineTransform(scaleX: 5, y: 5)
            toView.alpha = 1
        } completion: { _ in
            transitionContext.completeTransition(true)
            fromVC.paymentView.transform = .identity
        }
    }
}
