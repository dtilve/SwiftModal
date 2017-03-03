//
//  UIViewExtension.swift
//  Modal
//
//  Created by Dana Tilve on 29/09/16.
//  Copyright © 2016 Dana Tilve. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    class func loadFromNib<T: UIView>(bundle: NSBundle = NSBundle.mainBundle()) -> T {
        let nibName = NSStringFromClass(self).componentsSeparatedByString(".").last!
        return bundle.loadNibNamed(nibName, owner: self, options: nil)!.first as! T // swiftlint:disable:this force_cast
    }
    
}
