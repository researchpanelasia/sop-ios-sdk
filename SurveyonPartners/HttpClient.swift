//
//  HttpClient.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

import Foundation

struct HttpClient {
  
  static let HTTPS = "https://"
  
  static let HTTP = "http://"
  
  static let PATH_GET_SURVEY = "/api/v1_1/surveys/json"
    
  static let PATH_GET_SYNC_SURVEY = "/api/v1_1/sync-surveys/json"
  
  static let PATH_POST_IDFA = "/api/v1_1/resource/app/member/identifier/apple_idfa"
  
  static let KEY_APP_ID = "app_id";
  
  static let KEY_APP_MID = "app_mid";
  
  static let KEY_TIME = "time";
  
  static let KEY_SIG = "sig";
  
  static let KEY_IDENTIFIER = "identifier";
  
  static let KEY_IS_AD_TRACKING_ENABLED = "is_ad_tracking_enabled";
  
  static let KEY_SOP_AD_TRACKING = "sop_ad_tracking";
  
  var appId: String
  
  var appMid: String
  
  var secretKey: String
  
  var sopHost: String
  
  var sopConsoleHost: String
  
  var idfaUpdateSpan: Int64
  
  var useHttps: Bool
  
  var verifyHost: Bool

  init(appId: String,
       appMid: String,
       secretKey: String,
       sopHost: String,
       sopConsoleHost: String,
       updateSpan: Int64,
       useHttps: Bool,
       verifyHost: Bool ) {
    self.appId = appId
    self.appMid = appMid
    self.secretKey = secretKey
    self.sopHost = sopHost
    self.sopConsoleHost = sopConsoleHost
    self.idfaUpdateSpan = updateSpan
    self.useHttps = useHttps
    self.verifyHost = verifyHost
  }
}

extension HttpClient {
  
  func updateIdfa(completion: @escaping (RequestResult) -> Void) {
    
    if !Utility.isOnline() {
      completion(RequestResult.failed(error: SOPError(message: "Network not available", type: .NetworkNotAvailable, response: nil, error: nil)))
      return
    }
    
    let url = URL(string: getProtocol() + self.sopConsoleHost + HttpClient.PATH_POST_IDFA)!
    let dictionary: Dictionary<String,Any>  = [
      HttpClient.KEY_APP_ID: self.appId,
      HttpClient.KEY_APP_MID: self.appMid,
      HttpClient.KEY_TIME: Utility.getPosixTime(),
      HttpClient.KEY_IDENTIFIER: IDFA.shared.identifier,
      HttpClient.KEY_IS_AD_TRACKING_ENABLED: IDFA.shared.isAdvertisingTrackingEnabled
    ]
    
    let JSONData = try! JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
    if let JSONString = String(data: JSONData, encoding: String.Encoding.utf8) {

      SOPLog.debug(message: "request: POST \(url)")
      let request = Request(url: url,
                            requestBody: JSONString,
                            httpMethod: .POST,
                            verifyHost: verifyHost)
      request.addHeader(key: Request.CONTENT_TYPE, value: Request.APPLICATION_JSON)
      request.addHeader(key: Request.X_SOP_SIG,
                        value: Authentication().createSignature(message: JSONString, key: secretKey))
      request.addHeader(key: Request.USER_AGENT, value: Utility.getUserAgent())
      request.post(completion: completion)
    }
  }
  
  func getSurveyList(completion: @escaping (RequestResult) -> Void) {
    getSurvey(with: HttpClient.PATH_GET_SURVEY, completion: completion)
  }
    
  func getSyncSurvey(completion: @escaping (RequestResult) -> Void) {
    getSurvey(with: HttpClient.PATH_GET_SYNC_SURVEY, completion: completion)
  }
    
  private func getSurvey(with path: String, completion: @escaping (RequestResult) -> Void) {
    if !Utility.isOnline() {
      completion(RequestResult.failed(error: SOPError(message: "Network not available", type: .NetworkNotAvailable, response: nil, error: nil)))
      return
    }
    
    var apiUrl = getProtocol() + self.sopHost + path
    
    let populationDict: Dictionary<String,String>  = [
      HttpClient.KEY_APP_ID: self.appId,
      HttpClient.KEY_APP_MID: self.appMid,
      HttpClient.KEY_TIME: Utility.getPosixTime(),
      HttpClient.KEY_SOP_AD_TRACKING: "1"
    ]
    
    let sig = Authentication().createSignature(parameters: populationDict, key: self.secretKey)
    var params = "?app_id=" + self.appId
    params += "&app_mid=" + self.appMid
    params += "&time=" + Utility.getPosixTime()
    params += "&sop_ad_tracking=" + "1"
    let paramSig = "&sig=" + sig
    apiUrl += params + paramSig
    
    SOPLog.debug(message: "request: GET \(apiUrl)")
    let url = URL(string: apiUrl)!
    let request = Request(url: url,
                          httpMethod: .GET,
                          verifyHost: verifyHost)
    request.addHeader(key: Request.USER_AGENT, value: Utility.getUserAgent())
    request.get(completion: completion)
  }
  
  func getProtocol() -> String {
    if self.useHttps {
      return HttpClient.HTTPS
    }
    return HttpClient.HTTP
  }

}
