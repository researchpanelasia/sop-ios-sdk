//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public struct SurveyonPartners {
  
  // after 14 days, update idfa
  static let DEFAULT_IDFA_UPDATE_SPAN: Int64 = 60 * 60 * 24 * 14 * 1000
  
  static let DEFAULT_SOP_HOST = "partners.surveyon.com"
  
  static let DEFAULT_SOP_CONSOLE_HOST = "console.partners.surveyon.com"
  
  static var setupInfo: SetupInfo?
  
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
      httpClient.updateIdfa(completion: { (isSuccess) -> Void in
        if isSuccess {
          print("@@@@@ Success @@@@@")
          SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Utility.currentTimeMillis())
        } else {
          print("@@@@@ Failure @@@@@")
          //do nothing
        }
      })
    }
    
  }
  
  public static func showSurveyList<T,R>(profilingPointRule: T, researchPointRule: R) {
    
    let httpClient = HttpClient(appId: setupInfo!.appId!,
                                appMid: setupInfo!.appMid!,
                                secretKey: setupInfo!.secretKey!,
                                sopHost: setupInfo!.sopHost!,
                                sopConsoleHost: setupInfo!.sopConsoleHost!,
                                updateSpan: setupInfo!.idfaUpdateSpan!,
                                useHttps: setupInfo!.useHttps!,
                                verifyHost: setupInfo!.verifyHost!)
    
    httpClient.getSurveyList(completion: { (isSuccess) -> Void in
      if isSuccess {
        print("##### Success #####")
        
//        if SurveyListItemFactory.SurveyListArray.count > 0 {
//          for index in 0..<SurveyListItemFactory.SurveyListArray.count {
//            print("surveyList.title = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).title!)")
//            print("surveyList.surveyId = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).surveyId!)")
//            print("surveyList.loi = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).loi!)")
//            print("surveyList.url = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).url!)")
//          }
//        }
        
      } else {
        print("##### Failure #####")
        //do nothing
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
