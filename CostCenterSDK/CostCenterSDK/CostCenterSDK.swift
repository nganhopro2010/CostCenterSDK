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
        var parameters: [String: Any] = [
            "firebase_app_instance_id": firebaseAppInstanceID ?? "",
            "bundle_id": bundleIdentifier ?? "",
            "platform": platform,
            "vendor_id": vendorId ?? "",
            "attribution_token": "",
            "advertising_id": ""
        ]
        if isFirstTimeOpenApp() {
            ApiManager.instance.callAppOpen(params: parameters)
            saveFirstTimeOpenApp()
        }
        
        AdManager.instance.getAdvertisingIdentifier { advertisingId, attributeToken in
            // Parameters
            parameters["attribution_token"] = attributeToken ?? ""
            parameters["advertising_id"] = advertisingId ?? ""
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
