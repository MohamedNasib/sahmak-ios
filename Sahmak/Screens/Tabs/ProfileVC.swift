//
//  ProfileVC.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit
import SwiftMessages

class ProfileVC: ParentViewController {
    
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var switchPopNotification: UISwitch!
    @IBOutlet weak var imgUserProfileImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserPhoneNumber: UILabel!
    
    @IBOutlet weak var personalDataView: UIView!
    @IBOutlet weak var ChangePasswordView: UIView!
    @IBOutlet weak var CreditCardView: UIView!
    @IBOutlet weak var DashBoardView: UIView!
    @IBOutlet weak var TutorialView: UIView!
    @IBOutlet weak var LanguageView: UIView!
    @IBOutlet weak var TermsView: UIView!
    @IBOutlet weak var ContactUsView: UIView!
    @IBOutlet weak var FAQsView: UIView!
    @IBOutlet weak var logOutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewsClick()
        self.loadImage(stringUrl: K_Defaults.string(forKey: Saved.USER_PHOTO) ?? "", placeHolder: UIImage(named: "userProfile"), imgView: self.imgUserProfileImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switchPopNotification.isOn   = K_Defaults.bool(forKey: Saved.K_PopupNotifications)
        self.loadImage(stringUrl: K_Defaults.string(forKey: Saved.USER_PHOTO) ?? "", placeHolder: UIImage(named: "userProfile"), imgView: self.imgUserProfileImage)
        lblUserName.text =  K_Defaults.string(forKey: Saved.USER_NAME)
        lblUserPhoneNumber.text = K_Defaults.string(forKey: Saved.PHONE_NUMBER)
    }
    
    func onViewsClick(){
        
        personalDataView.superview?.onTap(action: {
            self.presentFull(EditProfileVC.loadFromNib(), animated: true, completion: nil)
        })
        
        ChangePasswordView.superview?.onTap(action: {
            self.presentFull(ChangePasswordVC.loadFromNib(), animated: true, completion: nil)
        })
        
        
        CreditCardView.superview?.onTap(action: {
            self.presentFull(CreditCardsVC.loadFromNib(), animated: true, completion: nil)
        })
        
        DashBoardView.superview?.onTap(action: {
            self.presentFull(DashboardVC.loadFromNib(), animated: true, completion: nil)
        })
        
        TutorialView.superview?.onTap(action: {
            let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Tutorial")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        })
        
        LanguageView.superview?.onTap(action: {
            self.presentFull(LanguageVC.loadFromNib(), animated: true, completion: nil)
        })
        
        TermsView.superview?.onTap(action: {
            self.presentFull(TermsVC.loadFromNib(), animated: true, completion: nil)
        })
        
        ContactUsView.superview?.onTap(action: {
            self.presentFull(ContactUSVC.loadFromNib(), animated: true, completion: nil)
        })
        
        FAQsView.superview?.onTap(action: {
            self.presentFull(FAQsVC.loadFromNib(), animated: true, completion: nil)
        })
        
        logOutView.superview?.onTap(action: {
            self.openLogoutView()
        })
    }
    
    @IBAction func didSwitchChanged(_ sender: Any) {
        if (sender as AnyObject).isOn {
            print("Switch Is On")
            K_Defaults.set(true, forKey: Saved.K_PopupNotifications)
        }else{
            print("Switch Is Off")
            K_Defaults.set(false, forKey: Saved.K_PopupNotifications)
        }
    }
    
    private func openLogoutView() {
        let logoutView: LogoutView = try! SwiftMessages.viewFromNib()
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = .forever
        config.dimMode = .blur(style: .dark, alpha: 1, interactive: true)
        config.presentationContext  = .window(windowLevel: UIWindow.Level.statusBar)
        config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: config, view: logoutView)
    }
    
}

