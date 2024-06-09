//
//  GetCodeVC.swift
//  Sahmak
//
//  Created by Abdurrahman Alboghdady on 25/04/2023.
//

import UIKit
import OTPFieldView
import Toaster
import SwiftGradientButton


class VerificationVC: ParentViewController, OTPFieldViewDelegate {
    
    @IBOutlet weak var txtPhone: UILabel!
    
    @IBOutlet var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var btnChangePhone: UIButton!
    @IBOutlet weak var btnContinue: GradientButton!
    @IBOutlet weak var btnResendCode: UIButton!
    var otpCode = ""
    var firebaseAuthManger = FirebaseAuthManager.shared
    var signupParams: SignUpInput?
    var verifyParams: VerifyPhoneNumberInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpView()
        
        let phone_number = K_Defaults.string(forKey: Saved.PHONE_NUMBER) ?? ""
        let country_code = K_Defaults.string(forKey: Saved.COUNTRY_CODE) ?? ""
        verify(phoneNumber: "\(country_code)\(phone_number.deleteLeadingZeros())")
    }
    
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 1
        self.otpTextFieldView.defaultBorderColor = AppColorSystem.Border.color
        self.otpTextFieldView.filledBorderColor = AppColorSystem.primary.color
        self.otpTextFieldView.cursorColor = AppColorSystem.primary.color
        self.otpTextFieldView.displayType = .square
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = true
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
        for item in self.otpTextFieldView.subviews {
            item.layer.cornerRadius = 8
        }
    }
    
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        if hasEntered {
            btnContinue.isEnabled = true
            btnContinue.startColor = UIColor(named: "Primary")!
            btnContinue.endColor = UIColor(named: "Secondary")!
            btnContinue.startPoint = CGPoint(x: 0.5, y: 0.5)
            btnContinue.endPoint = CGPoint(x: 1.0, y: 0.5)
            btnContinue.setTitleColor(UIColor.white ,for: .normal)
        } else {
            btnContinue.isEnabled = false
            btnContinue.startColor = UIColor(named: "#E3E6EA")!
            btnContinue.endColor = UIColor(named: "#E3E6EA")!
            btnContinue.startPoint = CGPoint(x: 0.5, y: 0.5)
            btnContinue.endPoint = CGPoint(x: 1.0, y: 0.5)
            btnContinue.setTitleColor(UIColor(named: "#B7BBC1") ,for: .normal)
        }
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        otpCode = otpString
    }
    
    @IBAction func btnChangeNumberPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnContinuePressed(_ sender: Any) {
        validate(code: otpCode)
    }
    
    @IBAction func btnResendPressed(_ sender: Any) {
        let phone_number = K_Defaults.string(forKey: Saved.PHONE_NUMBER) ?? ""
        let country_code = K_Defaults.string(forKey: Saved.COUNTRY_CODE) ?? ""
        verify(phoneNumber: "\(country_code)\(phone_number.deleteLeadingZeros())")
    }
}

extension VerificationVC {
    func verify(phoneNumber: String) {
        firebaseAuthManger.verify(phoneNumber: phoneNumber, completion: { status in
            if status == true {
                print("success")
            } else {
                print("false")
            }
        })
    }
    
    func validate(code: String) {
        firebaseAuthManger.validate(code: code, completion: { status in
            if status == true {
                
                if let signupParams = self.signupParams {
                    self.signup(params: signupParams)
                } else if self.verifyParams != nil  {
                    let VC = SetNewPasswordVC.loadFromNib()
                    self.presentFull(VC, animated: true, completion: nil)
                }else{
                    Toast(text: "Signup parameters are missing").show()
                }
            } else {
                Toast(text: "invalid_otp").show()
            }
        })
    }
    
    
    func signup(params: SignUpInput) {
        K_Network.sendRequest(function: apiService.signup(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: User.self, keyPath: "data")
                K_Defaults.set(auth.userId, forKey: Saved.USER_ID)
                K_Defaults.set(params.phoneNumber, forKey: Saved.PHONE_NUMBER)
                K_Defaults.set(auth.isVerified , forKey: Saved.IS_VERIFIED)
                K_Defaults.set(auth.profilePicture?.url, forKey: Saved.USER_PHOTO)

                // display Register screen
                self.presentFull(RegisterVC.loadFromNib(), animated: true, completion: nil)
            } catch {
            }
        }) { (code, msg, errors) in
                Toast(text: msg).show()
        }
    }
}
