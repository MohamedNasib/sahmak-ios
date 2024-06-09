//
//  UICollectionView+Extension.swift
//
//  Created by hassan on 11/11/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit


extension UIScrollView {
    
    func resizeScrollViewContentSize() {

        var contentRect = CGRect.zero

        for view in self.subviews {

            contentRect = contentRect.union(view.frame)

        }

        self.contentSize = contentRect.size

    }
}

