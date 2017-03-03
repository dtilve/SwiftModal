//
//  ModalViewModel.swift
//  Modal
//
//  Created by Dana Tilve on 29/09/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import ReactiveCocoa
import Result
import UIKit

public struct TextSettings {
    
    var text: String
    var textColor: UIColor
    
}

public struct ButtonSettings {
    
    var title: String
    var titleColor: UIColor
    var backgroundColor: UIColor

}

public struct PresentationControllerSettings {
    
    var maximumWidth: CGFloat
    var minimumPadding: CGFloat
    var dimmingColor: UIColor
    var blurredDim: Bool

}

public protocol ModalViewModelType {

    // Presentation Settings
    var presentationControllerSettings: PresentationControllerSettings { get }
    
    // Texts
    var titleSettings: TextSettings? { get }
    var messageSettings: TextSettings { get }
    
    // Buttons
    var confirmButtonSettings: ButtonSettings { get }
    var cancelButtonSettings: ButtonSettings? { get }
    
    // Button Observation
    var confirmButtonSignal: Signal<Void, NoError> { get }
    var cancelButtonSignal: Signal<Void, NoError> { get }
    var confirmPressedObserver: Observer<Void, NoError> { get }
    var cancelPressedObserver: Observer<Void, NoError> { get }
    
}

extension ModalViewModelType {

    var titleSettings: TextSettings? {
        return .None
    }
    
    var cancelButtonSettings: ButtonSettings? {
        return .None
    }

}
