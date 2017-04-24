//
//  AdvertisingId.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import AdSupport

public class AdvertisingId {
    static public func getAdvertisingIdentifier() -> String {
        return ASIdentifierManager().advertisingIdentifier.uuidString
    }
    
    static public func getIsAdvertisingTrackingEnabled() -> Bool {
        return ASIdentifierManager().isAdvertisingTrackingEnabled
    }
}
