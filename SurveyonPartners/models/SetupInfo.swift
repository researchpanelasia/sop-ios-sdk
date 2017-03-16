//
//  SetupInfo.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class SetupInfo {
    private var appId: String
    private var appMid: String
    private var secretKey: String
    
    init() {
        self.appId = ""
        self.appMid = ""
        self.secretKey = ""
    }
    
    func setAllInfo(appId: String, appMid: String, secretKey: String) {
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
