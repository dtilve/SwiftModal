//
//  MainViewModel.swift
//  Modal
//
//  Created by Dana Tilve on 03/03/17.
//  Copyright © 2017 Dana Tilve. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

final class MainViewModel {

    private(set) lazy var showModalAction: Action<AnyObject, Void, NoError> = Action { _ in
        return SignalProducer(value: ())
    }
    
}
