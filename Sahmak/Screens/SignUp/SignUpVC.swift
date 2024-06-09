//
//  SignUpVC.swift
//  Sahmak
//
//  Created by mac on 09/04/2023.
//

import UIKit
import SKCountryPicker
import SwiftValidator
import Toaster
import SwiftGradientButton

class SignUpVC: ParentViewController, ValidationDelegate , UITextFieldDelegate {
    
    @IBOutlet weak var imgCountryLogo: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgPassword: UIImageView!
    @IBOutlet weak var imgPasswordValidated: UIImageView!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var imgConfirmPassword: UIImageView!
    @IBOutlet weak var imgConfirmPasswordValidated: UIImageView!
    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var btnContinue: GradientButton!
    
    var signupParams: SignUpInput?

    var countryCode = "+20"
    var presenter_doc: Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTerms()
        imgCountryLogo.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCountryPressed(_:))))
        imgPassword.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imgPasswordPressed(_:))))
        imgConfirmPassword.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imgConfirmPasswordPressed(_:))))
        txtPassword.isSecureTextEntry = true
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
        guard  txtPassword.text?.count ?? 0 >= 8 else { imgPasswordValidated.isHidden = true ; return}
        imgPasswordValidated.isHidden = false
        guard  txtConfirmPassword.text == txtPassword.text else { imgConfirmPasswordValidated.isHidden = true ; return}
        imgConfirmPasswordValidated.isHidden = false
        let text_password = txtPassword.text
        let text_confirm_password = txtConfirmPassword.text
        if !(txtPhone.text?.isEmpty ?? false), !(txtPassword.text?.isEmpty ?? false) ,!(txtConfirmPassword.text?.isEmpty ?? false) ,
            text_confirm_password  == text_password
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
    }
    
    @objc func imgConfirmPasswordPressed(_ sender: UITapGestureRecognizer) {
        txtConfirmPassword.isSecureTextEntry = !txtConfirmPassword.isSecureTextEntry
    }

    @IBAction func signInPressed(_ sender: Any) {
//        dismiss(animated: true)
        self.presentFull(SignInVC.loadFromNib(), animated: true, completion: nil)
    }

    @IBAction func signUpPressed(_ sender: Any) {
        normalizeFields()
        validator.registerField(txtPhone, rules: [RequiredRule(message: "")])
        validator.registerField(txtPassword, rules: [RequiredRule(message: "")])
        validator.registerField(txtConfirmPassword, rules: [RequiredRule(message: ""), ConfirmationRule(confirmField: txtPassword, message: "")])
        validator.validate(self)
    }
    
    func normalizeFields() {
        txtPhone.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtPassword.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtConfirmPassword.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SignUpVC {
    func validationSuccessful() {
        signupParams = SignUpInput(phoneNumber: txtPhone.text ?? "", password: txtPassword.text ?? "", confirmPassword: txtConfirmPassword.text ?? "")
        K_Defaults.set(self.countryCode, forKey: Saved.COUNTRY_CODE)
        K_Defaults.set(txtPhone.text ?? "", forKey: Saved.PHONE_NUMBER)
        let verificationVC = VerificationVC.loadFromNib()
        verificationVC.signupParams = signupParams
        self.presentFull(verificationVC, animated: true, completion: nil)
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            (field as? UIView)?.superview?.superview?.layer.borderColor = UIColor.red.cgColor
        }
    }
}
