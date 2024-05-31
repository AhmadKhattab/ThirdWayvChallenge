//
//  PopAnimator.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import UIKit


/// PopAnimator is a custom Animator used to make
/// pop transition between view controllers
class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Properties
    let duration = 0.5
    // MARK: - Handle Animation
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        containerView.addSubview(toView)
        toView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(
            withDuration: duration,
            animations: {
                toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: { _ in
                transitionContext.completeTransition(true)
            }
        )
    }
}
