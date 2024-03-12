//
//  ApiManager.swift
//  CollectData
//
//  Created by Ho Van Ngan on 09/03/2024.
//

import Foundation

class ApiManager {
    static let instance = ApiManager()
    func callAppOpen(params: [URLQueryItem]) {
        CostCenterLogger(message: "callAppOpen parameters = \(params)")
        var components = URLComponents(string: "https://attribution.costcenter.net/appopen")!
        components.queryItems = params
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
