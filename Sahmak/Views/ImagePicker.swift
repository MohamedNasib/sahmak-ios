//
//  ImagePicker.swift
//  Garo
//
//  Created by Mohammed Abdelsalam on 8/4/20.
//  Copyright © 2020 3bdelsalam. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

typealias PickImageCompletion = (UIImage?) -> ()

class ImagePicker: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    static let shared = ImagePicker()
    
    var completion: PickImageCompletion!
    var viewController: UIViewController!
    
    
    func pickImage(viewController: UIViewController, completion: @escaping PickImageCompletion) {
        self.completion = completion
        self.viewController = viewController
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//        actionSheet.popoverPresentationController?.sourceView = self.viewController.view // works for both iPhone & iPad
        
        if let presenter = actionSheet.popoverPresentationController {
            presenter.sourceView = viewController.view
            presenter.sourceRect = viewController.view.bounds
            presenter.permittedArrowDirections = .any
        }
        
        actionSheet.view.tintColor = UIColor.black
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.checkForCameraPermission(vc: viewController)
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.checkForPhotoLibraryPermission(vc: viewController)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    func pickImage(viewController: UIViewController, frame: CGRect = CGRect.zero, completion: @escaping PickImageCompletion) {
        self.completion = completion
        self.viewController = viewController
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = UIColor.black
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.checkForCameraPermission(vc: viewController)
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.checkForPhotoLibraryPermission(vc: viewController)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let presenter = actionSheet.popoverPresentationController {
            presenter.sourceView = viewController.view
            presenter.sourceRect = frame
            presenter.permittedArrowDirections = .any
        }
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    private func camera() {
        DispatchQueue.main.async {
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "ok", style: .default, handler: { (alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                
                if let presenter = alertController.popoverPresentationController {
                    presenter.sourceView = self.viewController.view
                    presenter.sourceRect = self.viewController.view.bounds
                    presenter.permittedArrowDirections = .any
                }
                
                self.viewController.present(alertController, animated: true, completion: nil)
            } else {
                
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = UIImagePickerController.SourceType.camera
                myPickerController.allowsEditing = true
                self.viewController.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    private func photoLibrary() {
        DispatchQueue.main.async {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            myPickerController.allowsEditing = true
            self.viewController.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        viewController.dismiss(animated: true, completion: nil)
        if let completion = self.completion {
//            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage

            completion(image)
        }
    }
    
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        viewController.dismiss(animated: true, completion: nil)
//        if let completion = self.completion {
////            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//            let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage
//
//            completion(image)
//        }
//    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
        if let completion = self.completion {
            completion(nil)
        }
    }
    
    
    
    private func checkForPhotoLibraryPermission(vc: UIViewController) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .denied, .restricted:
                DispatchQueue.main.async {
                    let actionSheet = UIAlertController(title: "Photos Permission", message: "Please grant access for Photos in your settings.", preferredStyle: .alert)
                    actionSheet.view.tintColor = UIColor.black
                    actionSheet.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                        let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.open(settingsUrl)
                    }))
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    if let presenter = actionSheet.popoverPresentationController {
                        presenter.sourceView = self.viewController.view
                        presenter.sourceRect = self.viewController.view.bounds
                        presenter.permittedArrowDirections = .any
                    }
                    
                    vc.present(actionSheet, animated: true, completion: nil)
                }
            case .authorized:
                self.photoLibrary()
            default:
                break
            }
        }
    }
    
    
    private func checkForCameraPermission(vc: UIViewController) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized {
            self.camera()
            return
        }
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
            if granted {
                self.camera()
                return
            }
            
            DispatchQueue.main.async {
                let actionSheet = UIAlertController(title: "Camera Permission", message: "Please grant access for Camera in your settings.", preferredStyle: .alert)
                actionSheet.view.tintColor = UIColor.black
                actionSheet.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                    let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
                    UIApplication.shared.open(settingsUrl)
                }))
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                if let presenter = actionSheet.popoverPresentationController {
                    presenter.sourceView = self.viewController.view
                    presenter.sourceRect = self.viewController.view.bounds
                    presenter.permittedArrowDirections = .any
                }
                
                vc.present(actionSheet, animated: true, completion: nil)
            }
        }
    }
}

