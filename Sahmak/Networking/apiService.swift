//
//  apiService.swift
//  TaqeemTeacher
//
//  Created by ADEL ELGAZAR on 4/14/20.
//  Copyright © 2020 ADEL ELGAZAR. All rights reserved.
//

import Moya
import SwiftUI

enum apiService {
    // uploadPhoto
    case upload(file: Data)

    // home
    case home
    //categories
    case categories
    
    
    // property
    case propertyDetails(id: String)
    case saveProperty(id: String)
    case unSaveProperty(id: String)
    case sendProposal(id: String, params: SendProposalInput)
    case propertyFilter(params : PrpertyFilterInput)
    case savedproperty(params : SavedPrpertyInput)
    // user
    case signup(params: SignUpInput)
    case register(params: RegisterInput)
    case login(params: LoginInput)
    case verifyPhoneNumber(params: VerifyPhoneNumberInput)
    case forgetPassword(params: ForgetPasswordInput)
    case changePassword(params: ChangePasswordInput)
    case addDevice(params: AddDeviceInput)
    case getProfile
    case updateProfile(params: UpdateProfileInput)
    case logout(params: LogoutInput)
    
    // governorate
    case governorate
    
    // card
    case firstPayment
    case addCard(params: AddCardInput)
    case deleteCard(params: DeleteCardInput)
    case getCards(params: GetCardInput)
    
    // contactUs
    case contactUs
    case sendContactUs(params: ContactUsInput)
    
    // faq
    case faq(params: FAQInput)
    case askQuestion(params: AskQuestionInput)
    
    // appData
    case terms
}

// MARK: - TargetType Protocol Implementation
extension apiService: TargetType {
    var baseURL: URL { return URL(string: BaseUrl)! }
    
    var path: String {
        switch self {
            // uploadPhoto
        case .upload:
            return "/upload"
        
            // home
        case .home:
            return "/home"
            // categories
        case .categories:
            return "/property/filterationData"
            // property
        case .propertyDetails(let id):
            return "/property/\(id)"
        case .saveProperty(let id):
            return "/property/\(id)/save"
        case .unSaveProperty(let id):
            return "/property/\(id)/unsave"
        case .sendProposal(let id, _):
            return "/property/\(id)/proposal"
        case .propertyFilter:
            return "/property/filter"
        case .savedproperty:
            return "/property/savedProperties"
            // user
        case .signup:
            return "/user/signup"
        case .register:
            return "/user/register"
        case .login:
            return "/user/login"
        case .verifyPhoneNumber:
            return "/user/verify-phoneNumber"
        case .forgetPassword:
            return "/user/forget-password"
        case .changePassword:
            return "/user/change-password"
        case .addDevice:
            return "/user/add-device"
        case .getProfile:
            return "/user/profile"
        case .updateProfile:
            return "/user/profile"
        case .logout:
            return "/user/logout"
            
            // governorate
        case .governorate:
            return "/governorate"
            
            // card
        case .firstPayment:
            return "/card/first-payment"
        case .addCard:
            return "/card"
        case .deleteCard:
            return "/card"
        case .getCards:
            return "/card"
            
            // contactUs
        case .contactUs:
            return "/contactUs"
            
        case .sendContactUs:
            return "/contactUs/form"
            // faq
        case .faq:
            return "/faq"
        case .askQuestion:
            return "/faq"
            
            // appData
        case .terms:
            return "/appData/terms"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfile, .governorate, .getCards, .contactUs, .faq, .terms , .home , .propertyDetails , .propertyFilter , .categories , .savedproperty:
            return .get
            
        case .forgetPassword, .changePassword, .addDevice, .updateProfile, .addCard:
            return .patch
            
        case .deleteCard , .unSaveProperty:
            return .delete
            
        default:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        
        switch self {
            
            // user
        case .signup(let params):
            parameters = params.toDictionary ?? [:]
        case .sendProposal(_, let params):
            parameters = params.toDictionary ?? [:]
        case .propertyFilter(let params):
            parameters = params.toDictionary ?? [:]
        case .savedproperty(let params):
            parameters = params.toDictionary ?? [:]
        case .register(let params):
            parameters = params.toDictionary ?? [:]
        case .login(let params):
            parameters = params.toDictionary ?? [:]
        case .verifyPhoneNumber(let params):
            parameters = params.toDictionary ?? [:]
        case .forgetPassword(let params):
            parameters = params.toDictionary ?? [:]
        case .changePassword(let params):
            parameters = params.toDictionary ?? [:]
        case .addDevice(let params):
            parameters = params.toDictionary ?? [:]
        case .updateProfile(let params):
            parameters = params.toDictionary ?? [:]
        case .logout(let params):
            parameters = params.toDictionary ?? [:]
            // governorate
//        case .governorate(let params):
//            parameters = params.toDictionary ?? [:]
            
            // card
        case .addCard(let params):
            parameters = params.toDictionary ?? [:]
        case .deleteCard(let params):
            parameters = params.toDictionary ?? [:]
        case .getCards(let params):
            parameters = params.toDictionary ?? [:]
            
            // faq
        case .faq(let params):
            parameters = params.toDictionary ?? [:]
        case .askQuestion(let params):
            parameters = params.toDictionary ?? [:]
            
        default:
            parameters = [String: Any]()
        }
        return parameters
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .getProfile, .governorate, .getCards, .contactUs, .faq, .terms , .home , .propertyDetails, .propertyFilter , .categories , .savedproperty:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)
            
        case .upload(let file):
            var multipartData = [MultipartFormData]()
            multipartData.append(MultipartFormData(provider: .data(file), name: "file", fileName: "file.png", mimeType: "image/png"))
            return .uploadMultipart(multipartData)
            
        default:
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        print("Bearer: \(K_Defaults.string(forKey: Saved.TOKEN) ?? "")")
        var parameters = [String: String]()
        if !"\(K_Defaults.string(forKey: Saved.TOKEN) ?? "")".isEmpty {
            parameters["Authorization"] = "Bearer \(K_Defaults.string(forKey: Saved.TOKEN) ?? "")"
        }
        parameters["accept"] = "application/json"
        parameters["Content-Type"] = "application/json"
        return parameters
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
