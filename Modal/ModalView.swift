//
//  ModalView.swift
//  Modal
//
//  Created by Dana Tilve on 29/09/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import Foundation
import UIKit

public final class ModalView: UIView {
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var crossCancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

}

public extension ModalView {

    public func configureModal(viewModel: ModalViewModelType) {
        configureButtons(viewModel)
        configureTexts(viewModel)
    }
    
}

private extension ModalView {

    func configureButtons(viewModel: ModalViewModelType) {
        configureConfirmButton(viewModel.confirmButtonSettings)
        if let settings = viewModel.cancelButtonSettings {
            configureCancelButton(settings)
        }
    }
    
    func configureTexts(viewModel: ModalViewModelType) {
        configureMessage(viewModel.messageSettings)
        if let settings = viewModel.titleSettings {
            configureTitle(settings)
        }
    }
    
    func configureConfirmButton(settings: ButtonSettings) {
        confirmButton.backgroundColor = settings.backgroundColor
        confirmButton.setTitle(settings.title, forState: .Normal)
        confirmButton.tintColor = settings.titleColor
    }
 
    func configureCancelButton(settings: ButtonSettings) {
        cancelButton.backgroundColor = settings.backgroundColor
        cancelButton.setTitle(settings.title, forState: .Normal)
        cancelButton.tintColor = settings.titleColor
    }
    
    func configureTitle(settings: TextSettings) {
        titleLabel.text = settings.text
        titleLabel.textColor = settings.textColor
    }
    
    func configureMessage(settings: TextSettings) {
        messageLabel.text = settings.text
        messageLabel.textColor = settings.textColor
    }
    
}
