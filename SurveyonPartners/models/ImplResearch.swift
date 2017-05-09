//
//  ImpleResearch.swift
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

struct ImplResearch: Research, SurveyListItem {

  var surveyId: String
  
  var title: String
  
  var loi: String
  
  var url: String
  
  var quotaId: String
  
  var cpi: String
  
  var ir: String

  var isAnswered: Bool
  
  var isClosed: Bool
  
  var isFixedLoi: Bool
  
  var isNotifiable: Bool
  
  var date: String
  
  var blockedDevices: [String: Bool]
  
  var extraInfo: [String: AnyObject]

  var surveyIdLabel: String { get {return "r" + surveyId} }

  var name: String { get {return ""} }

  init(json: [String: AnyObject]) {
    self.surveyId = json["survey_id"] as! String
    self.title = json["title"] as! String
    self.loi = json["loi"] as! String
    self.url = json["url"] as! String
    self.quotaId = json["quota_id"] as! String
    self.cpi = json["cpi"] as! String
    self.ir = json["ir"] as! String
    self.isAnswered = json["is_answered"] as! String == "1"
    self.isClosed = json["is_closed"] as! String == "1"
    self.isFixedLoi = json["is_fixed_loi"] as! String == "1"
    self.isNotifiable = json["is_notifiable"] as! String == "1"
    self.date = json["date"] as! String
    self.blockedDevices = [:]
    self.extraInfo = [:]
  }






  
  func isMobileBlocked() -> Bool {
    return true
//    let data = self.blockedDevices!.data(using: .utf8)
//    do {
//      let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
//      guard let blockedDevices = json?[Constants.KEY_BLOCKED_DEVICES] as? [String:Any] else {
//        return false
//      }
//      let mobileValue = blockedDevices[Constants.MOBILE_BLOCKED] as? Int
//      if mobileValue == 1 {
//        return true
//      } else {
//        return true
//      }
//    } catch {
//      return true
//    }
//  }
  }
}
