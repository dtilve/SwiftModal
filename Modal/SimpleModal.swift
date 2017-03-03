//
//  SimpleModal.swift
//  Modal
//
//  Created by Dana Tilve on 15/10/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import Foundation
import Result
import ReactiveCocoa
import UIKit

final class SimpleModal: ModalViewModelType {

    // Button Observation
    var (confirmButtonSignal, confirmPressedObserver) = Signal<Void, NoError>.pipe()
    var (cancelButtonSignal, cancelPressedObserver) = Signal<Void, NoError>.pipe()
    
    var presentationControllerSettings: PresentationControllerSettings {
        return PresentationControllerSettings(maximumWidth: 200,
                                              minimumPadding: 20,
                                              dimmingColor: UIColor.blackColor(),
                                              blurredDim: true)
    }
    
    // Texts
    var messageSettings: TextSettings {
        return TextSettings(text: "Hello!", textColor: UIColor.blackColor())
    }
    
    // Buttons
    var confirmButtonSettings: ButtonSettings {
        return ButtonSettings(title: "Ok!",
                              titleColor: UIColor.whiteColor(),
                              backgroundColor: UIColor.blackColor())
    }

}
