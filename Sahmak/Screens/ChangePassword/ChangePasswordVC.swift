//
//  ChangePasswordVC.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit
import Toaster

class ChangePasswordVC: ParentViewController {
    
    @IBOutlet weak var txtOldPaassword: UITextField!
    @IBOutlet weak var btnShowOldPaassword: UIButton!
    
    @IBOutlet weak var txtNewPaassword: UITextField!
    @IBOutlet weak var btnShowNewPaassword: UIButton!
    
    @IBOutlet weak var txtConfirmNewPaassword: UITextField!
    @IBOutlet weak var btnShowConfirmNewPaassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnResetPasswordPressed(_ sender: Any) {
        resetPassword(params: ChangePasswordInput(oldPassword: txtOldPaassword.text ?? "", newPassword: txtNewPaassword.text ?? "" , confirmPassword: txtConfirmNewPaassword.text ?? ""))
        
    }
    
    @IBAction func btnShowOldPasswordPressed(_ sender: Any) {
        txtOldPaassword.isSecureTextEntry = !txtOldPaassword.isSecureTextEntry
    }
    
    @IBAction func btnShowNewPasswordPressed(_ sender: Any) {
        txtNewPaassword.isSecureTextEntry = !txtNewPaassword.isSecureTextEntry
    }
    
    @IBAction func btnShowConfirmNewPasswordPressed(_ sender: Any) {
        txtConfirmNewPaassword.isSecureTextEntry = !txtConfirmNewPaassword.isSecureTextEntry
    }
}



extension ChangePasswordVC {
    
    func resetPassword(params: ChangePasswordInput) {
        K_Network.sendRequest(function: apiService.changePassword(params: params), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: ChangePasswordResponse.self, keyPath: nil)
                if response.code == 200 {
                    self.dismiss(animated: true)
                    print("message" , response.message)
                    Toast(text: response.message).show()
                } else {
                    print("message" , response.message)
                    Toast(text: response.message).show()
                }
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}

