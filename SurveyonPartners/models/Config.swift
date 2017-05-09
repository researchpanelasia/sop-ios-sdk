//
//  SetupInfo.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

struct Config {
  
  let appId: String
  
  let appMid: String
  
  let secretKey: String
  
  let sopHost: String
  
  let sopConsoleHost: String
  
  let idfaUpdateSpan: Int64
  
  let useHttps: Bool
  
  let verifyHost: Bool
  
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
