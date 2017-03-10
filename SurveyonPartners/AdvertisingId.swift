//
//  AdvertisingId.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/09.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import AdSupport

public class AdvertisingId {
    
    static private var advertisingIdentifier: String?
    static private var isAdvertisingTrackingEnabled: Bool?
    
    static public func getAdvertisingIdentifier() -> String? {
        if (advertisingIdentifier == nil) {
            self.advertisingIdentifier = ASIdentifierManager().advertisingIdentifier.uuidString
        }
        return self.advertisingIdentifier
    }
    
    static public func getIsAdvertisingTrackingEnabled() -> Bool? {
        if (isAdvertisingTrackingEnabled == nil) {
            isAdvertisingTrackingEnabled = ASIdentifierManager().isAdvertisingTrackingEnabled
        }
        return self.isAdvertisingTrackingEnabled
    }
    
}
