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
  
  static var config: Config?
  
  static var queue = DispatchQueue(label: "com.surveyon.patners", attributes: .concurrent)
}

extension SurveyonPartners {

  public static func setUp(appId: String,
                           appMid: String,
                           secretKey: String ) {

    let host = getFromPlist(key: sopHostKey, defaultValue: DEFAULT_SOP_HOST)
    let consoleHost = getFromPlist(key: sopConsoleHostKey, defaultValue: DEFAULT_SOP_CONSOLE_HOST)
    let updateSpan = getFromPlist(key: updataSpanKey, defaultValue: DEFAULT_IDFA_UPDATE_SPAN)
    let useHttps = getFromPlist(key: useHttpsKey, defaultValue: DEFAULT_USE_HTTPS)
    let verifyHost = getFromPlist(key: verifyHostKey, defaultValue: DEFAULT_VERIFYHOST)
    
    setConfig(Config(appId: appId,
                     appMid: appMid,
                     secretKey: secretKey,
                     sopHost: host,
                     sopConsoleHost: consoleHost,
                     idfaUpdateSpan: updateSpan,
                     useHttps: useHttps,
                     verifyHost: verifyHost))
  }

  public static func getSurveyList(completion: @escaping (RequestResult) -> Void ){
    guard let config = getConfig() else {
      DispatchQueue.main.async {
        completion(RequestResult.failed(error: SOPError(message: "Invalid configuration", type: .InvalidConfiguration, response: nil, error: nil)))
      }
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
    httpClient.getSurveyList(completion: completion)
  }
    
  public static func getSyncSurveys(completion: @escaping (RequestResult) -> Void ){
    guard let config = getConfig() else {
        DispatchQueue.main.async {
            completion(RequestResult.failed(error: SOPError(message: "Invalid configuration", type: .InvalidConfiguration, response: nil, error: nil)))
        }
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
    httpClient.getSyncSurvey(completion: completion)
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
    
  public static func getSyncSurveys(completion: @escaping (Response?, SOPError?) -> Void ){
      getSyncSurveys(completion: { (result: RequestResult) in
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
    
    let viewController = SurveyListViewContoroller(nibName: "SurveyListViewContoroller", bundle: getResourceBundle())
    viewController.setRule(profilingPointRule: profilingPointRule, researchPointRule: researchPointRule)
    viewController.modalPresentationStyle = .overCurrentContext
    vc.present(viewController, animated: false, completion: nil)
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

  static func getResourceBundle() -> Bundle?{
    let classBundle = Bundle(for: self)
    guard let url = classBundle.url(forResource: "SurveyonPartners", withExtension: "bundle") else {
      return classBundle
    }
    return Bundle(url: url)
  }

  static func getImage(name: String) -> UIImage?{
    return UIImage(named: name, in: getResourceBundle(), compatibleWith: nil)
  }
}

extension SurveyonPartners {
  
  static func getFromPlist<T>(key: String, defaultValue: T) -> T {
    guard let dict = Utility.getPlist(),
      let getValue = dict[key] as? T else {
        return defaultValue
    }
    
    return getValue
  }
}
