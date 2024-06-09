//
//  ContactUSVC.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit
import Toaster

class ContactUSVC: ParentViewController {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtYouPhoneNumber: UITextField!
    @IBOutlet weak var txtMessage: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        contactUs()
    }
    
    @IBAction func btnSendPressed(_ sender: Any) {
        contactUsForm(params: ContactUsInput(email: txtEmail.text ?? "", phoneNumber: txtYouPhoneNumber.text ?? "", message: txtMessage.text ?? "", name: txtFullName.text ?? ""))
    }
}


extension ContactUSVC {
    
    func contactUs() {
        K_Network.sendRequest(function: apiService.contactUs, success: { (code, msg, response)  in
            do {
                let response = try response.map(to: GetContactUsResponse.self, keyPath: "data")
                self.lblAddress.text = response.address
                self.lblEmail.text = response.email
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    
    func contactUsForm(params : ContactUsInput) {
        K_Network.sendRequest(function: apiService.sendContactUs(params: params), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: Card.self, keyPath: nil)
                if response.code == 200 {
                    Toast(text: response.message).show()
                }else{
                    Toast(text: response.message).show()
                }
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}
