//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class SurveyonPartners: NSObject {
  
  static let sopHostKey = "SopHost"
  
  static let sopConsoleHostKey = "SopConsoleHost"
  
  static let updataSpanKey = "SopUpdateSpan"
  
  static let useHttpsKey = "SopUseHttps"
  
  static let verifyHostKey = "SopVerifyHost"
  
  static let DEFAULT_IDFA_UPDATE_SPAN: Int64 = 60 * 60 * 24 * 14 * 1000
  
  static let DEFAULT_SOP_HOST = "partners.surveyon.com"
  
  static let DEFAULT_SOP_CONSOLE_HOST = "console.partners.surveyon.com"
  
  static let DEFAULT_USE_HTTPS = true
  
  static let DEFAULT_VERIFYHOST = true
  
  static let plistFileName = "Info"
  
  static var config: Config?
  
  static var queue = DispatchQueue(label: "com.surveyon.patners", attributes: .concurrent)
}

extension SurveyonPartners {

  public static func setUp(appId: String,
                           appMid: String,
                           secretKey: String) {

    let host = getHost()
    let consoleHost = getConsoleHost()
    let updateSpan = getUpdateSpan()
    let useHttps = getUseHttps()
    let verifyHost = getVerifyHost()
    
    setConfig(Config(appId: appId,
                     appMid: appMid,
                     secretKey: secretKey,
                     sopHost: host,
                     sopConsoleHost: consoleHost,
                     idfaUpdateSpan: updateSpan,
                     useHttps: useHttps,
                     verifyHost: verifyHost))

    if (isNeedAdIdUpdated(currentTimeMilles: Utility.currentTimeMillis())) {
      updateIdfa()
    }
  }

  public static func getSurveyList(completion: @escaping (RequestResult) -> Void ){
    guard let config = getConfig() else {
      DispatchQueue.main.async {
        completion(RequestResult.failed(error: SOPError(message: "Invalid configuration", type: .InvalidConfiguration, response: nil, error: nil)))
      }
      return
    }

    if (isNeedAdIdUpdated(currentTimeMilles: Utility.currentTimeMillis())) {
      updateIdfa()
    }
    
    let httpClient = HttpClient(appId: config.appId,
                                appMid: config.appMid,
                                secretKey: config.secretKey,
                                sopHost: config.sopHost,
                                sopConsoleHost: config.sopConsoleHost,
                                updateSpan: config.idfaUpdateSpan,
                                useHttps: config.useHttps,
                                verifyHost: config.verifyHost)
    httpClient.getSurveyList(completion: completion)
  }

  public static func getSurveyList(completion: @escaping (Response?, SOPError?) -> Void ){
    getSurveyList(completion: { (result: RequestResult) in
      switch result {
      case .success(let response):
        completion(response, nil)
      case .failed(let error):
        completion(error.response, error)
      }
    })
  }

  public static func showSurveyList(vc: UIViewController, profilingPointRule: ProfilingPointRule, researchPointRule: ResearchPointRule) {
    if !Utility.isOnline() {
      return
    }
    
    guard let _ = getConfig() else {
      return
    }
    
    let viewController = SurveyListViewContoroller(nibName: "SurveyListViewContoroller", bundle: Bundle(identifier: "com.surveyon.partners.SurveyonPartners"))
    viewController.setRule(profilingPointRule: profilingPointRule, researchPointRule: researchPointRule)
    viewController.modalPresentationStyle = .overCurrentContext
    vc.present(viewController, animated: false, completion: nil)
  }

  static func updateIdfa(){
    guard let config = getConfig() else {
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
        SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Utility.currentTimeMillis())
      case .failed(let error):
        //do nothing
        SOPLog.error(message: "error = \(error)")
      }
    })
  }

  static func setConfig(_ config: Config){
    queue.async(flags: .barrier) {
      SurveyonPartners.config = config
    }
  }

  static func getConfig() -> Config?{
    var tmp: Config?
    queue.sync {
      tmp = config
    }
    return tmp
  }

  static func initConfig() {
    queue.async(flags: .barrier) {
      SurveyonPartners.config = nil
    }
  }
}

extension SurveyonPartners {

  static func adIdUpdatedAt(currentTimeMilles: Int64) {
    PreferencesManager.writePreferences(value: currentTimeMilles, forKey: Constants.SURVEYON_PARTNERS)
  }
  
  static func isNeedAdIdUpdated(currentTimeMilles: Int64) -> Bool {
    if #available(iOS 10.0, *) {
      if !AdvertisingId.getIsAdvertisingTrackingEnabled() {
        return false
      }
    }
    
    guard let info = getConfig() else {
      return false
    }

    let previousTimeMilles: Int64 = PreferencesManager.readIntPreferences(forKey: Constants.SURVEYON_PARTNERS)
    return info.idfaUpdateSpan <= (currentTimeMilles - previousTimeMilles)
  }
  
  static func getHost() -> String {
    guard let dict = Utility.getPlistDictionary(),
      let host = dict[sopHostKey] as? String else {
        return DEFAULT_SOP_HOST
    }
    
    return host
  }
  
  static func getConsoleHost() -> String {
    guard let dict = Utility.getPlistDictionary(),
      let consoleHost = dict[sopConsoleHostKey] as? String else {
        return DEFAULT_SOP_HOST
    }
    
    return consoleHost
  }
  
  static func getUpdateSpan() -> Int64 {
    guard let dict = Utility.getPlistDictionary(),
      let updateSpan = dict[updataSpanKey] as? Int64 else {
        return DEFAULT_IDFA_UPDATE_SPAN
    }
    
    return updateSpan
  }
  
  static func getUseHttps() -> Bool {
    guard let dict = Utility.getPlistDictionary(),
      let useHttps = dict[useHttpsKey] as? Bool else {
        return DEFAULT_USE_HTTPS
    }
    
    return useHttps
  }
  
  static func getVerifyHost() -> Bool {
    guard let dict = Utility.getPlistDictionary(),
      let verifyHost = dict[verifyHostKey] as? Bool else {
        return DEFAULT_VERIFYHOST
    }
    
    return verifyHost
  }
}
