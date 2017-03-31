//
//  Research.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/31.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

class Research: SurveyListItemProtocol {
  
  static let MOBILE_BLOCKED = "MOBILE"
  
  var jsonObject: Data?
  
  var surveyId: String?
  
  var quotaId: String?
  
  var cpi: String?
  
  var ir: String?
  
  var loi: String?
  
  var isAnswered: String?
  
  var isClosed: String?
  
  var title: String?
  
  var url: String?
  
  var isFixedLoi: String?
  
  var isNotifiable: String?
  
  var date: String?
  
  var blockedDevices: String?
  
  var extraInfo: String?
  
  init(jsonObject: Data?) {
    
    self.jsonObject = jsonObject
    
    if let json = try? JSONSerialization.jsonObject(with: jsonObject!) as? [String:Any],
      let research = json?["research"] as? [String:Any],
      let surveyId = research["survey_id"] as? String,
      let quotaId = research["quota_id"] as? String,
      let cpi = research["cpi"] as? String,
      let ir = research["ir"] as? String,
      let loi = research["loi"] as? String,
      let isAnswered = research["is_answered"] as? String,
      let isClosed = research["is_closed"] as? String,
      let title = research["title"] as? String,
      let url = research["url"] as? String,
      let isFixedLoi = research["is_fixed_loi"] as? String,
      let isNotifiable = research["is_notifiable"] as? String,
      let date = research["date"] as? String {
      self.surveyId = surveyId
      self.quotaId = quotaId
      self.cpi = cpi
      self.ir = ir
      self.loi = loi
      self.isAnswered = isAnswered
      self.isClosed = isClosed
      self.title = title
      self.url = url
      self.isFixedLoi = isFixedLoi
      self.isNotifiable = isNotifiable
      self.date = date
    } else {
      SOPLog.error(message: "bad json")
    }
  }
  
}
