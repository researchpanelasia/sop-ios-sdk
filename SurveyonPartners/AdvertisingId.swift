//
//  AdvertisingId.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/09.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import AdSupport

public class AdvertisingId {
  
  private static var advertisingIdentifier: String!
  
  private static var isAdvertisingTrackingEnabled: Bool!
  
  public static func getAdvertisingIdentifier() -> String! {
    if (advertisingIdentifier == nil) {
      self.advertisingIdentifier = ASIdentifierManager().advertisingIdentifier.uuidString
    }
    return self.advertisingIdentifier
  }
  
  public static func getIsAdvertisingTrackingEnabled() -> Bool! {
    if (isAdvertisingTrackingEnabled == nil) {
      isAdvertisingTrackingEnabled = ASIdentifierManager().isAdvertisingTrackingEnabled
    }
    return self.isAdvertisingTrackingEnabled
  }
  
}
