//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class SurveyonPartners {
  
  static let DEFAULT_IDFA_UPDATE_SPAN: Int64 = 60 * 60 * 24 * 14 * 1000
  
  static let DEFAULT_SOP_HOST = "partners.surveyon.com"
  
  static let DEFAULT_SOP_CONSOLE_HOST = "console.partners.surveyon.com"
  
  static var viewController: UIViewController?

  static var setupInfo: SetupInfo?

  static var showListItem: [SurveyListItem] = []
  
  static var profilingPointRule: ProfilingPointRule?
  
  static var researchPointRule: ResearchPointRule?

  static var queue = DispatchQueue(label: "com.surveyon.patners", attributes: .concurrent)
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
    
    setSetupInfo(SetupInfo(appId: appId,
                           appMid: appMid,
                           secretKey: secretKey,
                           sopHost: sopHost,
                           sopConsoleHost: sopConsoleHost,
                           idfaUpdateSpan: updateSpan,
                           useHttps: useHttps,
                           verifyHost: verifyHost))

    if (isNeedAdIdUpdated(currentTimeMilles: Utility.currentTimeMillis())) {
      updateIdfa()
    }
  }

  static func updateIdfa(){
    guard let info = getSetupInfo() else {
      //TODO: should throw error?
      return
    }

    let httpClient = HttpClient(appId: info.appId,
                                appMid: info.appMid,
                                secretKey: info.secretKey,
                                sopHost: info.sopHost,
                                sopConsoleHost: info.sopConsoleHost,
                                updateSpan: info.idfaUpdateSpan,
                                useHttps: info.useHttps,
                                verifyHost: info.verifyHost)

    httpClient.updateIdfa(completion: { (result) -> Void in
      switch result {
      case .success(let statusCode, let message, let rawBody):
        SOPLog.debug(message: "statusCode = \(statusCode), message = \(message), rawBody = \(rawBody)")
        SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Utility.currentTimeMillis())
      case .failed(let error):
        //do nothing
        SOPLog.error(message: "error = \(error.localizedDescription)")
      }
    })
  }

  public static func showSurveyList<T,R>(vc: UIViewController, profilingPointRule: T, researchPointRule: R) {
    
    guard let info = getSetupInfo() else {
      //TODO: should throw error?
      return
    }

    self.profilingPointRule = profilingPointRule as? ProfilingPointRule
    self.researchPointRule = researchPointRule as? ResearchPointRule
    
    viewController = SurveyListViewContoroller(nibName: "SurveyListViewContoroller", bundle: Bundle(identifier: "com.surveyon.partners.SurveyonPartners"))
    viewController!.modalPresentationStyle = .overCurrentContext
    vc.present(viewController!, animated: false, completion: nil)
    
    let httpClient = HttpClient(appId: info.appId,
                                appMid: info.appMid,
                                secretKey: info.secretKey,
                                sopHost: info.sopHost,
                                sopConsoleHost: info.sopConsoleHost,
                                updateSpan: info.idfaUpdateSpan,
                                useHttps: info.useHttps,
                                verifyHost: info.verifyHost)

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

  static func setSetupInfo(_ setupInfo: SetupInfo){
    queue.async(flags: .barrier) {
      SurveyonPartners.setupInfo = setupInfo
    }
  }

  static func getSetupInfo() -> SetupInfo?{
    var tmp: SetupInfo?
    queue.sync {
      tmp = setupInfo
    }
    return tmp
  }
}

extension SurveyonPartners {

  static func adIdUpdatedAt(currentTimeMilles: Int64) {
    PreferencesManager.writePreferences(value: currentTimeMilles, forKey: Constants.SURVEYON_PARTNERS)
  }
  
  static func isNeedAdIdUpdated(currentTimeMilles: Int64) -> Bool {
    guard let info = getSetupInfo() else {
      //TODO: should throw error?
      return false
    }

    let previousTimeMilles: Int64 = PreferencesManager.readIntPreferences(forKey: Constants.SURVEYON_PARTNERS)
    return info.idfaUpdateSpan <= (currentTimeMilles - previousTimeMilles)
  }
}
