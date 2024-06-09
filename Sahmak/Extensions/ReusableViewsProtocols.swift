//
//  ReusableViewsProtocols.swift
//
//  Created by hassan on 11/11/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: AnyObject {
    static var reusableIdentifier: String { get }
    static var kindIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
    static var kindIdentifier: String {
        return String(describing: self)
    }
}


protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
