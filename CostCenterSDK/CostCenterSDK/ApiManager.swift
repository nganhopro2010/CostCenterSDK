//
//  ApiManager.swift
//  CollectData
//
//  Created by Ho Van Ngan on 09/03/2024.
//

import Foundation
import Alamofire

class ApiManager {
    public static let instance = ApiManager();
    private let urlString = "https://attribution.costcenter.net/appopen"

    func callAppOpen(params: [String: Any]) {
        NSLog("callAppOpen parameters = \(params)")
        Session.default.request(urlString, method: .get, parameters: params).responseDecodable(of: ResponseModel.self) { response in
            switch response.result {
            case .success(let value):
                NSLog("Success response Model: \(value)")
                break
                
            case .failure(let error):
                NSLog("Error: \(error.localizedDescription)")
                break
            }
        }
    }
}

struct ResponseModel: Decodable{}
