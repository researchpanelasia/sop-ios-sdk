//
//  HttpClient.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/16.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

struct HttpClient {
  
  static let HTTPS = "https://"
  
  static let HTTP = "http://"
  
  static let PATH_GET_SURVEY = "/api/v1_1/surveys/json"
  
  static let PATH_POST_IDFA = "/api/v1_1/resource/app/member/identifier/apple_idfa"
  
  static let KEY_APP_ID = "app_id";
  
  static let KEY_APP_MID = "app_mid";
  
  static let KEY_TIME = "time";
  
  static let KEY_SIG = "sig";
  
  static let KEY_IDENTIFIER = "identifier";
  
  static let KEY_IS_AD_TRACKING_ENABLED = "is_ad_tracking_enabled";
  
  static let KEY_SOP_AD_TRACKING = "sop_ad_tracking";
  
  static var httpClient: HttpClient?
  
  init(appId: String,
              appMid: String,
              secretKey: String,
              sopHost: String,
              sopConsoleHost: String,
              updateSpan: Int64,
              useHttps: Bool,
              verifyHost: Bool) {
    SetupInfo.appId = appId
    SetupInfo.appMid = appMid
    SetupInfo.secretKey = secretKey
    SetupInfo.sopHost = sopHost
    SetupInfo.sopConsoleHost = sopConsoleHost
    SetupInfo.idfaUpdateSpan = updateSpan
    SetupInfo.useHttps = useHttps
    SetupInfo.verifyHost = verifyHost
    HttpClient.httpClient = self
  }
  
}

extension HttpClient {
  
  func updateIdfa(completion: @escaping (Bool) -> Void) {
    if !Utility.isOnline() { return }
    
    let url = URL(string: HttpClient.getProtocol() + SetupInfo.sopConsoleHost! + HttpClient.PATH_POST_IDFA)!
    let dictionary: Dictionary<String,Any>  = [
      HttpClient.KEY_APP_ID: SetupInfo.appId!,
      HttpClient.KEY_APP_MID: SetupInfo.appMid!,
      HttpClient.KEY_TIME: SurveyonPartners.getPosixTime(),
      HttpClient.KEY_IDENTIFIER: AdvertisingId.getAdvertisingIdentifier(),
      HttpClient.KEY_IS_AD_TRACKING_ENABLED: AdvertisingId.getIsAdvertisingTrackingEnabled()
    ]
    
//    let sig = Authentication().createSignature(message: requestBody, key: SetupInfo.secretKey!)
    let JSONData = try! JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
    if let JSONString = String(data: JSONData, encoding: String.Encoding.utf8) {
      
      let request = Request(url: url,
                            requestBody: JSONString,
                            httpMethod: .POST)
      request.post(completion: { (isSuccess) -> Void in
        if isSuccess {
          completion(true)
        } else {
          completion(false)
        }
      })
    }
  }
  
  func getSurveyList(completion: @escaping (Bool) -> Void) {
    if !Utility.isOnline() { return }
    
    var apiUrl = HttpClient.getProtocol() + SetupInfo.sopHost! + HttpClient.PATH_GET_SURVEY
    
    //
    let ob = Authentication()
    let populationDict: Dictionary<String,String>  = [
      HttpClient.KEY_APP_ID: SetupInfo.appId!,
      HttpClient.KEY_APP_MID: SetupInfo.appMid!,
      HttpClient.KEY_TIME: SurveyonPartners.getPosixTime()
      ]
    
    let sig = ob.createSignature(parameters: populationDict, key: SetupInfo.secretKey!)
    var params = "?app_id=" + SetupInfo.appId!
    params += "&app_mid=" + SetupInfo.appMid!
    params += "&time=" + SurveyonPartners.getPosixTime()
    let paramSig = "&sig=" + sig
    apiUrl += params + paramSig
    
    SOPLog.debug(message: "apiUrl = \(apiUrl)")
    let url = URL(string: apiUrl)!
    let request = Request(url: url,
                          httpMethod: .GET)
    
    request.get(completion: { (isSuccess) -> Void in
      if isSuccess {
        completion(true)
      } else {
        completion(false)
      }
    })
  }
}

extension HttpClient {
  static func getHttpClient() -> HttpClient {
    return HttpClient.httpClient!
  }
  
  static func getProtocol() -> String {
    if SetupInfo.useHttps! {
      return HttpClient.HTTPS
    }
    return HttpClient.HTTP
  }
}
