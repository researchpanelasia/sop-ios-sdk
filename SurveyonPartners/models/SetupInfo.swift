//
//  SetupInfo.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/15.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

struct SetupInfo {
  
  var appId: String?
  
  var appMid: String?
  
  var secretKey: String?
  
  var sopHost: String?
  
  var sopConsoleHost: String?
  
  var idfaUpdateSpan: Int64?
  
  var useHttps: Bool?
  
  var verifyHost: Bool?
  
  init(appId: String,
       appMid: String,
       secretKey: String,
       sopHost: String,
       sopConsoleHost: String,
       idfaUpdateSpan: Int64,
       useHttps: Bool,
       verifyHost: Bool) {
    self.appId = appId
    self.appMid = appMid
    self.secretKey = secretKey
    self.sopHost = sopHost
    self.sopConsoleHost = sopConsoleHost
    self.idfaUpdateSpan = idfaUpdateSpan
    self.useHttps = useHttps
    self.verifyHost = verifyHost
  }
  
}
