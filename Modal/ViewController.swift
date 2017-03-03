//
//  ViewController.swift
//  Modal
//
//  Created by Dana Tilve on 29/09/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import UIKit
import Rex

final class MainController: UIViewController {

    lazy private var _view: MainView = MainView.loadFromNib()
    private let _viewModel: MainViewModel
    
    override func loadView() {
        view = _view
    }

    init(viewModel: MainViewModel) {
        _viewModel = viewModel
        super.init(nibName: .None, bundle: .None)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        bindButton()
    }
}

private extension MainController {
    
    func bindButton() {
        _view.button.rex_pressed.value =  _viewModel.showModalAction.unsafeCocoaAction
        
        _viewModel.showModalAction.values.observeNext { [unowned self] _ in
            self.showModal()
        }
    }

    func showModal() {
        let viewModel = SimpleModal()
        let controller = ModalController(viewModel: viewModel)
        dispatch_async(dispatch_get_main_queue()) { [unowned self] _ in
            self.presentViewController(controller, animated: true, completion: .None)
        }
    }
    
}
