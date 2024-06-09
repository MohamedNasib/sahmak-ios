//
//  LogoutView.swift
//  HitEgypt
//
//  Created by Mohamed Kelany on 15/03/2023.
//

import SwiftMessages
import Foundation
import Toaster


class LogoutView: MessageView {
    
    @IBAction func onTappedCloseButton(_ sender: UIButton) {
        SwiftMessages.hide()
    }
    
    @IBAction func onTappedConfirmButton(_ sender: UIButton) {
        logout(params: LogoutInput(deviceId: K_Defaults.string(forKey: Saved.PHONE_NUMBER) ?? ""))
        SwiftMessages.hide()
    }
    
    func logout(params: LogoutInput) {
        K_Network.sendRequest(function: apiService.logout(params: params), success: { (code, msg, response)  in
            self.logoutLocally()
        }) { (code, msg, errors) in
            self.logoutLocally()
        }
    }
    
    func logoutLocally() {
        K_Defaults.removeObject(forKey: Saved.TOKEN)
        K_Defaults.removeObject(forKey: Saved.USER_ID)
        K_Defaults.removeObject(forKey: Saved.COUNTRY_CODE)
        K_Defaults.removeObject(forKey: Saved.PHONE_NUMBER)
        K_Defaults.removeObject(forKey: Saved.USER_NAME)
        K_Defaults.removeObject(forKey: Saved.K_PopupNotifications)
        K_Defaults.removeObject(forKey: Saved.IS_VERIFIED)
        K_Defaults.removeObject(forKey: Saved.USER_PHOTO)
        
        K_AppDelegate.redirectToHome()
    }
}

