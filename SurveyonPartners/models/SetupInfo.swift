//
//  SetupInfo.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

private class SetupInfo {
    var appId: String
    var appMid: String
    var secretKey: String
    
    init(appId: String, appMid: String, secretKey: String) {
        self.appId = appId
        self.appMid = appMid
        self.secretKey = secretKey
    }
    
    func getAppId() -> String {
        return appId;
    }
    
    func getAppMid() -> String{
        return appMid;
    }
    
    func getSecretKey() -> String {
        return secretKey;
    }
    
}
