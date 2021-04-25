//
//  IDFA.swift
//  dataSpringMobile
//
//  Created by huaqi.xue on 2021/4/23.
//  Copyright © 2021 Marketing Applications.inc. All rights reserved.
//

import Foundation
import AppTrackingTransparency
import AdSupport

public class IDFA {
    
    public static let shared = IDFA()
    
    var isAdvertisingTrackingEnabled : Bool {
        if #available(iOS 14, *) {
            var tStatus: ATTrackingManager.AuthorizationStatus?

            ATTrackingManager.requestTrackingAuthorization { (status) in
                tStatus = status
            }

            if tStatus != ATTrackingManager.AuthorizationStatus.authorized {
                return false
            }

        }
        return true
    }

    /// Returns the identifier if the user has turned advertisement tracking on, else `nil`.
    var identifier: String {
        guard isAdvertisingTrackingEnabled else { return "" }
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    public func updateIdfa(){
        guard let config = SurveyonPartners.getConfig() else {
            return
        }

        let httpClient = HttpClient(appId: config.appId,
                                      appMid: config.appMid,
                                      secretKey: config.secretKey,
                                      sopHost: config.sopHost,
                                      sopConsoleHost: config.sopConsoleHost,
                                      updateSpan: config.idfaUpdateSpan,
                                      useHttps: config.useHttps,
                                      verifyHost: config.verifyHost)
          
        httpClient.updateIdfa(completion: { (result) -> Void in
            switch result {
            case .success(let response):
              SOPLog.debug(message: "statusCode = \(response)")
            case .failed(let error):
              //do nothing
              SOPLog.error(message: "error = \(error)")
            }
        })
    }
    
}
