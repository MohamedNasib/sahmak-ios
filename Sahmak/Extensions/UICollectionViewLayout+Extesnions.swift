//
//  UICollectionViewLayout+Extesnions.swift
//
//  Created by hassan on 11/11/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewLayout {
    func register<T: UICollectionReusableView>(decorationView: T.Type) where T: ReusableView {
        register(T.self, forDecorationViewOfKind: T.reusableIdentifier)
    }

    func register<T: UICollectionReusableView>(decorationView: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forDecorationViewOfKind: T.reusableIdentifier)
    }
}

