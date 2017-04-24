//
//  SurveyonPartners.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public class SurveyonPartners: UIViewController {
  
  // after 14 days, update idfa
  static let DEFAULT_IDFA_UPDATE_SPAN: Int64 = 60 * 60 * 24 * 14 * 1000
  
  static let DEFAULT_SOP_HOST = "partners.surveyon.com"
  
  static let DEFAULT_SOP_CONSOLE_HOST = "console.partners.surveyon.com"
  
  static var viewController: UIViewController?
  
  static var setupInfo: SetupInfo?
  
  
  // ------------------ remove ------------------
  fileprivate lazy var interactor = InteractiveTransition()
  
  fileprivate var presentationManager: PresentationManager!
  
//  public var viewController: UIViewController
  
//  var surveyListView: SurveyListView = SurveyListView()
//  
//  public convenience init<T,R>(profilingPointRule: T, researchPointRule: R) {
//    let viewController = SurveyonPartnersDefaultViewController()
//    self.init(viewController: viewController)
//    
//  }
//  
//  public init(viewController: UIViewController) {
////    self.viewController = viewController
//    super.init(nibName: nil, bundle: nil)
//    
//    let bundleIdentifier = "com.surveyon.partners.SurveyonPartners"
//    let bundle = Bundle(identifier: bundleIdentifier)
//    let customViews = bundle?.loadNibNamed("SurveyListView", owner: self, options: nil)?.first as! UIView
//    
//    self.presentationManager = PresentationManager(interactor: interactor)
//    
////    self.interactor.viewController = self
//    
////    transitioningDelegate = presentationManager
//    modalPresentationStyle = .custom
//    
////    addChildViewController(viewController)
//    view = customViews
//    
//    //UINib(nibName: "SurveyList", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//    //    self.view = customView//bundle?.loadNibNamed("SurveyList", owner: self, options: nil)?.first as! UIView
//    
//  }
//  
//  required public init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  override public func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//  }
//
  
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
          SOPLog.debug(message: "setUP() Success")
          SurveyonPartners.adIdUpdatedAt(currentTimeMilles: Utility.currentTimeMillis())
        } else {
          //do nothing
          SOPLog.debug(message: "setUP() Fail")
        }
      })
    }
    
  }
  
  public static func showSurveyList<T,R>(vc: UIViewController,profilingPointRule: T, researchPointRule: R) {
    
    viewController = SurveyListViewContoroller(nibName: "SurveyListViewContoroller", bundle: Bundle(identifier: "com.surveyon.partners.SurveyonPartners"))
    viewController!.modalPresentationStyle = .overCurrentContext
    vc.present(viewController!, animated: false, completion: nil)
    
//    let bundleIdentifier = "com.surveyon.partners.SurveyonPartners"
//    let bundle = Bundle(identifier: bundleIdentifier)
//    let customViews = bundle?.loadNibNamed("SurveyListView", owner: self, options: nil)?.first as! UIView
    
//    let httpClient = HttpClient(appId: setupInfo!.appId!,
//                                appMid: setupInfo!.appMid!,
//                                secretKey: setupInfo!.secretKey!,
//                                sopHost: setupInfo!.sopHost!,
//                                sopConsoleHost: setupInfo!.sopConsoleHost!,
//                                updateSpan: setupInfo!.idfaUpdateSpan!,
//                                useHttps: setupInfo!.useHttps!,
//                                verifyHost: setupInfo!.verifyHost!)
//    
//    httpClient.getSurveyList(completion: { (isSuccess) -> Void in
//      if isSuccess {
//        SOPLog.debug(message: "getSurveyList() Success")
////        let cookiePoint = profilingPointRule as! ProfilingPointRule
////        let pro = SurveyListItemFactory.SurveyListArray[0] as! Profiling
////        print("cookiePoint = \(cookiePoint.cookieProfilingPoint(profiling: pro))")
//        
////        if SurveyListItemFactory.SurveyListArray.count > 0 {
////          for index in 0..<SurveyListItemFactory.SurveyListArray.count {
////            print("surveyList.title = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).title!)")
////            print("surveyList.surveyId = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).surveyId!)")
////            print("surveyList.loi = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).loi!)")
////            print("surveyList.url = \((SurveyListItemFactory.SurveyListArray[index] as! SurveyListItemProtocol).url!)")
////          }
////        }
//        
//      } else {
//        //do nothing
//        SOPLog.debug(message: "showSurveyList() Fail")
//      }
//    })
    
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
