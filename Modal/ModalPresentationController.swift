//
//  ModalPresentationController.swift
//  Modal
//
//  Created by Dana Tilve on 04/10/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import UIKit

public final class ModalPresentationController: UIPresentationController {
    
    private let _settings: PresentationControllerSettings
    
    lazy var dimmingView: UIView = {
        if self._settings.blurredDim {
            let style = UIBlurEffectStyle.Regular
            let effect = UIBlurEffect(style: style)
            let view = UIVisualEffectView(effect: effect)
            view.backgroundColor = self._settings.dimmingColor
            return view
        }
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = self._settings.dimmingColor
        return view
    }()
    
    init(presentedViewController: UIViewController,
         presentingViewController: UIViewController?,
         settings: PresentationControllerSettings) {
        _settings = settings
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
}

extension ModalPresentationController {
    
    typealias AnimationBlock = (context: UIViewControllerTransitionCoordinatorContext!) -> Void
    
    override public func frameOfPresentedViewInContainerView() -> CGRect {
        guard let containerView = containerView else { return CGRect() }
        return CGRectInset(containerView.bounds, 50.0, 50.0)
    }
    
    override public func presentationTransitionWillBegin() {
        dimmingView.frame = self.containerView!.bounds
        dimmingView.alpha = 0.0
        dimmingView.addSubview(containerView!)
        
        containerView!.addSubview(presentedView()!)
        presentedView()!.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
        
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        let decreaseDimmingViewTransparency: AnimationBlock = { [unowned self] _ in
            self.dimmingView.alpha  = 1.0
        }
        transitionCoordinator!.animateAlongsideTransition(decreaseDimmingViewTransparency, completion: .None)
    }
    
    override public func presentationTransitionDidEnd(completed: Bool) {
        if !completed { dimmingView.removeFromSuperview() }
    }
    
    override public func viewWillTransitionToSize(size: CGSize,
                                                  withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)
        let setDimmingViewFrame: AnimationBlock = { [unowned self] _ in
            self.dimmingView.frame = self.containerView!.bounds
        }
        transitionCoordinator.animateAlongsideTransition(setDimmingViewFrame, completion: .None)
    }
    
    override public func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        let increaseDimmingViewTransparency: AnimationBlock = { [unowned self] _ in
            self.dimmingView.alpha  = 0.0
        }
        transitionCoordinator!.animateAlongsideTransition(increaseDimmingViewTransparency, completion: .None)
    }
    
    override public func dismissalTransitionDidEnd(completed: Bool) {
        if completed { dimmingView.removeFromSuperview() }
    }
}

private extension ModalPresentationController {
    
    private func setConstraints() {
        setCenteringConstraints()
        setWidthConstraint()
        setLeadingConstraint()
        setTrailingConstraint()
    }
    
    private func setWidthConstraint() {
        let widthConstraint = presentedView()!.widthAnchor.constraintLessThanOrEqualToConstant(_settings.maximumWidth)
        widthConstraint.priority = 999
        widthConstraint.active = true
    }
    
    private func setLeadingConstraint() {
        let containerLeading = (containerView?.leadingAnchor)!
        let leadingConstraint = presentedView()!.leadingAnchor.constraintGreaterThanOrEqualToAnchor(containerLeading,
                                                                                                    constant: _settings.minimumPadding)
        leadingConstraint.priority = 975
        leadingConstraint.active = true
        
    }
    
    private func setTrailingConstraint() {
        let containerTrailing = (containerView?.trailingAnchor)!
        let trailingConstraint = presentedView()!.trailingAnchor.constraintLessThanOrEqualToAnchor(containerTrailing,
                                                                                                   constant: -_settings.minimumPadding)
        trailingConstraint.priority = 975
        trailingConstraint.active = true
    }
    
    private func setCenteringConstraints() {
        presentedView()!.centerXAnchor.constraintEqualToAnchor((containerView?.centerXAnchor)!).active = true
        presentedView()!.centerYAnchor.constraintEqualToAnchor((containerView?.centerYAnchor)!).active = true
    }
    
}
