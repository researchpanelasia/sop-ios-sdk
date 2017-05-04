//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class SurveyonPartners {
  
  // after 14 days, update idfa
  static let DEFAULT_IDFA_UPDATE_SPAN: Int64 = 60 * 60 * 24 * 14 * 1000
  
  static let DEFAULT_SOP_HOST = "partners.surveyon.com"
  
  static let DEFAULT_SOP_CONSOLE_HOST = "console.partners.surveyon.com"
  
  static var viewController: UIViewController?
  
  static var setupInfo: SetupInfo?
  
  static var initialized = false
  
  static var showListItem: [SurveyListItem] = []
  
  static var profilingPointRule: ProfilingPointRule?
  
  static var researchPointRule: ResearchPointRule?
  
}

extension SurveyonPartners {
  
  public static func setUp(appId: String,
                           appMid: String,
                           secretKey: String,
                           sopHost: String = SurveyonPartners.DEFAULT_SOP_HOST,
                           sopConsoleHost: String = SurveyonPartners.DEFAULT_SOP_CONSOLE_HOST,
                           updateSpan: Int64 = SurveyonPartners.DEFAULT_IDFA_UPDATE_SPAN,
                           useHttps: Bool = true,
                           verifyHost: Bool = true) {
    
    setupInfo = SetupInfo(appId: appId,
                         appMid: appMid,
                         secretKey: secretKey,
                         sopHost: sopHost,
                         sopConsoleHost: sopConsoleHost,
                         idfaUpdateSpan: updateSpan,
                         useHttps: useHttps,
                         verifyHost: verifyHost)
    
    let httpClient = HttpClient(appId: appId,
                                appMid: appMid,
                                secretKey: secretKey,
                                sopHost: sopHost,
                                sopConsoleHost: sopConsoleHost,
                                updateSpan: updateSpan,
                                useHttps: useHttps,
                                verifyHost: verifyHost)
    if (isNeedAdIdUpdated(currentTimeMilles: Utility.currentTimeMillis())) {
      httpClient.updateIdfa(completion: { (result) -> Void in
        switch result {
        case .success(let statusCode, let message, let rawBody):
          SOPLog.debug(message: "statusCode = \(statusCode), message = \(message), rawBody = \(rawBody)")
          initialized = true
          SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Utility.currentTimeMillis())
        case .failed(let error):
          //do nothing
          SOPLog.error(message: "error = \(error.localizedDescription)")
        }
      })
    }
    
  }
  
  public static func showSurveyList<T,R>(vc: UIViewController, profilingPointRule: T, researchPointRule: R) {
    
    guard initialized else {
      return
    }
    
    self.profilingPointRule = profilingPointRule as? ProfilingPointRule
    self.researchPointRule = researchPointRule as? ResearchPointRule
    
    viewController = SurveyListViewContoroller(nibName: "SurveyListViewContoroller", bundle: Bundle(identifier: "com.surveyon.partners.SurveyonPartners"))
    viewController!.modalPresentationStyle = .overCurrentContext
    vc.present(viewController!, animated: false, completion: nil)
    
    let httpClient = HttpClient(appId: setupInfo!.appId!,
                                appMid: setupInfo!.appMid!,
                                secretKey: setupInfo!.secretKey!,
                                sopHost: setupInfo!.sopHost!,
                                sopConsoleHost: setupInfo!.sopConsoleHost!,
                                updateSpan: setupInfo!.idfaUpdateSpan!,
                                useHttps: setupInfo!.useHttps!,
                                verifyHost: setupInfo!.verifyHost!)
    
    httpClient.getSurveyList(completion: { (result) -> Void in
      switch result {
      case .success(let statusCode, let message, let rawBody):
        SOPLog.debug(message: "statusCode = \(statusCode), message = \(message), rawBody = \(rawBody)")
        
        showListItem = SurveyListItemFactory.create(data: rawBody)
        
        viewController = SurveyListViewContoroller(nibName: "SurveyListViewContoroller", bundle: Bundle(identifier: "com.surveyon.partners.SurveyonPartners"))
        viewController!.modalPresentationStyle = .overCurrentContext
        vc.present(viewController!, animated: false, completion: nil)
        
      case .failed(let error):
        //do nothing
        SOPLog.error(message: "error = \(error.localizedDescription)")
      }
    })
  }
  
}

extension SurveyonPartners {
  
  static func adIdUpdatedAt(currentTimeMilles: Int64) {
    PreferencesManager.writePreferences(value: currentTimeMilles, forKey: Constants.SURVEYON_PARTNERS)
  }
  
  static func isNeedAdIdUpdated(currentTimeMilles: Int64) -> Bool {
    let previousTimeMilles: Int64 = PreferencesManager.readIntPreferences(forKey: Constants.SURVEYON_PARTNERS)
    return setupInfo!.idfaUpdateSpan! <= (currentTimeMilles - previousTimeMilles)
  }
  
}
