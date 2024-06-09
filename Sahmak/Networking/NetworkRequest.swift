//
//  NetworkRequest.swift
//  Qaim
//
//  Created by mac on 14/01/2023.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import ARSLineProgress
import Toaster

class NetworkRequest {

    func sendRequest(function:apiService, success:@escaping(_ code:String, _ msg:String, _ response :Response)->(), failure:@escaping (_ code:String, _ msg:String, _ errors :[String:[String]])->()) {

        ToastCenter.default.cancelAll()
        ARSLineProgress.show()
        
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
//        private lazy var provider = MoyaProvider<apiService>(session: session, plugins: [plugin])
        
        let provider = MoyaProvider<apiService>(plugins: [plugin])
        provider.request(function) { (result) in
            ARSLineProgress.hide()
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let Dic = try response.mapJSON() as! [String: Any]
                        let statusCode = (Dic["code"] as? Int) ?? 0
                        switch statusCode {
                        case 0:
                            success("", "", response)
                        case 103:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", [:])
                        case 200:
                            success("\(statusCode)", "\(Dic["message"] ?? "")", response)
                        case 400:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", [:])
                        case 401:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", [:])
                        case 402:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", [:])
                        case 403:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", [:])
                        case 404:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", [:])
                        case 422:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", (Dic["errors"] as! [String : [String]]))
                        case 500:
                            failure("\(statusCode)", "\(Dic["message"] ?? "")", [:])
                        default:
//                            Toast(text: K_Server_Error).show()
                            print("\(K_Server_Error)")
                        }
                    } catch {
                        print("\(K_Parse_Error)")
//                        Toast(text:K_Parse_Error ).show()
                    }
                case .failure(let error):
                    print("\(error.localizedDescription)")

//                    Toast(text: error.localizedDescription).show()
                }
            }
        }
    }
}
