//
//  CostCenterSDK.swift
//  CostCenterSDK
//
//  Created by Ho Van Ngan on 07/03/2024.
//

import Foundation
import FirebaseCore
import AppTrackingTransparency
import AdSupport

public class CostCenterSDK {
    public static let instance = CostCenterSDK();
    private init() {}
    
    public func initialize(){
        NSLog("CostCenterSDK initialize")
        let firebaseAppInstanceID = FirebaseApp.app()?.options.googleAppID
        let bundleIdentifier = Bundle(for: CostCenterSDK.self).bundleIdentifier
        let platform = "iOS"
        let vendorId = UIDevice.current.identifierForVendor?.uuidString
        if !isFirstTimeOpenApp() {
            var parameters: [URLQueryItem] = [
                URLQueryItem(name: "firebase_app_instance_id", value: firebaseAppInstanceID ?? ""),
                URLQueryItem(name: "bundle_id", value: bundleIdentifier ?? ""),
                URLQueryItem(name: "platform", value: platform),
                URLQueryItem(name: "vendor_id", value:  vendorId ?? ""),
                URLQueryItem(name: "attribution_token", value: ""),
                URLQueryItem(name: "advertising_id", value: ""),
            ]
            ApiManager.instance.callAppOpen(params: parameters)
            saveFirstTimeOpenApp()
        }
        
        AdManager.instance.getAdvertisingIdentifier { advertisingId, attributeToken in
            // Parameters
            var parameters: [URLQueryItem] = [
                URLQueryItem(name: "firebase_app_instance_id", value: firebaseAppInstanceID ?? ""),
                URLQueryItem(name: "bundle_id", value: bundleIdentifier ?? ""),
                URLQueryItem(name: "platform", value: platform),
                URLQueryItem(name: "vendor_id", value:  vendorId ?? ""),
                URLQueryItem(name: "attribution_token", value: attributeToken ?? ""),
                URLQueryItem(name: "advertising_id", value: advertisingId ?? ""),
            ]
            ApiManager.instance.callAppOpen(params: parameters)
            
        }
        
    }
    
    private func saveFirstTimeOpenApp() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "firstTimeOpenApp")
        defaults.synchronize()
    }
    
    private func isFirstTimeOpenApp() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "firstTimeOpenApp")
    }
}
