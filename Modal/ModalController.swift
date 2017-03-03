//
//  ModalController.swift
//  Modal
//
//  Created by Dana Tilve on 29/09/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import Foundation
import Result
import Rex
import UIKit

public final class ModalController: UIViewController {
    
    lazy private var _view: ModalView = ModalView.loadFromNib()
    private let _viewModel: ModalViewModelType
    
    init(viewModel: ModalViewModelType) {
        _viewModel = viewModel
        super.init(nibName: .None, bundle: .None)
        transitioningDelegate = self
        modalPresentationStyle = .Custom
    }
    
    override public func loadView() {
        view = _view
        _view.configureModal(_viewModel)
    }
    
    public override func viewDidLoad() {
        configureButtons()
        super.viewDidLoad()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ModalController {
    
    private func configureButtons() {
        _view.confirmButton.rex_controlEvents(.TouchDown).ignoreError().startWithResult { [unowned self] _ in
            self._viewModel.confirmPressedObserver.sendNext(())
            self.dismissViewControllerAnimated(true, completion: .None)
        }
        
        _view.cancelButton.rex_controlEvents(.TouchDown).ignoreError().startWithResult { [unowned self] _ in
            self._viewModel.cancelPressedObserver.sendNext(())
            self.dismissViewControllerAnimated(true, completion: .None)
        }
    }
    
}

extension ModalController: UIViewControllerTransitioningDelegate {
    
    public func presentationControllerForPresentedViewController(presented: UIViewController,
                                       presentingViewController presenting: UIViewController?,
                                               sourceViewController source: UIViewController) -> UIPresentationController? {
            return ModalPresentationController(presentedViewController: presented, presentingViewController: presenting, settings: _viewModel.presentationControllerSettings)
    }
    
    public func animationControllerForPresentedController(presented: UIViewController,
                                    presentingController presenting: UIViewController,
                                            sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return ModalPresentationAnimationController(isPresenting: true)
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return ModalPresentationAnimationController(isPresenting: false)
    }
    
}
