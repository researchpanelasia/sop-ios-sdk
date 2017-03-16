//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/02/23.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

final public class SurveyonPartners {
    
    var setupInfo: SetupInfo
    
    init() {
        self.setupInfo = SetupInfo()
    }
    
    class var sharedInstance: SurveyonPartners {
        struct Static {
            static let instance: SurveyonPartners = SurveyonPartners()
        }
        return Static.instance
    }
    
    public static func setUp(appId: String, appMid: String, secretKry: String) {
        self.sharedInstance.setupInfo.setAllInfo(appId: appId, appMid: appMid, secretKey: secretKry)
        
        if (SurveyonPartnersCommom.isNeedAdIdUpdated(currentTimeMilles: SurveyonPartnersCommom.currentTimeMillis())) {
            updateAdid()
        }
    }
  
    public static func showSurveyList() {
        print("Start showSurveyList func.")
    }
    
    private static func updateAdid() {
        HttpClient.postIdfa(Idfa: "", isLimitAdTrackingEnabled: true, completion: { (isSuccess) -> Void in
            if isSuccess {
                // OK
                SurveyonPartnersCommom.adIdUpdatedAt(currentTimeMilles: SurveyonPartnersCommom.currentTimeMillis())
            } else {
                // NG
            }
        })
    }
    
}
