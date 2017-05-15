//
//  AdvertisingId.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import AdSupport

class AdvertisingId {
    static func getAdvertisingIdentifier() -> String {
        return ASIdentifierManager().advertisingIdentifier.uuidString
    }

    static func getIsAdvertisingTrackingEnabled() -> Bool {
        return ASIdentifierManager().isAdvertisingTrackingEnabled
    }
}
