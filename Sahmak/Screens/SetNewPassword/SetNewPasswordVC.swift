//
//  SetNewPasswordVC.swift
//  Sahmak
//
//  Created by mac on 11/04/2023.
//

import UIKit
import Toaster

class SetNewPasswordVC: ParentViewController , UITextFieldDelegate {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var iconPasswordCorect: UIButton!
    @IBOutlet weak var iconShowPassword: UIButton!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var iconConfirmPasswordCorect: UIButton!
    @IBOutlet weak var iconShowConfirmPassword: UIButton!
    
    var showPasswordClick = true
    var showConfirmNewPasswordClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnContinuePressed(_ sender: Any) {
        let phone_number = K_Defaults.string(forKey: Saved.PHONE_NUMBER) ?? ""
        forgetPassword(params: ForgetPasswordInput(phoneNumber: phone_number, password: self.txtPassword.text ?? "", confirmPassword: self.txtConfirmPassword.text ?? ""))
    }
    
    @IBAction func btnShowNewPasswordPressed(_ sender: Any) {
        if showPasswordClick {
            txtPassword.isSecureTextEntry = false
            } else {
                txtPassword.isSecureTextEntry = true
            }
        showPasswordClick = !showPasswordClick
    }
    
    @IBAction func btnShowConfirmNewPasswordPressed(_ sender: Any) {
        if showConfirmNewPasswordClick {
            txtConfirmPassword.isSecureTextEntry = false
            } else {
                txtConfirmPassword.isSecureTextEntry = true
            }
        showConfirmNewPasswordClick = !showConfirmNewPasswordClick
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = txtPassword.text, !text.isEmpty , !(text.count < 8) {
            iconPasswordCorect.isHidden = false
        }else{
            iconPasswordCorect.isHidden = true
        }
        if let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty , !(confirmPassword.count < 8) , confirmPassword == txtPassword.text{
            iconConfirmPasswordCorect.isHidden = false
        }else{
            iconConfirmPasswordCorect.isHidden = true
        }
    }
    
    func forgetPassword(params: ForgetPasswordInput) {
        K_Network.sendRequest(function: apiService.forgetPassword(params: params), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: GetListFAQSResponse.self, keyPath: nil)
                if response.code == 200 {
                    Toast(text: msg).show()
                    let VC = SignInVC.loadFromNib()
                    self.presentFull(VC, animated: true, completion: nil)
                }else{
                    Toast(text: msg).show()
                }

            } catch {
            }
        }) { (code, msg, errors) in
                Toast(text: msg).show()
        }
    }

}
