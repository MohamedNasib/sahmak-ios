//
//  UICollectionView+Extension.swift
//
//  Created by hassan on 11/11/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionView {
    enum SupplementaryViewKind {
        case header
        case footer

        var rawValue: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
    
    var isLastItemFullyVisible: Bool {

        let numberOfItems = numberOfItems(inSection: 0)
        let lastIndexPath = IndexPath(item: numberOfItems - 1, section: 0)

        guard let attrs = collectionViewLayout.layoutAttributesForItem(at: lastIndexPath)
        else {
            return false
        }
        return bounds.contains(attrs.frame)
    }

    // If you don't care if it's fully visible, as long as some of it is visible
    var isLastItemVisible: Bool {
       let numberOfItems = numberOfItems(inSection: 0)
       return indexPathsForVisibleItems.contains(where: { $0.item == numberOfItems - 1 })
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UICollectionViewCell>(cell: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UICollectionReusableView>(view: T.Type, asSupplementaryViewKind kind: SupplementaryViewKind) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UICollectionReusableView>(view: T.Type, asSupplementaryViewKind kind: SupplementaryViewKind) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reusableIdentifier)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: SupplementaryViewKind, forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.reusableIdentifier)")
        }
        return view
    }
}

extension UICollectionViewFlowLayout {

    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        let isAr = K_Defaults.string(forKey: Saved.LANGUAGE) == "ar"
        if isAr {
            collectionView?.semanticContentAttribute = .forceRightToLeft
            return true
        } else {
            collectionView?.semanticContentAttribute = .forceLeftToRight
            return false
        }
    }

}
