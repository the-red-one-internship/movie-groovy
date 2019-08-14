//
//  TransitionAnimator.swift
//  Movie Groovy
//
//  Created by admin on 14/08/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration = 0.6
    var presenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = toViewController.view
        let containerView = transitionContext.containerView
        if presenting {
            containerView.addSubview(toView!)
        }
        let bottomViewController = presenting ? fromViewController : toViewController
        let bottomPresentingView = bottomViewController.view
        let topViewController = presenting ? toViewController : fromViewController
        let topPresentedView = topViewController.view
        var topPresentedFrame = transitionContext.finalFrame(for: topViewController)
        if presenting {
            topPresentedFrame = CGRect(x: 0, y: 38, width: topPresentedFrame.width, height: topPresentedFrame.height - 38)
        }
        var topDismissedFrame = topPresentedFrame
        topDismissedFrame.origin.y += topDismissedFrame.size.height
        let topInitialFrame = presenting ? topDismissedFrame : topPresentedFrame
        let topFinalFrame = presenting ? topPresentedFrame : topDismissedFrame
        topPresentedView?.frame = topInitialFrame
        UIView.animate(withDuration: duration, animations: {() -> Void in
            topPresentedView?.frame = topFinalFrame
            let scalingFactor: CGFloat = self.presenting ? 0.91 : 1.0
            bottomPresentingView?.transform = CGAffineTransform.identity.scaledBy(x: scalingFactor, y: scalingFactor)
        }, completion: {(finished: Bool) -> Void in
            transitionContext.completeTransition(true)})
    }

}
