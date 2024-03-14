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

public class CostCenterSDK : NSObject{
    @objc public static let instance = CostCenterSDK()
    private let KEY_FIRST_TIME_OPEN_APP = "KEY_FIRST_TIME_OPEN_APP"
    var isShowingLog =  false
    
    @objc public func initialize(app: AnyClass, logger: Bool = false){
        isShowingLog = logger
        let firebaseAppInstanceID = FirebaseApp.app()?.options.googleAppID
        let bundleIdentifier = Bundle(for: app.self).bundleIdentifier
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
            ApiManager.instance.callAppOpen(consent: false, vendorId: vendorId, bundleIdentifier: bundleIdentifier, firebaseAppInstanceID: firebaseAppInstanceID, advertisingId: nil, platform: platform, attrToken: attrToken)
            saveFirstTimeOpenApp()
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 1){
            AdManager.instance.getAdvertisingIdentifier { advertisingId in
                ApiManager.instance.callAppOpen(consent: true, vendorId: vendorId, bundleIdentifier: bundleIdentifier, firebaseAppInstanceID: firebaseAppInstanceID, advertisingId: advertisingId, platform: platform, attrToken: attrToken)
                
            }}
        CostCenterLogger(message: "CostCenterSDK initialized")
        
    }
    
    private func saveFirstTimeOpenApp() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: KEY_FIRST_TIME_OPEN_APP)
        defaults.synchronize()
    }
    
    private func isFirstTimeOpenApp() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: KEY_FIRST_TIME_OPEN_APP)
    }
    
}

func CostCenterLogger(message: String) {
    if CostCenterSDK.instance.isShowingLog {
        NSLog("\(message)")
    }
}
