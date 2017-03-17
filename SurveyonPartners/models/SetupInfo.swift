//
//  SetupInfo.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

final public class SetupInfo {
    
    private var appId: String = ""
    private var appMid: String = ""
    private var secretKey: String = ""
    
    public func setAllInfo(appId: String, appMid: String, secretKey: String) {
        self.appId = appId
        self.appMid = appMid
        self.secretKey = secretKey
    }
    
    public func getAppId() -> String { return appId }
    
    public func getAppMid() -> String{ return appMid }
    
    public func getSecretKey() -> String { return secretKey }
    
}
