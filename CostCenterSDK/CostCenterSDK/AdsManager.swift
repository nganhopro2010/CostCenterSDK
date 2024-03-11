//
//  AdsManager.swift
//  CollectData
//
//  Created by Ho Van Ngan on 08/03/2024.
//

import Foundation
import AppTrackingTransparency
import AdSupport
import AdServices

class AdManager {
    static let instance = AdManager()
    
    func getAdvertisingIdentifier(completion: @escaping (String?,String?) -> Void) {
        if UserDefaults.standard.string(forKey: "advertisingId") != nil {
            return
        }
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    NSLog("Advertising ID: Người dùng đã cho phép truy cập ID quảng cáo")
                    let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    UserDefaults.standard.set(advertisingId, forKey: "advertisingId")
                    var attrToken : String? = nil
                    if #available(iOS 14.3, *){
                        do {
                            attrToken = try AAAttribution.attributionToken()
                            NSLog("Attribution Identifier: \(attrToken ?? "")")
                        } catch {
                            NSLog("Error retrieving attribution token: \(error)")
                        }
                    }
                    NSLog("Advertising ID: \(advertisingId)")
                    completion(advertisingId,attrToken)
                    break
                case .denied:
                    break
                case .notDetermined:
                    break
                case .restricted:
                    break
                @unknown default:
                    break
                }
            }
        } else {
            let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            completion(advertisingId,nil)
            NSLog("Advertising ID: \(advertisingId)")
        }
        
    }
}

