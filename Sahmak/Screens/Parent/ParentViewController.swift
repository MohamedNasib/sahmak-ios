//
//  ParentViewController.swift
//  Plstka
//
//  Created by FAB LAB on 13/03/2021.
//

import UIKit
//import InteractiveSideMenu
//import Toaster
import Mantis
import SwiftValidator

class ParentViewController: UIViewController, CropViewControllerDelegate {

//    let locationManager = CLLocationManager()
    let validator = Validator()
    var pageSize = 20

    override func viewDidLoad() {
        super.viewDidLoad()
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
    }

    @IBAction func btnBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    func redirectToHome() {
//        if (K_Defaults.string(forKey: Saved.token) ?? "").isEmpty {
//            let vc = SignInVC.loadFromNib()
//            K_AppDelegate.window?.rootViewController = vc
//        }
//        else {
//            let account_type = K_Defaults.string(forKey: Saved.account_type) ?? ""
//            switch account_type {
//            case AccountType.User.rawValue:
//                let navigationController = UINavigationController()
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "HostViewController")
//                navigationController.viewControllers = [vc]
//                K_AppDelegate.window?.rootViewController = navigationController
//            case AccountType.Company.rawValue:
//                let navigationController = UINavigationController()
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "CompanyHostViewController")
//                navigationController.viewControllers = [vc]
//                K_AppDelegate.window?.rootViewController = navigationController
//            case AccountType.Previewer.rawValue:
//                let navigationController = UINavigationController()
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "PreviewerHostViewController")
//                navigationController.viewControllers = [vc]
//                K_AppDelegate.window?.rootViewController = navigationController
//            default:
//                let navigationController = UINavigationController()
////                let storyboard = UIStoryboard(name: "Main", bundle: nil)
////                let vc = storyboard.instantiateViewController(withIdentifier: "PainterHostViewController")
//                let vc = EmployeeProjectsVC.loadFromNib()
//                navigationController.viewControllers = [vc]
//                K_AppDelegate.window?.rootViewController = navigationController
//            }
//        }
//    }
    
    
    func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func openWebView(urlString: String) {
//        let vc = WebViewVC.loadFromNib()
//        vc.urlString = urlString
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
}
