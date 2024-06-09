//
//  SignUpVC.swift
//  Qaim
//
//  Created by mac on 17/01/2023.
//

import UIKit
import SKCountryPicker
import Toaster
import SwiftValidator
import SwiftGradientButton

class SignInVC: ParentViewController, ValidationDelegate , UITextFieldDelegate {
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var imgCountryLogo: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgPassword: UIImageView!
    
    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var btnContinue: GradientButton!

    var countryCode = ""
    var presenter_doc: Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        txtPhone.text = "01125210680"
//        txtPassword.text = "12345678"
        
        setupTerms()
        imgCountryLogo.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCountryPressed(_:))))
        imgPassword.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imgPasswordPressed(_:))))
    }
    
    func setupTerms() {
        let text = "agree_terms_conditions".localized()
        lblTerms.text = text
        lblTerms.textColor = AppColorSystem.darkText.color
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "terms_of_service".localized())
        let range2 = (text as NSString).range(of: "privacy_policy".localized())
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColorSystem.primary.color, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColorSystem.primary.color, range: range2)
        lblTerms.attributedText = underlineAttriString
        lblTerms.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text_phone = txtPhone.text, !text_phone.isEmpty ,
           let text_password = txtPassword.text, !text_password.isEmpty
        {
            btnContinue.isEnabled = true
            btnContinue.startColor = UIColor(named: "Primary")!
            btnContinue.endColor = UIColor(named: "Secondary")!
            btnContinue.startPoint = CGPoint(x: 0.5, y: 0.5)
            btnContinue.endPoint = CGPoint(x: 1.0, y: 0.5)
            btnContinue.setTitleColor(UIColor.white ,for: .normal)
        }else{
            btnContinue.isEnabled = false
            btnContinue.startColor = UIColor(named: "#E3E6EA")!
            btnContinue.endColor = UIColor(named: "#E3E6EA")!
            btnContinue.startPoint = CGPoint(x: 0.5, y: 0.5)
            btnContinue.endPoint = CGPoint(x: 1.0, y: 0.5)
            btnContinue.setTitleColor(UIColor(named: "#B7BBC1") ,for: .normal)
        }
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = ("agree_terms_conditions".localized() as NSString).range(of: "terms_of_service".localized())
        let privacyRange = ("agree_terms_conditions".localized() as NSString).range(of: "privacy_policy".localized())
        if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: termsRange) {
            print("Tapped terms")
        } else if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: privacyRange) {
            print("Tapped privacy")
        }
    }
    
    @objc func viewCountryPressed(_ sender: UITapGestureRecognizer) {
        CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: SKCountryPicker.Country) in

            self?.lblCountryCode.text = country.dialingCode
            self?.imgCountryLogo.image = country.flag
            self?.countryCode = country.countryCode
        }
    }

    @objc func imgPasswordPressed(_ sender: UITapGestureRecognizer) {
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        // TODO: - replace this image with the hide password image
        imgPassword.image = UIImage(named: "Eye")
    }
    
    @IBAction func forgetPasswordPressed(_ sender: Any) {
        presentFull(ForgetPasswordVC.loadFromNib(), animated: true, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        normalizeFields()
        validator.registerField(txtPhone, rules: [RequiredRule(message: "")])
        validator.registerField(txtPassword, rules: [RequiredRule(message: "")])
        validator.validate(self)
    }
    
    func normalizeFields() {
        txtPhone.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtPassword.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
    }

    @IBAction func signUpPressed(_ sender: Any) {
        presentFull(SignUpVC.loadFromNib(), animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SignInVC {
    func validationSuccessful() {
        login(params: LoginInput(phoneNumber: txtPhone.text ?? "", password: txtPassword.text ?? ""))
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            (field as? UIView)?.superview?.superview?.layer.borderColor = UIColor.red.cgColor
        }
    }
}

extension SignInVC {

    func login(params: LoginInput) {
        K_Network.sendRequest(function: apiService.login(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: User.self, keyPath: "data")
                K_Defaults.set(auth.token, forKey: Saved.TOKEN)
                K_Defaults.set(auth.isVerified, forKey: Saved.IS_VERIFIED)
                K_Defaults.set(auth.profilePicture?.url, forKey: Saved.USER_PHOTO)
                // add firebase token
                let token = K_Defaults.string(forKey: Saved.FCM_TOKEN) ?? ""
                let deviceId = K_Defaults.string(forKey: Saved.DEVICE_TOKEN) ?? ""
//                let isVerified = K_Defaults.bool(forKey: Saved.IS_VERIFIED)
                self.addDevice(params: AddDeviceInput(token: token, deviceId: deviceId, type: "IOS"))
                K_Defaults.set(params.phoneNumber, forKey: Saved.PHONE_NUMBER)

            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func addDevice(params: AddDeviceInput) {
        K_Network.sendRequest(function: apiService.addDevice(params: params), success: { (code, msg, response)  in
            K_AppDelegate.redirectToHome()
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
