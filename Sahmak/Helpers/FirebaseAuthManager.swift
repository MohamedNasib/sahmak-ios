//
//  FirebaseAuthManager.swift
//  Sahmak
//
//  Created by mac on 13/05/2023.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    
    private let auth = Auth.auth()
    
    private var verificationId: String?
    
    public func verify(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        auth.languageCode = "en"
        guard let token = K_Defaults.data(forKey: Saved.DEVICE_TOKEN) else {
            return
        }
        auth.setAPNSToken(token, type: AuthAPNSTokenType.sandbox)

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            guard let verificationId = verificationID, error == nil else {
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
    }
    
    public func validate(code: String, completion: @escaping (Bool) -> Void) {
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
