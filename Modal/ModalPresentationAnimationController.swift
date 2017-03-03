//
//  ModalPresentationAnimationController.swift
//  Modal
//
//  Created by Dana Tilve on 15/10/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import Foundation
import UIKit

public final class ModalPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let _isPresenting: Bool
    private static var Duration: NSTimeInterval = 0.5
    
    init(isPresenting: Bool) {
        _isPresenting = isPresenting
        super.init()
    }
    
}

extension ModalPresentationAnimationController {
    
    @objc public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return ModalPresentationAnimationController.Duration
    }
    
    @objc public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if _isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        } else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
}

private extension ModalPresentationAnimationController {
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey)
            else { return }
        
        let containerView = transitionContext.containerView()
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.center.y -= containerView.bounds.size.height
        
        containerView.addSubview(presentedControllerView)
        animateView(presentedControllerView, containerView: containerView, transitionContext: transitionContext)
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey) else { return }
        let containerView = transitionContext.containerView()
        animateView(presentedControllerView, containerView: containerView, transitionContext: transitionContext)
    }
    
    func animateView(presentedControllerView: UIView,
                     containerView: UIView,
                     transitionContext: UIViewControllerContextTransitioning) {
        let completedBlock: (completed: Bool) -> Void = {
            transitionContext.completeTransition($0)
        }
        UIView.animateWithDuration(ModalPresentationAnimationController.Duration,
                                   delay: 0.0,
                                   usingSpringWithDamping: 1.0,
                                   initialSpringVelocity: 0.0,
                                   options: .AllowUserInteraction,
                                   animations: { presentedControllerView.center.y += containerView.bounds.size.height },
                                   completion: completedBlock)
        
    }
}
