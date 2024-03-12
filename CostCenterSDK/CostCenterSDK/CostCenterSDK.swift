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
import AdServices

public class CostCenterSDK {
    public static let instance = CostCenterSDK()
    
    var isShowingLog =  false
    
    private init() {}
    
    public func initialize(){
        let firebaseAppInstanceID = FirebaseApp.app()?.options.googleAppID
        let bundleIdentifier = Bundle(for: CostCenterSDK.self).bundleIdentifier
        let platform = "iOS"
        let vendorId = UIDevice.current.identifierForVendor?.uuidString
        var attrToken : String? = nil
        if #available(iOS 14.3, *){
            do {
                attrToken = try AAAttribution.attributionToken()
            } catch {
                
            }
        }
        if !isFirstTimeOpenApp() {
            var parameters: [URLQueryItem] = [
                URLQueryItem(name: "firebase_app_instance_id", value: firebaseAppInstanceID ?? ""),
                URLQueryItem(name: "bundle_id", value: bundleIdentifier ?? ""),
                URLQueryItem(name: "platform", value: platform),
                URLQueryItem(name: "vendor_id", value:  vendorId ?? ""),
                URLQueryItem(name: "attribution_token", value: attrToken ?? ""),
                URLQueryItem(name: "advertising_id", value: ""),
            ]
            ApiManager.instance.callAppOpen(params: parameters)
            saveFirstTimeOpenApp()
        }
        
        AdManager.instance.getAdvertisingIdentifier { advertisingId in
            // Parameters
            var parameters: [URLQueryItem] = [
                URLQueryItem(name: "firebase_app_instance_id", value: firebaseAppInstanceID ?? ""),
                URLQueryItem(name: "bundle_id", value: bundleIdentifier ?? ""),
                URLQueryItem(name: "platform", value: platform),
                URLQueryItem(name: "vendor_id", value:  vendorId ?? ""),
                URLQueryItem(name: "attribution_token", value: attrToken ?? ""),
                URLQueryItem(name: "advertising_id", value: advertisingId ?? ""),
                URLQueryItem(name: "consent", value: "true"),
            ]
            ApiManager.instance.callAppOpen(params: parameters)
            
        }
        CostCenterLogger(message: "CostCenterSDK initialized")
        
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
    
    public func showLogger(show: Bool){
        isShowingLog = show
    }
    
}

func CostCenterLogger(message: String) {
    if CostCenterSDK.instance.isShowingLog {
        NSLog("\(message)")
    }
}
