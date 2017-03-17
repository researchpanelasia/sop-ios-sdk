//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/02/23.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

final public class SurveyonPartners {
    
    private static let sharedInstance: SurveyonPartners = SurveyonPartners()
    let setupInfo: SetupInfo = SetupInfo()
    
//    class var sharedInstance: SurveyonPartners {
//        struct Static {
//            static let instance: SurveyonPartners = SurveyonPartners()
//        }
//        return Static.instance
//    }
    
    public static func setUp(appId: String, appMid: String, secretKry: String) {
        self.sharedInstance.setupInfo.setAllInfo(appId: appId, appMid: appMid, secretKey: secretKry)
        
        if (SurveyonPartnersCommom.isNeedAdIdUpdated(currentTimeMilles: SurveyonPartnersCommom.currentTimeMillis())) {
            self.sharedInstance.updateIdfa()
        }
    }
  
    public static func showSurveyList() {
        print("Start showSurveyList func.")
    }
    
    private func updateIdfa() {
        HttpClient.postIdfa(Idfa: AdvertisingId.getAdvertisingIdentifier(),
                            isLimitAdTrackingEnabled: AdvertisingId.getIsAdvertisingTrackingEnabled(),
                            completion: { (isSuccess) -> Void in
                                if isSuccess {
                                    SurveyonPartnersCommom.adIdUpdatedAt(currentTimeMilles: SurveyonPartnersCommom.currentTimeMillis())
                                } else {
                                    //do nothing
                                }
        })
    }
    
    private static func postIdfa(Idfa: String, isLimitAdTrackingEnabled: String) {
        
        if !Utility.isOnline() { return }
        
        
        
    }
    
    private static func setPostIdfaData() {
        HttpClient.Builder.appId = AdvertisingId.getAdvertisingIdentifier()
        HttpClient.Builder.appMid = self.sharedInstance.setupInfo.getAppMid()
        HttpClient.Builder.secretKey = self.sharedInstance.setupInfo.getSecretKey()
        HttpClient.Builder.host = ""
        HttpClient.Builder.userAgent = ""
    }
}
