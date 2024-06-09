//
//  UIStoryboard.swift
//  Bazzarry
//
//  Created by Mohamed Alhadadi ClickApps on 21/05/2022.
//

import UIKit

extension UIStoryboard {
}

/// this protocol is used to make UIViewController creation from storyboard more simpler. The default implementation will use the Self class name as the storyboard file name, then instantiate UIViewController with `storyboardId` if available otherwise instantiate initial UIViewController
protocol StoryboardLoadable: UIViewController {
    static var storyboardName: String { get }
    static var storyboardId: String? { get }
    static func instantiateFromStoryboard() -> Self
}

extension StoryboardLoadable {
    
    static var storyboardName: String {
        return String(describing: self)
    }
    
    static var storyboardId: String? {
        return nil
    }
    
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let storyboardId = storyboardId {
            return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
        } else {
            return storyboard.instantiateInitialViewController() as! Self
        }
    }
}
