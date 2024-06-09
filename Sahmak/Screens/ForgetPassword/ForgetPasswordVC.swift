//
//  ForgetPasswordVC.swift
//  Sahmak
//
//  Created by mac on 11/04/2023.
//

import UIKit
import Toaster
import SwiftGradientButton
import SKCountryPicker


class ForgetPasswordVC: ParentViewController , UITextFieldDelegate{

    @IBOutlet weak var txtPhhoneNumber: UITextField!
    @IBOutlet weak var btnContinue: GradientButton!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var imgCountryLogo: UIImageView!
    var countryCode = "+20"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func btnContinuePressed(_ sender: Any) {
        verfiyPhoneNumber()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty
        {
            btnContinue.isEnabled = true
            btnContinue.startColor = UIColor(named: "Primary")!
            btnContinue.endColor = UIColor(named: "Secondary")!
            btnContinue.startPoint = CGPoint(x: 0.5, y: 0.5)
            btnContinue.endPoint = CGPoint(x: 1.0, y: 0.5)
            btnContinue.tintColor = UIColor.white
        }else{
            btnContinue.isEnabled = false
            btnContinue.startColor = UIColor(named: "#E3E6EA")!
            btnContinue.endColor = UIColor(named: "#E3E6EA")!
            btnContinue.startPoint = CGPoint(x: 0.5, y: 0.5)
            btnContinue.endPoint = CGPoint(x: 1.0, y: 0.5)
            btnContinue.tintColor = UIColor(named: "#B7BBC1")

        }
    }
    
    
    func setupUI(){
        imgCountryLogo.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCountryPressed(_:))))
    }
    
    @objc func viewCountryPressed(_ sender: UITapGestureRecognizer) {
        CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: SKCountryPicker.Country) in

            self?.lblCountryCode.text = country.dialingCode
            self?.imgCountryLogo.image = country.flag
            self?.countryCode = country.countryCode
        }
    }
    
}



extension ForgetPasswordVC{
    
    func verfiyPhoneNumber() {
        K_Network.sendRequest(function: apiService.verifyPhoneNumber(params: VerifyPhoneNumberInput(phoneNumber: self.txtPhhoneNumber.text ?? "")), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: ForegetPasswordResponse.self, keyPath: nil)
                if response.code == 200 {
                    K_Defaults.set(self.txtPhhoneNumber.text, forKey: Saved.PHONE_NUMBER)
                    K_Defaults.set(self.countryCode, forKey: Saved.COUNTRY_CODE)
                    Toast(text: response.message).show()
                    
                    let verificationVC = VerificationVC.loadFromNib()
                    verificationVC.verifyParams = VerifyPhoneNumberInput(phoneNumber: self.txtPhhoneNumber.text ?? "")
                    self.presentFull(verificationVC, animated: true, completion: nil)
                }else{
                    Toast(text: response.message).show()
                }
            } catch {
            }
        }) { (code, msg, errors) in
            if code.elementsEqual("404") {
                Toast(text: msg).show()
            }
        }
    }
}
