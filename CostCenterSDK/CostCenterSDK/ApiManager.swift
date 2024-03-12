//
//  ApiManager.swift
//  CollectData
//
//  Created by Ho Van Ngan on 09/03/2024.
//

import Foundation

class ApiManager {
    static let instance = ApiManager()
    func callAppOpen(consent: Bool = false,vendorId: String?, bundleIdentifier: String? = "", firebaseAppInstanceID: String? = "", advertisingId: String? = "", platform: String? = "", attrToken: String? = "") {
        var parameters: [URLQueryItem] = []
        if !consent {
            parameters = [
                URLQueryItem(name: "firebase_app_instance_id", value: firebaseAppInstanceID ?? ""),
                URLQueryItem(name: "bundle_id", value: bundleIdentifier ?? ""),
                URLQueryItem(name: "platform", value: platform),
                URLQueryItem(name: "vendor_id", value:  vendorId ?? ""),
                URLQueryItem(name: "attribution_token", value: attrToken ?? ""),
                URLQueryItem(name: "advertising_id", value: advertisingId ?? ""),
            ]
        } else {
            parameters = [
                URLQueryItem(name: "firebase_app_instance_id", value: firebaseAppInstanceID ?? ""),
                URLQueryItem(name: "bundle_id", value: bundleIdentifier ?? ""),
                URLQueryItem(name: "platform", value: platform),
                URLQueryItem(name: "vendor_id", value:  vendorId ?? ""),
                URLQueryItem(name: "attribution_token", value: attrToken ?? ""),
                URLQueryItem(name: "advertising_id", value: advertisingId ?? ""),
                URLQueryItem(name: "consent", value: "true"),
            ]
        }
        CostCenterLogger(message: "callAppOpen parameters = \(parameters)")
        var components = URLComponents(string: "https://attribution.costcenter.net/appopen")!
        components.queryItems = parameters
        guard let url = components.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                CostCenterLogger(message: "Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                CostCenterLogger(message: "Invalid response")
                return
            }
            if !(200...299).contains(httpResponse.statusCode) {
                CostCenterLogger(message: "HTTP Response Error: \(httpResponse.statusCode)")
                return
            }
            CostCenterLogger(message: "statusCode = \(httpResponse.statusCode)")
        }
        task.resume()
    }
}
