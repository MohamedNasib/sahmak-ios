//
//  UITableView+Extensions.swift
//
//  Created by hassan on 11/11/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UITableViewCell>(cell: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forHeaderFooterViewReuseIdentifier: T.reusableIdentifier)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell

    }
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reusableIdentifier) as? T else {
            fatalError("Could not dequeue header/footer view with identifier: \(T.reusableIdentifier)")
        }
        return view
    }
}

