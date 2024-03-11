//
//  ApiManager.swift
//  CollectData
//
//  Created by Ho Van Ngan on 09/03/2024.
//

import Foundation

class ApiManager {
    public static let instance = ApiManager();
    private let urlString = "https://attribution.costcenter.net/appopen"
    
    func callAppOpen(params: [URLQueryItem]) {
        NSLog("callAppOpen parameters = \(params)")
        var components = URLComponents(string: "https://attribution.costcenter.net/appopen")!
        components.queryItems = params
        guard let url = components.url else {
            NSLog("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                NSLog("Invalid response")
                return
            }
            NSLog("httpResponse.statusCode = \(httpResponse.statusCode)")

            if !(200...299).contains(httpResponse.statusCode) {
                NSLog("HTTP Response Error: \(httpResponse.statusCode)")
                return
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    NSLog("Success Response JSON: \(json)")
                } catch {
                    NSLog("JSON Error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        
    }
}
