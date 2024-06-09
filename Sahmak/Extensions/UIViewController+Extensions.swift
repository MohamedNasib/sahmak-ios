//
//  UIViewController+Extensions.swift
//
//  Created by hassan on 11/9/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit
import Nuke

private func _swizzling(forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
       let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func loadImage(stringUrl: String, placeHolder: UIImage?, imgView: UIImageView) {
        if !stringUrl.isEmpty, let url = URL(string: stringUrl) {
            let options = ImageLoadingOptions(
                placeholder: placeHolder,
                transition: .fadeIn(duration: 0.0),
                failureImage: placeHolder
            )
            Nuke.loadImage(with: url, options: options, into: imgView)
        }
    }
    
    static let preventPageSheetPresentation: Void = {
        if #available(iOS 13, *) {
            _swizzling(forClass: UIViewController.self,
                       originalSelector: #selector(present(_: animated: completion:)),
                       swizzledSelector: #selector(_swizzledPresent(_: animated: completion:)))
        }
    }()
    
    @available(iOS 13.0, *)
    @objc private func _swizzledPresent(_ viewControllerToPresent: UIViewController,
                                        animated flag: Bool,
                                        completion: (() -> Void)? = nil) {
        if viewControllerToPresent.modalPresentationStyle == .pageSheet
            || viewControllerToPresent.modalPresentationStyle == .automatic {
            viewControllerToPresent.modalPresentationStyle = .fullScreen
        }
        _swizzledPresent(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    
    
    
    func showAlert(withMessage message : String , andTitle title : String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ButOk = UIAlertAction(title: "Done".localized(), style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ButOk)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlert(withErrorMessage message : String ) -> Void {
        showAlert(withMessage: message, andTitle: "Error".localized())
    }
    
    func showAlert(withMessage message : String ,
                   andTitle title : String? ,
                   doneTitle done: String,
                   cancelTitle cancel : String? ,
                   doneHandler : @escaping (UIAlertAction) -> Void ,
                   cancelHandler : ((UIAlertAction) -> Void)? = nil) -> Void {
        
        
        let mainAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ButOk = UIAlertAction(title: done, style: .default, handler: doneHandler)
        
        mainAlert.addAction(ButOk)
        
        
        if let cancel = cancel  , let cancelHandler = cancelHandler  {
            let ButOther = UIAlertAction(title: cancel, style: .default, handler: cancelHandler)
            mainAlert.addAction(ButOther)
            
        }
        self.present(mainAlert, animated: true, completion: nil)

    }

    
    
}

extension UIViewController {
    func dismissViewControllers() {

        guard let vc = self.presentingViewController else { return }

        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
    }

}

extension UIViewController {
    
    func presentFull(_ viewController: UIViewController , animated : Bool , completion : (() -> Void )?) -> Void {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: animated, completion: completion)
    }
    
    
}
