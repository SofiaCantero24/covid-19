//
//  CommonView.swift
//  CoronavirusApp
//
//  Created by Junior Sancho on 3/19/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//
import Foundation
import UIKit

extension UIView {
    class func loadFirstSubViewFromNib() -> UIView {
        return UINib(nibName: self.className, bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension UIViewController {
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
